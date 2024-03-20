<script lang="ts">
    export let href: string;
</script>


<a href={href} class="underline hover:scale-125 hover:bg-white hover:text-zinc-800 hover:rotate-6 rounded transition-all inline-block">
    <slot />
</a>
