<script lang="ts">
    import Github from "./github.svelte";
    import type {Repo} from "$lib/githubApi.svelte";

    export let count = 3;
    export let username: string;

    let err: string | null = null;

    let update_functions: Array<(err: string | null, repo: Repo | null) => void> = [];

    fetch('https://api.github.com/users/' + username + '/repos?sort=updated&per_page=' + count)
        .then(res => {
            if (!res.ok) {
                for (let i = 0; i < update_functions.length; i++) {
                    update_functions[i](res.statusText, null);
                }
            } else {
                let repos = res.json().then(repos => {
                    for (let i = 0; i < repos.length; i++) {
                        let repo = repos[i];
                        update_functions[i](err, repo);
                    }
                });
            }
        })
        .catch(err => {
            for (let i = 0; i < update_functions.length; i++) {
                update_functions[i](err, null);
            }
        })
</script>


<div class="border-2 border-zinc-600 p-6 rounded-xl flex flex-col gap-5">
    {#each {length: count} as _, i}
        <Github bind:update={update_functions[i]} />
    {/each}
</div>