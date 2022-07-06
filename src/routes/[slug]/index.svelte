<script type="ts">
import { page } from '$app/stores';

	import * as Templates from '$lib/components/templates';

    export let pageData: Object
	let data = pageData.data
	let currentTemplate = pageData.data.template || 'SimpleCard'
	$: template = Templates[currentTemplate];
	let editable = false;
</script>

<svelte:component this={template} {editable} {data}/>
