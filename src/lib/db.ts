import { createClient } from '@supabase/supabase-js';
import { loading } from './utils/stores';
import { readable } from 'svelte/store';
import { goto } from '$app/navigation';

const dbAPI = async (query) => {
	return await query;
};

const Loader = (fn) => {
	return async function (query) {
		loading.set(true);
		const { data, error } = await query;
		loading.set(false);
		return { data, error };
	};
};

const AuthLoader = (fn) => {
	return async function (query) {
		loading.set(true);
		const { error, session } = await query;
		loading.set(false);
		return { error, session };
	};
};

const loaderQuery = Loader(dbAPI);
const authLoaderQuery = AuthLoader(dbAPI);

export const supabase = createClient(
	String(import.meta.env.VITE_SUPABASE_URL),
	String(import.meta.env.VITE_SUPABASE_ANON_KEY)
);

export const user = readable(supabase.auth.user(), (set) => {
	supabase.auth.onAuthStateChange((event, session) => {
		if (event == 'SIGNED_OUT') {
			set(null);
			goto('/');
		} else if (event == 'SIGNED_IN') {
			set(session.user);
		}
	});
});

export async function signOut() {
	await supabase.auth.signOut();
}

export const auth = {
	async signIn(data: object) {
		const query = supabase.auth.signIn(data);
		return await authLoaderQuery(query);
	},

	async signUp(data: object) {
		const query = supabase.auth.signUp(data);
		return await authLoaderQuery(query);
	},

	async signOut() {
		return await supabase.auth.signOut();
	}
};

export const pagesTable = {
	async all() {
		const query = supabase.from('pages').select('*');
		return await loaderQuery(query);
	},

	async search(searchTerm: string) {
		const query = supabase.from('pages').select('*').ilike('slug', searchTerm);
		return await loaderQuery(query);
	},

	async getPage(slug: string) {
		const query = supabase.from('pages').select('*').eq('slug', slug);
		return await loaderQuery(query);
	},

	async createPage(slug: string) {
		const query = supabase.from('pages').insert({ slug });
		return await loaderQuery(query);
	},

	async updatePage(slug: string, data: object) {
		const query = await supabase.from('pages').update({ data }).eq('slug', slug);
		return await loaderQuery(query);
	},

	async checkAvailability(slug: string) {
		const query = supabase.from('pages').select('id').eq('slug', slug);
		return await loaderQuery(query);
	}
};
