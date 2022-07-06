<script lang="ts">
	import * as Templates from '$lib/components/templates';
	import { getContext } from 'svelte';

	export let pageData: Object

	let currentTemplate = pageData?.data?.template || 'SimpleCard'
	$: template = Templates[currentTemplate];
	const { fieldUpdate } = getContext('template');

	let editable = true;
	let data = pageData?.data || {}
</script>

<div class="col-span-6 sm:col-span-3 m-4">
	<label for="template" class="block text-sm font-medium text-gray-700">Change Template</label>
	<select id="template" on:change={(event) => fieldUpdate(event, data)} bind:value={currentTemplate} class="mt-1 block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
		{#each Object.entries(Templates) as [templateName, templateData]}
			<option value={templateName}>{templateName}</option>
		{/each}
	</select>
</div>

<svelte:component this={template} {editable} {data} />
