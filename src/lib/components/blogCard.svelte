<script lang="ts">
    import { goto } from "$app/navigation";
    import BlogTag from "./blogTag.svelte";

    export let link: string;
    export let title: string;
    export let description: string;
    export let image: string = "";
    export let tags: string[] = [];
</script>

<div class="relative w-fill h-52 border rounded-md border-zinc-500 p-3 cursor-pointer transition hover:scale-105" style="background-image: url('{image}');" on:click={() => goto(link)}>
    <h2 class="text-white font-bold text-xl">{title}</h2>

    <div class="flex gap-1">
        {#each tags as tag}
            <BlogTag {tag} />
        {/each}
    </div>

    <p>{description}</p>

    <div class="absolute top-0 left-0 w-full h-full hover:bg-zinc-500 hover:bg-opacity-10 active:bg-opacity-25" />
</div>
