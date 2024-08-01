<script lang="ts">
    import Popout from "$lib/components/popout.svelte";
    import RustPopout from "$lib/components/rustPopout.svelte";
    import GithubGroup from "$lib/components/githubGroup.svelte";


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

<div class="bg-zinc-800 p-24 flex-grow">
    <div class="flex">
        <p class="text-white text-5xl p-10 font-semibold grow">
            Hello! I'm <Popout href="https://github.com/MCT32">MCT32</Popout>, a developer who can't seem to finish his projects...
            <br>
            I work on a bunch of different types of projects. I've done some web stuff, system programing languages stuff, and even some Minecraft modding.
            My favorite language right now is <RustPopout href="https://www.rust-lang.org/">Rust</RustPopout>.
        </p>
    </div>

    <GithubGroup username="MCT32" />
</div>


<style lang="postcss">
    
</style>
