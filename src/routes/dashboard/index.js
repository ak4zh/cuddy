import { pagesTable } from '$lib/db';

/** @type {import('./__types/[id]').RequestHandler} */
export async function get({ params }) {
	// `params.id` comes from [id].js
	const { data, error } = await pagesTable.all();
	return {
		body: { pages: data }
	};
}
