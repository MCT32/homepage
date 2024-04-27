<script lang="ts">
    import { page } from '$app/stores';  

    export let name: string;
    export let href: string;

    const current = href == $page.url.pathname;
</script>


<div class="w-24 h-full relative group" data-sveltekit-reload>
    <a {href} class="text-transparent bg-gradient-to-b bg-clip-text from-green-400 to-green-700 font-semibold text-center block w-full top-1/2 absolute -translate-y-1/2">{name}</a>
    <div class="bg-gradient-to-b from-green-500 to-green-700 { current ? "w-1/2" : "w-1/4" } h-1.5 absolute bottom-0 left-1/2 -translate-x-1/2 group-hover:w-3/4 transition-all" />
</div>