<script lang="ts">
    import type {Repo} from "$lib/githubApi.svelte";

    export function update(err: string | null, repo: Repo | null) {
        if (err) {
            name = err;
        } else {
            if (repo) {
                name = repo.name;
                desc = repo.description;
            }
        }
    }

    let name = "test";
    let desc = "test";
</script>


<div class="border-2 border-zinc-600 p-6 rounded-xl">
    <h1 class="text-white text-2xl m-0">{name}</h1>
    <p class="text-zinc-500 text-center m-0">{desc}</p>
</div>