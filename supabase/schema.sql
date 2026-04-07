-- ============================================================
-- Jardines de Alfabia — Audioguía Digital Plus
-- Schema v1.0
-- ============================================================

-- ─── Extensions ─────────────────────────────────────────────
-- gen_random_uuid() is available in PostgreSQL 13+ without an extension,
-- but the uuid-ossp extension is kept here for compatibility with older Supabase projects.
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ─── Table: pois ─────────────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS pois (
  id                   UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  number               SMALLINT    NOT NULL UNIQUE,      -- Sequential 1–18
  section              TEXT        NOT NULL CHECK (section IN ('jardines', 'casa', 'dependencias')),
  name_key             TEXT        NOT NULL,             -- i18n key, e.g. 'poi_1'
  guide_points         TEXT,                             -- Official guide reference, e.g. 'Pts. 1, 3'
  latitude             FLOAT8      NOT NULL,
  longitude            FLOAT8      NOT NULL,
  activation_radius_m  SMALLINT    NOT NULL DEFAULT 30,  -- GPS trigger radius in metres
  duration_seconds     SMALLINT,                         -- Approximate audio duration
  image_url            TEXT,                             -- WebP image in Supabase Storage
  sort_order           SMALLINT    NOT NULL,             -- Display / playback ordering
  is_bifurcation       BOOLEAN     NOT NULL DEFAULT FALSE,
  bifurcation_targets  JSONB,                            -- Array of POI numbers, e.g. [5, 10]
  created_at           TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS pois_sort_order_idx  ON pois (sort_order);
CREATE INDEX IF NOT EXISTS pois_section_idx     ON pois (section);
CREATE INDEX IF NOT EXISTS pois_number_idx      ON pois (number);

-- ─── Table: translations ─────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS translations (
  id               UUID      PRIMARY KEY DEFAULT gen_random_uuid(),
  poi_id           UUID      NOT NULL REFERENCES pois (id) ON DELETE CASCADE,
  language         TEXT      NOT NULL CHECK (language IN ('es', 'en', 'de', 'ca', 'fr')),
  title            TEXT      NOT NULL,
  description      TEXT      NOT NULL,   -- Full audio transcript (for screen reading)
  audio_url_mp3    TEXT,                 -- Supabase Storage public URL
  audio_url_ogg    TEXT,                 -- OGG/Opus preferred (smaller file)
  audio_size_bytes INTEGER,
  UNIQUE (poi_id, language)
);

CREATE INDEX IF NOT EXISTS translations_poi_lang_idx ON translations (poi_id, language);

-- ─── Table: app_config ───────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS app_config (
  key   TEXT  PRIMARY KEY,
  value JSONB NOT NULL
);

-- ─── Row Level Security ───────────────────────────────────────────────────────
-- Public read (anon) on all tables.
-- Write operations restricted to service_role (server-side only).

-- pois
ALTER TABLE pois ENABLE ROW LEVEL SECURITY;

CREATE POLICY "pois: public read"
  ON pois FOR SELECT
  TO anon
  USING (true);

-- translations
ALTER TABLE translations ENABLE ROW LEVEL SECURITY;

CREATE POLICY "translations: public read"
  ON translations FOR SELECT
  TO anon
  USING (true);

-- app_config
ALTER TABLE app_config ENABLE ROW LEVEL SECURITY;

CREATE POLICY "app_config: public read"
  ON app_config FOR SELECT
  TO anon
  USING (true);

-- ─── Storage bucket (run separately via Supabase dashboard / CLI) ─────────────
-- Bucket name : 'audios'
-- Visibility  : public
-- Policy      : SELECT for anon (read-only)
-- File naming : poi_{number}_{lang}.ogg  /  poi_{number}_{lang}.mp3
-- Example     : poi_07_es.ogg,  poi_07_en.mp3
--
-- SQL equivalent (Supabase Storage schema):
--
-- INSERT INTO storage.buckets (id, name, public)
--   VALUES ('audios', 'audios', true)
--   ON CONFLICT (id) DO NOTHING;
--
-- CREATE POLICY "audios: public read"
--   ON storage.objects FOR SELECT
--   TO anon
--   USING (bucket_id = 'audios');
