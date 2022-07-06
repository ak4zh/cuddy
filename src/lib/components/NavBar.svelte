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
				<a href="/dashboard">
					<button class="flex-shrink-0 btn-secondary" type="button">
						{#if $user}My pages{:else}Get started for free{/if}
					</button>
				</a>
			{/if}
			{#if $user}
				<button on:click={() => auth.signOut()} class="flex-shrink-0 btn-primary" type="button">
					Log Out
				</button>
			{/if}
		</div>
	</div>
</header>
