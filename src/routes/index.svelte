<script type="ts">
	import CreatePage from '$lib/components/CreatePage.svelte';
	import NavBar from '$lib/components/NavBar.svelte';
	import { user } from '$lib/db';
</script>

<div class="bg-clouds h-screen">
    <NavBar />
    <div class="bg-amber-50">
        <div class="relative overflow-hidden">
            <div class="relative pt-6 pb-16 sm:pb-24">
                <div class="mx-auto mt-16 max-w-7xl px-4 sm:mt-24 sm:px-6">
                    <div class="text-center">
                        <h1
                            class="text-5xl font-bold tracking-tight text-gray-900 sm:text-6xl lg:text-7xl xl:text-8xl"
                        >
                            <span class="block">Create beautiful landing</span>
                            pages <span class="text-primary">in minutes.</span>
                        </h1>
                        <p class="mt-5 text-2xl text-gray-600">Your small house on the clouds.</p>
                        <div
                            class="mt-8 flex flex-col text-center sm:mt-12 sm:flex-row sm:items-center sm:justify-center sm:space-x-5"
                        >
                            {#if $user}
                                <CreatePage />
                            {:else}
                                <a href="/dashboard">
                                    <button class="flex-shrink-0 btn-primary" type="button">
                                        Create my landing page
                                    </button>
                                </a>
                            {/if}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
