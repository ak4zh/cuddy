<script lang="ts">
	import { goto } from '$app/navigation';
	import { page } from '$app/stores';
	import { user, auth } from '$lib/db';
	import { darkMode } from '$lib/utils/userPref';
</script>

<header class="p-4">
	<div class="flex flex-col md:flex-row justify-between place-items-center m-4">
		<h2 class="!text-transparent bg-clip-text bg-gradient-to-r from-amber-500 to-amber-600">
			<a class="text-5xl font-bold" href="/">Cuddy</a>
		</h2>
		<div class="flex gap-4">
			{#if $page.url.pathname !== '/dashboard'}
				{#if $user}
					<a sveltekit:prefetch href="/dashboard">
						<button class="flex-shrink-0 btn-secondary" type="button">
							My pages
						</button>
					</a>
				{:else}
					<a href="/dashboard">
						<button class="flex-shrink-0 btn-secondary" type="button">
							Get started for free
						</button>
					</a>
				{/if}
			{/if}
			{#if $user}
				<button on:click={() => auth.signOut()} class="flex-shrink-0 btn-primary" type="button">
					Log Out
				</button>
			{/if}
		</div>
	</div>
</header>
