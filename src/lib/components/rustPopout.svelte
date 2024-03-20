<script lang="ts">
    export let href: string;
</script>


<a href={href} class="underline hover:scale-125 hover:bg-white hover:text-zinc-800 hover:rotate-6 rounded transition-all inline-block">
    <slot />
</a>

<img class="ferris transition-all" src="https://www.rustacean.net/assets/rustacean-flat-happy.svg" alt="Ferris">


<style lang="postcss">
    .ferris {
        opacity: 0;
        display: inline;
        width: 4rem;
        position: fixed;
        transform: translate(0.5em, 1em);
    }

    :hover + .ferris {
        opacity: 1;
        transform: translate(0em, 0em) rotate(-8deg);
    }
</style>
