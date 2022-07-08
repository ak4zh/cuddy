<script type="ts">
	import contentEditableAction from "$lib/utils/contentEditableAction";
    export let title, url, contenteditable: boolean;
    export let target = '_blank'
    export let cssClass = ''
</script>


<div class={contenteditable? "flex flex-col" : ""}>
    <a
    use:contentEditableAction={contenteditable}
    contenteditable="false"
    bind:textContent={title}
    href={url}
    class={cssClass}
    {target}></a>
    {#if contenteditable}
        <input type="text" bind:value={url}/>
    {/if}
</div>
