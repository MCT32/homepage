# Recreating the Spy's cloak shader in Unity

I'm currently learning how to make graphical shaders for videogames, and what better way than to recreate a classic effect from an amazing game, the Spy's cloak from [Team Fortress 2](https://www.teamfortress.com/)! Although I am an experienced programmer, one section of programming I am not super familiar with is graphics programming. I'm doing this project to help me learn by recreating an effect I an already familiar with. I've decided to document this project as I have not seen anyone else recreate this effect faithfully in Unity. Since I am so new to the world of graphics programming, this likely won't be a very optimised shader, but I hope this post can still be useful or interesting to you. Anyway, lets carry on.

## Shader passes/layout

Since the Spy is not always invisible, we need to be able to render our shader without the invisibility, then apply our effect on top of that. Also, since the refraction effect the shader uses needs to sample the background, we need to use `GrabPass` to get the background texture. While the effect could likely be acheived by blending the visible pass and the cloak pass, the source code for the original shader does some maths on the visible output. As such, I've decided to also grab a texture after that pass so I can sample it easily. However, this will capture the entire screen after the pass, when I only need the color of the same pixel of the previous pass. As such, this is not a very performant way to acheive this effect, but it's the only way I currently know of doing this.
So, with this layout in mind, here is our shader before the effect:

```hlsl
Shader "Custom/Cloak"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader
    {
        // Set shader to render alongside transparent materials
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        LOD 200

        // Get screen behind spy
        GrabPass { "_Background" }

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG

        // Capture the result of the surface shader
        GrabPass { "_Visible" }

        Pass {
            // Cloak effect goes here
        }
    }
    FallBack "Diffuse"
}
```
