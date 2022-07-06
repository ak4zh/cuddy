CREATE TABLE public.user_profiles (
		id uuid NOT NULL PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
		first_name character varying,
		full_name character varying,
		email character varying UNIQUE,
		created_at timestamp without time zone DEFAULT now() NOT NULL
);

ALTER TABLE public.user_profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "user_profiles.allow_select_by_owner" ON public.user_profiles FOR SELECT USING ((auth.uid() = id));
CREATE POLICY "user_profiles.allow_insert_by_owner" ON public.user_profiles FOR INSERT WITH CHECK ((auth.uid() = id));


CREATE FUNCTION public.handle_auth_user_update() RETURNS trigger
		LANGUAGE plpgsql SECURITY DEFINER
		AS $$
BEGIN
UPDATE public.user_profiles SET email = new.email WHERE id = new.id;
RETURN new;
END;
$$;
CREATE TRIGGER handle_auth_user_update
		AFTER UPDATE
		ON auth.users
		FOR EACH ROW
		EXECUTE FUNCTION public.handle_auth_user_update();

CREATE FUNCTION public.handle_new_user() RETURNS trigger
		LANGUAGE plpgsql SECURITY DEFINER
		AS $$
DECLARE
	invitation RECORD;
BEGIN
	INSERT INTO public.user_profiles (id) VALUES (NEW.id);
	RETURN new;
END;
$$;
CREATE TRIGGER handle_new_user
		AFTER INSERT
		ON auth.users
		FOR EACH ROW
EXECUTE FUNCTION public.handle_new_user();


CREATE TABLE IF NOT EXISTS public.pages (
		id BIGSERIAL PRIMARY KEY,
        user_id uuid DEFAULT auth.uid() REFERENCES public.user_profiles(id) ON DELETE CASCADE,
		created_at timestamp without time zone DEFAULT now(),
		slug text COLLATE pg_catalog."default" NOT NULL UNIQUE,
		data jsonb
);

ALTER TABLE public.pages ENABLE ROW LEVEL SECURITY;

CREATE POLICY "user_profiles.allow_select_by_everyone" ON public.pages FOR SELECT USING ((true));
CREATE POLICY "user_profiles.allow_insert_by_owner" ON public.pages FOR INSERT WITH CHECK ((auth.uid() = user_id));
CREATE POLICY "organization_members.allow_update_by_owner" ON public.pages FOR UPDATE USING ((auth.uid() = user_id));
CREATE POLICY "organization_members.allow_delete_by_owner" ON public.pages FOR DELETE USING ((auth.uid() = user_id));
