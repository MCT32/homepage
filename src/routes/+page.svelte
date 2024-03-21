<script lang="ts">
    import Popout from "$lib/components/popout.svelte";
    import RustPopout from "$lib/components/rustPopout.svelte";


    let splashes = [
        "11/10 cock",
        "Free Randall Thymes!",
        "Fuck you Nvidia!",
        "Arch btw",
        "Hello, World!",
        "Are you a robot?"
    ]

    let splash = splashes[Math.floor(Math.random() * splashes.length)];
</script>


<svelte:head>
    <title>MCT32.xyz</title>
</svelte:head>

<div class="w-3/4 mx-auto my-[10vw] text-center relative -z-10">
    <img src="/minecraft_title.png" alt="Minecraft-style title">
    <div class="splash-container">
        <span class="splash">{splash}</span>
    </div>
</div>

<p class="text-white text-3xl p-10 font-semibold max-w-[40rem]">
    Hello! I'm <Popout href="https://github.com/MCT32">MCT32</Popout>, a developer who can't seem to finish his projects...
    <br>
    I work on a bunch of different types of projects. I've done some web stuff, system programing languages stuff, and even some Minecraft modding.
    My favorite language right now is <RustPopout href="https://www.rust-lang.org/">Rust</RustPopout>.
</p>


<style lang="postcss">
    :global(body) {
        background-color: theme('colors.zinc.800');
        overflow-x: hidden;
    }

    @font-face { font-family: Minecraftia; src: url('/Minecraftia.ttf'); } 

    @keyframes pulse {
        0% {
            transform: scale(1, 1) rotate(-20deg);
        }

        50% {
            transform: scale(1.1, 1.1) rotate(-20deg);
        }

        100% {
            transform: scale(1, 1) rotate(-20deg);
        }
    }

    .splash {
        font-size: 3vw;
        width: 50vw;
        font-family: Minecraftia;
        color: #ff0;
        text-shadow: 0.3vw 0.3vw black;
    }

    .splash-container {
        position: absolute;
        right: 0;
        bottom: 0;
        animation: pulse 0.5s linear infinite;
    }
</style>
