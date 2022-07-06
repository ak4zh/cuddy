<script type="ts">
	import { pagesTable } from '$lib/db';
	import toast from 'svelte-french-toast';

	import slugify from 'slugify';
	import { goto } from '$app/navigation';
	let text = '';
	$: slug = slugify(text).toLowerCase();
	let available = true;
	let invalid = false;
	let disabled = false;
	$: console.log(slug);
	$: disabled = available == true && invalid == false ? false : true;
	$: (async () => {
		console.log(slug);
		if (slug) {
			const { data, error } = await pagesTable.checkAvailability(slug);
			if (error) {
				toast.error(error.message);
			} else if (data.length === 0) {
				available = true;
			} else {
				available = false;
			}
		}
	})();

	async function createPage() {
		const { data, error } = await pagesTable.createPage(slug);
		if (error) {
			toast.error(error.message);
		} else {
			toast.success('Page created successfully');
			goto(`/dashboard/pages/${slug}`);
		}
	}
</script>

<form class="mt-1 mx-auto max-w-5xl flex flex-col sm:flex-row rounded-full shadow-sm gap-4">
	<div class="flex">
		<span
			class="inline-flex items-center px-3 rounded-l-md border border-r-0 border-gray-300 bg-gray-50 text-gray-500 text-sm"
		>
			https://cuddy.me/</span
		>
		<input
			bind:value={text}
			type="text"
			name="company-website"
			id="company-website"
			class="focus:ring-indigo-500 focus:border-indigo-500 flex-1 block w-full rounded-none rounded-r-md sm:text-sm border-gray-300"
			placeholder="my-awesome-page"
		/>
	</div>
	<button class="flex-shrink-0 btn-primary" type="button" {disabled} on:click={() => createPage()}>
		Create my landing page
	</button>
</form>
