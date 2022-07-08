<script lang="ts">
	import { page } from '$app/stores';
	import * as Templates from '$lib/components/templates';
	import { pagesTable } from '$lib/db';
	import { demoData } from '$lib/utils/demoData';
	import { loading } from '$lib/utils/stores';
	import { getContext } from 'svelte';

	export let pageData: Object;
	let pageContent = pageData?.data || demoData;
	let currentTemplate = pageContent?.template;
	$: template = Templates[currentTemplate];
	const { fieldUpdate } = getContext('template');

	let contenteditable = false;
	
	async function saveChanges() {
		if (contenteditable) {
			loading.set(true)
			const { data: respData, error } = await pagesTable.updatePage($page.params.slug, pageContent);
			loading.set(false)
		}
		contenteditable = !contenteditable
		unique = {}
	}

	let unique = {}
</script>




<div class="max-w-5xl mx-auto">
	<div class="bg-amber-100 border-t-4 border-amber-500 rounded-b text-amber-900 px-4 py-3 shadow-md" role="alert">
		<div class="flex">
			<div class="py-1"><svg class="fill-current h-6 w-6 text-amber-500 mr-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M2.93 17.07A10 10 0 1 1 17.07 2.93 10 10 0 0 1 2.93 17.07zm12.73-1.41A8 8 0 1 0 4.34 4.34a8 8 0 0 0 11.32 11.32zM9 11V9h2v6H9v-4zm0-6h2v2H9V5z"/></svg></div>
			<div>
			<p class="font-bold">Simply click on the text you want to edit.</p>
			<p class="text-sm">Any change you make here, updates your page in realtime.</p>
			</div>
		</div>
	</div>
	<div class="col-span-6 sm:col-span-3 m-4 flex flex-col-2 justify-center gap-4">
		<div class="flex w-2/3">
			<label for="template" class="block text-sm font-medium text-gray-700">Change Template</label>
			<select
				id="template"
				on:change={(event) => fieldUpdate(event, data)}
				bind:value={currentTemplate}
				class="mt-1 block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
			>
				{#each Object.entries(Templates) as [templateName, templateData]}
					<option value={templateName}>{templateName}</option>
				{/each}
			</select>	
		</div>
		<div class="">
			<a href="/{pageData.slug}" target="blank">
				<button class="btn-primary">Preview</button>
			</a>	
		</div>
	</div>
	<div class="flex justify-center m-4">
		<button class="btn-secondary" on:click={() => saveChanges()}>{contenteditable ? 'Save Changes' : 'Enable Editing'}</button>
	</div>

	{#key unique}
		<svelte:component this={template} bind:contenteditable={contenteditable} {pageContent} />
	{/key}
</div>
