import { pages } from '$lib/db';

/** @type {import('./__types/[id]').RequestHandler} */
export async function get({ params }) {
	// `params.id` comes from [id].js
    console.log(params.slug)
	const {data: pagesData, error} = await pages.getPage(params.slug);
    if (pagesData.length === 1) {
        let pageData = pagesData[0]
		return {
			body: { pageData }
		};
	}

	return {
		status: 404
	};
}