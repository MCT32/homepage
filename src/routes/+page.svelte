<script lang="ts">
    import Popout from "$lib/components/popout.svelte";
    import RustPopout from "$lib/components/rustPopout.svelte";
</script>


<head>
    <title>MCT32.xyz</title>
</head>

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
</style>
