<script type="ts">
	import contentEditableAction from "$lib/utils/contentEditableAction";
	import { demoData } from "$lib/utils/demoData";
	import ContentEditableATag from "$lib/components/ContentEditableATag.svelte";
	export let contenteditable: boolean;
	export let pageContent: object = demoData
</script>

<body class="dark:bg-gray-900">
	<div class="text-indigo-100 bg-indigo-700 dark:bg-gray-800 dark:text-gray-200">
		<div  class="flex items-center justify-between h-16 max-w-6xl px-6 mx-auto">
			<svelte:component this={ContentEditableATag} bind:title={pageContent.brand.title} bind:url={pageContent.brand.url} {contenteditable} cssClass="font-bold tracking-tight uppercase" target="_blank"/>
			<ul class="flex items-center space-x-8 font-semibold" role="navigation">
                {#each pageContent.navLinks || [] as navLink, i}
                    <li>
						<svelte:component this={ContentEditableATag} bind:title={pageContent.navLinks[i].title} bind:url={pageContent.navLinks[i].url} {contenteditable}/>
                    </li>
                {/each}
				<li>
					<svelte:component this={ContentEditableATag} bind:title={pageContent.CTA[0].title} bind:url={pageContent.CTA[0].url} {contenteditable} cssClass="px-6 py-2 text-orange-100 bg-orange-600 rounded-full"/>
				</li>
			</ul>
		</div>
	</div>

	<header class="">
		<div class="flex flex-col max-w-6xl px-6 py-16 mx-auto md:flex-row">
			<div class="flex flex-col justify-center pr-4 md:w-1/2">
				<h1
					use:contentEditableAction={contenteditable}
					contenteditable="false"
					bind:textContent={pageContent.hero[0]}
					class="text-5xl font-extrabold leading-none tracking-tight text-gray-800 lg:text-6xl dark:text-gray-400"
				>
				</h1>

				<p use:contentEditableAction={contenteditable}
				contenteditable="false"
				bind:textContent={pageContent.hero[1]}
				class="mt-6 mb-12 text-lg text-gray-700 dark:text-gray-400">
				</p>

				<div>
					<svelte:component this={ContentEditableATag} bind:title={pageContent.CTA[1].title} bind:url={pageContent.CTA[1].url} {contenteditable} cssClass="px-6 py-2 font-semibold text-orange-100 bg-orange-600 rounded-full"/>
				</div>
			</div>

			<div class="md:w-1/2">
				<img
					class="w-full"
					src="https://tailwindcss-multi-theme.now.sh/wfh_1.svg"
					alt="Woman working from home"
				/>
			</div>
		</div>
	</header>
</body>
