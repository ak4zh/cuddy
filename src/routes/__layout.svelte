<script type="ts">
	import { browser } from '$app/env';
	import { goto } from '$app/navigation';
	import { navigating, page } from '$app/stores';
	import Loader from '$lib/components/Loader.svelte';
	import { pagesTable, user } from '$lib/db';
	import { loading } from '$lib/utils/stores';
	import { darkMode } from '$lib/utils/userPref';
	import { setContext } from 'svelte';
	import '../app.css';
	$: {
		if (browser) {
			if (!['/', '/auth'].includes($page.url.pathname) && !$user) {
				goto('/auth');
			}
		}
	}
	$: dark = $darkMode;

	async function fieldUpdate(event, data: Object) {
		data[event.target.id] = event.target.value || event.target.innerText;
		const { data: pagesData, error } = await pagesTable.updatePage($page.params.slug, data);
	}

	setContext('template', { fieldUpdate });
</script>

<div class:dark>
	<div
		class="bg-gray-50 dark:bg-gray-900 text-gray-900 dark:text-gray-300 min-h-screen break-words"
	>
		<div>
			{#if $navigating || $loading}
				<Loader />
			{/if}
			<slot />
		</div>
	</div>
</div>
