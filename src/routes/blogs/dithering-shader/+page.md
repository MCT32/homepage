<title>Stylised dithering shader in Unity</title>

<svelte:head>
    <meta property="og:title" content="Stylised dithering shader in Unity" />
    <meta property="og:type" content="website" />
    <meta property="og:url" content="https://mct32.xyz/blogs/dithering-shader" />
    <meta property="og:image" content="https://mct32.xyz/pfpv3.png" />
    <meta property="og:description" content="Unity shader with a stylised dithering effect." />
</svelte:head>

# Stylised dithering shader in Unity

In this post, I'll be making a highly customisable shader for Unity which renders a stylised, pixelated dithering effect. I will be exploring how it works and experimenting with what kinds of effects can be made using it. The final product is available [here]() and can be freely used by anyone in their projects, however I recommend you stick around to learn a little bit about its inner workings.

## Base shader, before dithering

Before getting the dithering effect we want on our shader, we need a base shader to apply the effect to. To start, we'll just make a basic diffuse shader without any specular or ambient light. To do this, all we need to do is render the [dot product](https://en.wikipedia.org/wiki/Dot_product) between our view direction and the sirection of the sun. Before rendering the diffuse light, here is the shader we will be starting out with:

```shaderlab
Shader "Custom/DitheredShader"
{
    Properties
    {
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // Render every pixel white
                fixed4 col = fixed4(1, 1, 1, 1);
                
                return col;
            }
            ENDCG
        }
    }
}
```

This shader is just Unity's template unlit shader with fog and texturing removed. With this current shader, here is the result we get:

![Result of the current unlit shader](/blogs/dithering-shader/unlit.png "Unlit shader")

### Diffuse effect

In order to create the diffuse effect we want, we first need to figure out where the light is coming from. In order to do this, Unity provides a function called `ObjSpaceLightDir` that will give us the direction to the main light source. We then need to compute the dot product between the light direction and the surface normal of our object to get our desired result. Luckily, since both the light direction and the normals we get are both in object space, no other conversions are needed.

```shaderlab
CGPROGRAM
#pragma vertex vert
#pragma fragment frag

#include "UnityCG.cginc"

struct v2f
{
    float4 vertex : SV_POSITION;
    float3 normal : NORMAL; // Pass normal from vertex shader to fragment shader    // [!code highlight]
};

v2f vert (appdata_base v)
{
    v2f o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.normal = v.normal;    // Add normal to v2f struct // [!code highlight]
    return o;
}

fixed4 frag (v2f i) : SV_Target
{
    // Compute the diffuse  // [!code highlight:2]
    float diffuse = dot(ObjSpaceLightDir(i.vertex), i.normal);

    fixed4 col;
    col.rgb = float3(diffuse, diffuse, diffuse);    // Add the diffuse to the color as grayscale    // [!code highlight]
    col.a = 1;                                      // Set alpha to full

    return col;
}
ENDCG
```

Here's the result we get:

![Result of the diffuse shader](/blogs/dithering-shader/diffuse.png "Diffuse shader")

Notice that the diffuse covers half of the sphere black on the opposite side to the light. This is how diffuse light should look and would usually be lit by ambient lighting, but since we aren't using ambient lighting, it can look a little unnatural. To fix this, I will add a shader parameter that will allow us to control what proportion of the object is lit by the diffuse lighting. This allows us to fine tune the look of the shader, and could also be used in the future to create other effects, such as specular lighting. To acheive this effect, we will need to do some maths with the diffuse result in order to scale it properly. Here is the updated code:

```hlsl
fixed4 frag (v2f i) : SV_Target
{
    // Compute the diffuse
    float diffuse = dot(ObjSpaceLightDir(i.vertex), i.normal);

    diffuse -= 1;               // Subtract by one to value can be scaled from the upper bound  // [!code highlight:3]
    diffuse /= _DiffuseSize;    // Inversely cale the diffuse based on the _DiffuseSize property
    diffuse += 1;               // Return bounds back to normal after scaling

    fixed4 col;
    col.rgb = float3(diffuse, diffuse, diffuse);    // Add the diffuse to the color as grayscale
    col.a = 1;                                      // Set alpha to full

    return col;
}
```

And the new result:

![Demonstrating the effect of the diffuse size slider](/blogs/dithering-shader/diffuse-size.gif "Diffuse size slider")

## Dithering effect

Not that we have our base shader lighting, we can not start work on making the actual dithering shader. Before we can do that, we need to understand how dithering works. The type of dithering we will be using is ordered dithering, as it creates the stylised effect that I want. Ordered dithering works by overlaying a tiled threshold map over what is being rendered and then comparing the color with the threshold to decide what the resulting color should be. This might be a little hard to understand, but it becomes a lot simpler with grayscale instead of color, and using only 2 shades. As an example, lets say that our threshold map is simply one color, half brightness gray, halfway between white and black.
For this example, the left side is the color we will be converting, the middle is the threshold, and the right is the resulting quantised result. Here, the input shade on the left is darker than the threshold in the middle, so the result gets "rounded down" to black.

![Input darker than threshold, resulting in rounding down](/blogs/dithering-shader/threshold-darker.png "Threshold comparison")

Using the same threshold, this next example has the input color brighter then the threshold, so the color is "rounded up" to white.

![Input lighter than threshold, resulting in rounding up](/blogs/dithering-shader/threshold-lighter.png "Threshold comparison")

This might be a confusing explaination, so here is another representation. The top strip in this image represents then input shade, and the bottom strip is the result. in this case, since the entire map is one color, the result is just black and white split in the middle.

![Only 2 colors and no dithering](/blogs/dithering-shader/grad-no-map.png "Undithered gradient map")

Now with this information, lets impliment this in our shader.

```hlsl
fixed4 frag (v2f i) : SV_Target
{
    // Compute the diffuse
    float diffuse = dot(ObjSpaceLightDir(i.vertex), i.normal);

    diffuse -= 1;               // Subtract by one to value can be scaled from the upper bound
    diffuse /= _DiffuseSize;    // Inversely cale the diffuse based on the _DiffuseSize property
    diffuse += 1;               // Return bounds back to normal after scaling

    // Compare input with threshold to get result. 0.5 is our threshold // [!code highlight:2]
    diffuse = diffuse > 0.5 ? 1 : 0;

    fixed4 col;
    col.rgb = float3(diffuse, diffuse, diffuse);    // Add the diffuse to the color as grayscale
    col.a = 1;                                      // Set alpha to full

    return col;
}
```

And here is the result:

![Shader without dithering, resulting in 2 distinct colors](/blogs/dithering-shader/no-dithering.png "Undithered shader")

Ok, the result isn't very flattering, but thats to be expected. Since there is no threshold map, to just rounds all the shades up or down, resulting in 2 clearly visible colors. Now that that's out of the way, let's look at how we can use a threshold map to acheive the result we want.

### Threshold map

There are many types of threshold maps that can be used, all with different looking results. The threshold map we will be using is the Bayer matrix. It's likely the most common threshold map to be used with ordered dithering, it creates the effect we are looking for and it allows a convenient feature for the shader later on. All we have to do is overlay the tiled matrix in screen space and compare the individual pixels. Github user [tromero](https://github.com/tromero) has created [this repository](https://github.com/tromero/BayerMatrix) with a python script to generate Bayer matrices as well as pre-calculated matrices which we can use. To begin with, we'll use the smallest Bayer matrix, 2x2. Heres an upscaled version so its easier to see:

![Upscaled 2x2 Bayer matrix](/blogs/dithering-shader/bayer2-upscaled.png "2x2 Bayer matrix")

Now lets do the same comparison as before, but we will use the Bayer matrix as the threshold. Once again, the left is the input shade, in this case halfway between black and white, the middle is the threshod map, and the right is the result.

![Input is lighter than half and darker than half of the threshold, resulting in a pattern](/blogs/dithering-shader/bayer2.png "Bayer 2x2 comparison")

As you can see, in the top left pixel, the input is brighter than the threshold to the output is rounded up to white, and with the top right vise versa, and so on. this creates a pattern that when repeated and seen from further away looks like halfway between black and white. Heres how it looks when its repeated. As you can tell, it looks like a solid gray at a glance.

![Half tone effect created by Bayer pattern](/blogs/dithering-shader/bayer-half.png "Half tone dither")
