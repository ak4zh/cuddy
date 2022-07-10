<script>
	import CreatePage from '$lib/components/CreatePage.svelte';
	import { pagesTable } from '$lib/db';

	let pages = [];

	async function loadPages() {
		const {data, error} = await pagesTable.all();
		pages = data
		return data
	}

</script>

<div class="py-6">
	<div class="max-w-7xl mx-auto px-4 sm:px-6 md:px-8 flex flex-col md:flex-row gap-4">
		<h1 class="text-2xl font-semibold text-gray-900 ">Dashboard</h1>
		<CreatePage />
	</div>

	<div class="max-w-7xl mx-auto px-4 sm:px-6 md:px-8 items-center">
		<!-- Replace with your content -->
		<div class="py-4">
			<div class="border-4 border-dashed border-gray-200 rounded-lg min-h-96">
				{#await loadPages()}
					<p>Loading pages...</p>
				{:then pages}
					{#if pages}
						<div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4 m-6">
							{#each pages as page}
								<div class="max-w-md py-4 px-8 bg-amber-200 shadow-lg rounded-3xl m-2 hover:shadow-2xl shadow">
									<div class="text-center">
										<a href="/{page.slug}" target="bla" class="inline-flex">
											<h2 class="text-gray-800 text-3xl font-semibold underline decoration-dotted">{page.slug}</h2>
											<svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M11 3a1 1 0 100 2h2.586l-6.293 6.293a1 1 0 101.414 1.414L15 6.414V9a1 1 0 102 0V4a1 1 0 00-1-1h-5z"></path><path d="M5 5a2 2 0 00-2 2v8a2 2 0 002 2h8a2 2 0 002-2v-3a1 1 0 10-2 0v3H5V7h3a1 1 0 000-2H5z"></path></svg>
										</a>
									</div>
									<div class="flex justify-end mt-4 gap-4">
										<a sveltekit:prefetch href="/dashboard/pages/{page.slug}">
											<button class="btn-secondary">Edit</button>
										</a>
										<a href="/{page.slug}" target="blank">
											<button class="btn-secondary">Preview</button>
										</a>
									</div>
								</div>
							{/each}
						</div>
					{/if}
				{:catch error}
					<p style="color: red">{error.message}</p>
				{/await}
				{#if !pages.length}
					<h1 class="text-center items-center text-2xl">You have not created any pages yet.</h1>
				{/if}
			
				
			</div>
		</div>
		<!-- /End replace -->
	</div>
</div>
