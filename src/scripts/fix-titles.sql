-- ─── Fix audio titles — all 5 languages ──────────────────────────────────────
-- Run this in the Supabase SQL editor (Dashboard → SQL Editor → New query).
-- Uses a CASE join on pois.number so no UUIDs are required.
-- Safe to run multiple times (idempotent UPDATE).

-- ── ESPAÑOL ───────────────────────────────────────────────────────────────────

UPDATE translations t
SET title = CASE p.number
  WHEN 1  THEN 'Bienvenida y Portal Forà'
  WHEN 2  THEN 'Escalera de piedra y sistema hidráulico'
  WHEN 3  THEN 'Cocina'
  WHEN 4  THEN 'Pérgola, juegos de agua y Mirador'
  WHEN 5  THEN 'Camino de los rosales'
  WHEN 6  THEN 'Jardinet de la Reina y Glicinia'
  WHEN 7  THEN 'Lago, bar y Miró'
  WHEN 8  THEN 'Fauna autóctona y palmeras'
  WHEN 9  THEN 'Zona de Eventos y Cedro'
  WHEN 10 THEN 'Introducción a la Casa'
  WHEN 11 THEN 'Estancias de la Reina'
  WHEN 12 THEN 'La silla gótica de Alfabia y Colección de Grabados'
  WHEN 13 THEN 'Sala Gran'
  WHEN 14 THEN 'Biblioteca y Llibre de ses Franqueses'
  WHEN 15 THEN 'Legado familiar y escudos de armas'
  WHEN 16 THEN 'Clastra, capilla y tienda de souvenirs'
  WHEN 17 THEN 'Establo y almazara'
  WHEN 18 THEN 'Artesonado y despedida'
END
FROM pois p
WHERE t.poi_id = p.id
  AND t.language = 'es';

-- ── ENGLISH ───────────────────────────────────────────────────────────────────

UPDATE translations t
SET title = CASE p.number
  WHEN 1  THEN 'Welcome and Portal Forà'
  WHEN 2  THEN 'Stone staircase and hydraulic system'
  WHEN 3  THEN 'Kitchen'
  WHEN 4  THEN 'Pergola, water features and Viewpoint'
  WHEN 5  THEN 'Rose garden path'
  WHEN 6  THEN 'Queen''s garden and Wisteria'
  WHEN 7  THEN 'Lake, bar and Miró'
  WHEN 8  THEN 'Native fauna and palm trees'
  WHEN 9  THEN 'Events area and Cedar'
  WHEN 10 THEN 'Introduction to the House'
  WHEN 11 THEN 'Queen''s chambers'
  WHEN 12 THEN 'Alfabia''s Gothic chair and Print collection'
  WHEN 13 THEN 'Great Hall'
  WHEN 14 THEN 'Library and Llibre de ses Franqueses'
  WHEN 15 THEN 'Family legacy and coats of arms'
  WHEN 16 THEN 'Cloister, chapel and souvenir shop'
  WHEN 17 THEN 'Stable and olive press'
  WHEN 18 THEN 'Coffered ceiling and farewell'
END
FROM pois p
WHERE t.poi_id = p.id
  AND t.language = 'en';

-- ── DEUTSCH ───────────────────────────────────────────────────────────────────

UPDATE translations t
SET title = CASE p.number
  WHEN 1  THEN 'Willkommen und Portal Forà'
  WHEN 2  THEN 'Steintreppe und Wassersystem'
  WHEN 3  THEN 'Küche'
  WHEN 4  THEN 'Pergola, Wasserspiele und Aussichtspunkt'
  WHEN 5  THEN 'Rosenweg'
  WHEN 6  THEN 'Königinnengarten und Glyzinie'
  WHEN 7  THEN 'See, Bar und Miró'
  WHEN 8  THEN 'Einheimische Fauna und Palmen'
  WHEN 9  THEN 'Veranstaltungsbereich und Zeder'
  WHEN 10 THEN 'Einführung in das Haus'
  WHEN 11 THEN 'Gemächer der Königin'
  WHEN 12 THEN 'Gotischer Stuhl von Alfabia und Grafiksammlung'
  WHEN 13 THEN 'Großer Saal'
  WHEN 14 THEN 'Bibliothek und Llibre de ses Franqueses'
  WHEN 15 THEN 'Familienvermächtnis und Wappen'
  WHEN 16 THEN 'Kreuzgang, Kapelle und Souvenirladen'
  WHEN 17 THEN 'Stall und Ölmühle'
  WHEN 18 THEN 'Kassettendecke und Abschied'
END
FROM pois p
WHERE t.poi_id = p.id
  AND t.language = 'de';

-- ── FRANÇAIS ──────────────────────────────────────────────────────────────────

UPDATE translations t
SET title = CASE p.number
  WHEN 1  THEN 'Bienvenue et Portal Forà'
  WHEN 2  THEN 'Escalier de pierre et système hydraulique'
  WHEN 3  THEN 'Cuisine'
  WHEN 4  THEN 'Pergola, jeux d''eau et Belvédère'
  WHEN 5  THEN 'Chemin des rosiers'
  WHEN 6  THEN 'Jardinet de la Reine et Glycine'
  WHEN 7  THEN 'Lac, bar et Miró'
  WHEN 8  THEN 'Faune autochtone et palmiers'
  WHEN 9  THEN 'Espace événements et Cèdre'
  WHEN 10 THEN 'Introduction à la Maison'
  WHEN 11 THEN 'Appartements de la Reine'
  WHEN 12 THEN 'Chaise gothique d''Alfabia et Collection de gravures'
  WHEN 13 THEN 'Grande Salle'
  WHEN 14 THEN 'Bibliothèque et Llibre de ses Franqueses'
  WHEN 15 THEN 'Héritage familial et blasons'
  WHEN 16 THEN 'Cloître, chapelle et boutique de souvenirs'
  WHEN 17 THEN 'Écurie et moulin à huile'
  WHEN 18 THEN 'Plafond à caissons et au revoir'
END
FROM pois p
WHERE t.poi_id = p.id
  AND t.language = 'fr';

-- ── CATALÀ ────────────────────────────────────────────────────────────────────

UPDATE translations t
SET title = CASE p.number
  WHEN 1  THEN 'Benvinguda i Portal Forà'
  WHEN 2  THEN 'Escala de pedra i sistema hidràulic'
  WHEN 3  THEN 'Cuina'
  WHEN 4  THEN 'Pèrgola, jocs d''aigua i Mirador'
  WHEN 5  THEN 'Camí dels rosers'
  WHEN 6  THEN 'Jardinet de la Reina i Glicínia'
  WHEN 7  THEN 'Llac, bar i Miró'
  WHEN 8  THEN 'Fauna autòctona i palmeres'
  WHEN 9  THEN 'Zona d''Esdeveniments i Cedre'
  WHEN 10 THEN 'Introducció a la Casa'
  WHEN 11 THEN 'Estances de la Reina'
  WHEN 12 THEN 'La cadira gòtica d''Alfàbia i Col·lecció de gravats'
  WHEN 13 THEN 'Sala Gran'
  WHEN 14 THEN 'Biblioteca i Llibre de ses Franqueses'
  WHEN 15 THEN 'Llegat familiar i escuts d''armes'
  WHEN 16 THEN 'Clastra, capella i botiga de records'
  WHEN 17 THEN 'Estable i tafona'
  WHEN 18 THEN 'Enteixinat i comiat'
END
FROM pois p
WHERE t.poi_id = p.id
  AND t.language = 'ca';
