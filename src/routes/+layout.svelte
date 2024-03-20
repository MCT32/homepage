<script>
    import "../app.css";
</script>


<div class="relative min-h-screen">
    <nav class="shadow-xl p-2.5 flex items-center gap-x-10 sticky top-0 w-full bg-zinc-800">
    <h1 class="text-white font-extrabold text-5xl w-fit"><a href="https://mct32.xyz">MCT32.xyz</a></h1>

    <a href="/" class="w-fit text-white font-semibold">Home</a>
    <a href="/projects" class="w-fit text-white font-semibold">Projects</a>
    <a href="/about" class="w-fit text-white font-semibold">About</a>
    </nav>

    <div>
    <slot />
    </div>
</div>