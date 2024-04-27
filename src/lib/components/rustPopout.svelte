<script lang="ts">
    export let href: string;
</script>


<a href={href} class="hover:scale-125 hover:rotate-6 rounded transition-all inline-block text-transparent bg-gradient-to-b bg-clip-text from-green-400 to-green-700">
    <slot />
</a><!--

--><img class="ferris transition-all" src="https://www.rustacean.net/assets/rustacean-flat-happy.svg" alt="Ferris">


<style lang="postcss">
    .ferris {
        opacity: 0;
        display: inline;
        width: 4rem;
        position: absolute;
        transform: translate(0.5em, 1em);
    }

    :hover + .ferris {
        opacity: 1;
        transform: translate(0em, 0em) rotate(-8deg);
    }
</style>
