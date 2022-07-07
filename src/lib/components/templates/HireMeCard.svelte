<script type="ts">
	import { getContext } from 'svelte';
	export let editable: boolean;
	export let data: Object = {};

	const { fieldUpdate } = getContext('template');
</script>

<div
	class="flex items-center justify-center h-screen bg-gradient-to-br from-indigo-500 to-indigo-800"
>
	<div class="bg-white font-semibold text-center rounded-3xl border shadow-lg p-10 max-w-xs">
		<img
			class="mb-3 w-32 h-32 rounded-full shadow-lg mx-auto"
			src="https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80"
			alt="product designer"
		/>
		<h1
			id="name"
			on:blur={(event) => fieldUpdate(event, data)}
			contenteditable={editable}
			class="text-lg text-gray-700"
		>
			{data.name || 'John Doe'}
		</h1>
		<h3
			id="bio"
			on:blur={(event) => fieldUpdate(event, data)}
			contenteditable={editable}
			class="text-sm text-gray-400"
		>
			{data.bio || 'Creative Director'}
		</h3>
		<p
			id="description"
			on:blur={(event) => fieldUpdate(event, data)}
			contenteditable={editable}
			class="text-xs text-gray-400 mt-4"
		>
			{data.description ||
				'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'}
		</p>
		{#if editable}
			<div class="flex gap-4 items-center justify-center">
				<div class="flex flex-row">
					<svg
						class="w-6 h-6"
						fill="currentColor"
						viewBox="0 0 20 20"
						xmlns="http://www.w3.org/2000/svg"
						><path
							fill-rule="evenodd"
							d="M12.586 4.586a2 2 0 112.828 2.828l-3 3a2 2 0 01-2.828 0 1 1 0 00-1.414 1.414 4 4 0 005.656 0l3-3a4 4 0 00-5.656-5.656l-1.5 1.5a1 1 0 101.414 1.414l1.5-1.5zm-5 5a2 2 0 012.828 0 1 1 0 101.414-1.414 4 4 0 00-5.656 0l-3 3a4 4 0 105.656 5.656l1.5-1.5a1 1 0 10-1.414-1.414l-1.5 1.5a2 2 0 11-2.828-2.828l3-3z"
							clip-rule="evenodd"
						/></svg
					>
					<p
						id="cta-url"
						on:blur={(event) => fieldUpdate(event, data)}
						contenteditable={editable}
						placeholder="https://example.com"
					>
						{data['cta-url'] || 'https://example.com'}
					</p>
				</div>
				<p id="cta-title" on:blur={(event) => fieldUpdate(event, data)} contenteditable={editable}>
					{data['cta-text'] || 'Hire Me'}
				</p>
			</div>
		{:else}
			<a href={data['cta-url'] || '#'}
				><button
					class="bg-indigo-600 px-8 py-2 mt-8 rounded-3xl text-gray-100 font-semibold uppercase tracking-wide"
					>{data['cta-text'] || 'Hire Me'}</button
				></a
			>
		{/if}
	</div>
</div>
