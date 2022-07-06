<script>
	import CreatePage from '$lib/components/CreatePage.svelte';
	import * as Templates from '$lib/components/templates';

	let template = Templates['Simple'];
</script>

<div class="py-6">
	<div class="max-w-7xl mx-auto px-4 sm:px-6 md:px-8 flex">
		<h1 class="text-2xl font-semibold text-gray-900 ">Dashboard</h1>
		<CreatePage />
	</div>

	<div class="max-w-7xl mx-auto px-4 sm:px-6 md:px-8 items-center">
		<!-- Replace with your content -->
		<div class="py-4">
			<div
				class="border-4 border-dashed border-gray-200 rounded-lg h-96 flex justify-center items-center "
			>
				<h3>No have not created any pages.</h3>
			</div>
		</div>
		<!-- /End replace -->
	</div>
</div>
