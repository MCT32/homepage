<script lang="ts">
    export let href: string;
</script>


<a href={href} class="hover:scale-125 hover:rotate-6 rounded transition-all inline-block text-transparent bg-gradient-to-b bg-clip-text from-green-400 to-green-700">
    <slot />
</a>
