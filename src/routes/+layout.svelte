<script>
    import "../app.css";
</script>


<svelte:head>
    <meta property="og:title" content="MCT32.xyz" />
    <meta property="og:type" content="website" />
    <meta property="og:url" content="https://mct32.xyz/" />
    <meta property="og:image" content="https://mct32.xyz/pfpv3.png" />
    <meta property="og:description" content="Hello! I'm MCT32, a developer who can't seem to finish his projects... I work on a bunch of different types of projects. I've done some web stuff, system programing languages stuff, and even some Minecraft modding. My favorite language right now is Rust." />
</svelte:head>

<div class="relative min-h-screen">
    <nav class="shadow-xl p-2.5 flex items-center gap-x-10 sticky top-0 w-full bg-zinc-800">
        <h1 class="text-white font-extrabold text-5xl w-fit"><a href="https://mct32.xyz">MCT32.xyz</a></h1>

        <a href="/" class="w-fit text-white font-semibold">Home</a>
        <a href="/projects" class="w-fit text-white font-semibold">Projects</a>
        <a href="/about" class="w-fit text-white font-semibold">About</a>
    </nav>

    <div>
        <slot />
    </div>
</div>