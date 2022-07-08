<script type="ts">
	import { getContext } from 'svelte';

	export let contenteditable = false;
	export let data: Object;

	const { fieldUpdate } = getContext('template');

	$: data = data || {};
</script>

<div class="py-20 h-screen bg-gray-300 px-2">
	<div
		class="max-w-md mx-auto bg-white bg-gradient-to-r from-purple-400 via-pink-500 to-red-500 rounded-lg overflow-hidden md:max-w-sm h-64"
	>
		<div class="flex justify-center items-center w-full h-full">
			<div class="flex flex-col items-center">
				<h1
					on:blur={(event) => fieldUpdate(event, data)}
					{contenteditable}
					id="name"
					class="text-xl text-white font-medium"
				>
					{data.name || 'Dr. Annie Johns'}
				</h1>
				<span
					on:blur={(event) => fieldUpdate(event, data)}
					{contenteditable}
					id="bio"
					class="text-sm text-white">{data.bio || 'Your BMI is 23.84'}</span
				>
			</div>
		</div>
	</div>
</div>
