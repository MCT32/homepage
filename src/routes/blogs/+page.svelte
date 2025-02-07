<script lang="ts">
    import BlogCard from "$lib/components/blogCard.svelte";

    let blogs = [
        {
            link: "/blogs/cloak-shader",
            title: "Spy Cloak Shader",
            description: "Reverse engineering and recreating the Spy's cloak shader in Unity",
            tags: ["unity", "shaders"]
        },
        {
            link: "/blogs/test",
            title: "Test",
            description: "Lorem ipsum odor amet, consectetuer adipiscing elit.",
            image: "/pfpv3.png",
            tags: ["active", "test"]
        },
        {
            link: "/blogs/test",
            title: "Test",
            description: "Lorem ipsum odor amet, consectetuer adipiscing elit."
        },
        {
            link: "/blogs/test",
            title: "Test",
            description: "Lorem ipsum odor amet, consectetuer adipiscing elit."
        },
        {
            link: "/blogs/test",
            title: "Test",
            description: "Lorem ipsum odor amet, consectetuer adipiscing elit."
        },
        {
            link: "/blogs/test",
            title: "Test",
            description: "Lorem ipsum odor amet, consectetuer adipiscing elit."
        },
        {
            link: "/blogs/test",
            title: "Test",
            description: "Lorem ipsum odor amet, consectetuer adipiscing elit."
        },
    ]
</script>


<div class="grid grid-cols-4 gap-5">
    {#each blogs as blog}
        <BlogCard link={blog.link} title={blog.title} description={blog.description} image={blog.image} tags={blog.tags} />
    {/each}
</div>
