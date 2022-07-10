CREATE TABLE public.user_profiles (
		id uuid NOT NULL PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
		full_name character varying,
		username character varying UNIQUE,
		email character varying UNIQUE,
		created_at timestamp without time zone DEFAULT now() NOT NULL
		bummer jsonb,
		public boolean DEFAULT true NOT NULL,
		featured boolean,
		view_count integer DEFAULT 0
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

CREATE OR REPLACE VIEW bummers AS
	SELECT bummer, username, featured, view_count
	FROM public.user_profiles
	WHERE public = true;
