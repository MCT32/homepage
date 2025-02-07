<script lang="ts">
    import PhHashBold from 'virtual:icons/ph/hash-bold';
    import PhCheckBold from 'virtual:icons/ph/check-bold';

    export let tag: string;

    let tags: {[key: string]: any} = {
        active: {
            colors: "bg-green-600 text-green-400",
            icon: PhCheckBold,
        }
    }

    let colors = "";
    let icon = undefined;

    if (tag in tags) {
        colors = tags[tag].colors;
        icon = tags[tag].icon;
    } else {
        colors = "bg-zinc-600 text-zinc-400";
        icon = PhHashBold;
    }
</script>

<div class="rounded-full px-2 {colors}">
    <svelte:component this={icon} class="inline" />
    {tag}
</div>
