<script type="ts">
	import * as Templates from '$lib/components/templates';
	import { demoData } from '$lib/utils/demoData';
	export let data: object
	export let pageData: Object;
	let pageContent = pageData?.data || demoData;
	let currentTemplate: string = pageContent?.template;
	$: template = Templates[currentTemplate];

	let contenteditable = false;
</script>

<svelte:component this={template} {contenteditable} {data} {pageContent} />
