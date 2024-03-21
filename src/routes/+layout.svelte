<script lang="ts">
    import "../app.css";
    import PhCaretLeft from "virtual:icons/ph/caret-left-bold";
</script>


<svelte:head>
    <meta property="og:title" content="MCT32.xyz" />
    <meta property="og:type" content="website" />
    <meta property="og:url" content="https://mct32.xyz/" />
    <meta property="og:image" content="https://mct32.xyz/pfpv3.png" />
    <meta property="og:description" content="Hello! I'm MCT32, a developer who can't seem to finish his projects... I work on a bunch of different types of projects. I've done some web stuff, system programing languages stuff, and even some Minecraft modding. My favorite language right now is Rust." />
</svelte:head>

<div class="relative min-h-screen">
    <nav class="shadow-xl flex items-center sticky top-0 w-full bg-zinc-800 h-16">
        <h1 class="text-white font-extrabold text-5xl w-fit px-2.5"><a href="https://mct32.xyz">MCT32.xyz</a></h1>

        <div class="md:flex gap-x-10 hidden ml-10">
            <a href="/" class="w-fit text-white font-semibold">Home</a>
            <a href="/projects" class="w-fit text-white font-semibold">Projects</a>
            <a href="/about" class="w-fit text-white font-semibold">About</a>
        </div>

        <div class="ml-auto md:hidden group overflow-x-hidden">
            <button class="h-16 w-16 flex justify-center items-center">
                <PhCaretLeft class="text-white" />
            </button>

            <div class="group-hover:w-64 w-0 group-hover:px-6 px-0 overflow-hidden transition-all absolute bg-zinc-800 shadow-xl right-0 text-2xl text-white font-semibold">
                <a href="/" class="block py-3">Home</a>
                <a href="/projects" class="block py-3">Projects</a>
                <a href="/about" class="block py-3">About</a>
            </div>
        </div>
    </nav>

    <div>
        <slot />
    </div>
</div>
