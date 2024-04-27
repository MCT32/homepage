<script lang="ts">
    import "../app.css";
    import PhCaretLeft from "virtual:icons/ph/caret-left-bold";
    import SvelteLogo from "virtual:icons/logos/svelte-icon";
    import NavItem from "$lib/components/navItem.svelte";
    import MobileNavItem from "$lib/components/mobileNavItem.svelte";
</script>


<svelte:head>
    <meta property="og:title" content="MCT32.xyz" />
    <meta property="og:type" content="website" />
    <meta property="og:url" content="https://mct32.xyz/" />
    <meta property="og:image" content="https://mct32.xyz/pfpv3.png" />
    <meta property="og:description" content="Hello! I'm MCT32, a developer who can't seem to finish his projects... I work on a bunch of different types of projects. I've done some web stuff, system programing languages stuff, and even some Minecraft modding. My favorite language right now is Rust." />
</svelte:head>

<div class="relative min-h-screen pb-10">
    <nav class="shadow-xl flex items-center sticky top-0 w-full bg-zinc-800 h-16">
        <span class="text-transparent bg-gradient-to-br bg-clip-text from-green-400 to-green-600 font-extrabold text-5xl w-fit px-2.5">MCT32.XYZ</span>

        <div class="md:flex hidden ml-10 text-lg h-full">
            <NavItem name="Home" href="/" />
            <NavItem name="Projects" href="/projects" />
            <NavItem name="About" href="/about" />
        </div>

        <div class="ml-auto md:hidden group overflow-x-hidden">
            <button class="h-16 w-16 flex justify-center items-center">
                <PhCaretLeft class="text-white" />
            </button>

            <div class="group-hover:w-36 w-0 group-hover:px-6 px-0 overflow-hidden transition-all absolute bg-zinc-800 shadow-xl right-0 text-2xl font-semibold">
                <MobileNavItem name="Home" href="/" />
                <MobileNavItem name="Projects" href="/projects" />
                <MobileNavItem name="About" href="/about" />
            </div>
        </div>
    </nav>

    <slot />

    <footer class="bg-zinc-900 text-white text-center py-3 absolute bottom-0 w-full">
        Made with Svelte • <SvelteLogo class="inline" />
    </footer>
</div>
