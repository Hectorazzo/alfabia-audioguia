-- ============================================================
-- Jardines de Alfabia — Seed data v1.0
-- 18 POIs + Spanish translations (ES)
--
-- GPS coordinates are APPROXIMATE (development placeholders).
-- Field calibration scheduled for Week 5 of the roadmap.
-- Real coordinates will replace these values after on-site measurement.
--
-- Audio URLs are NULL pending ElevenLabs upload to Supabase Storage.
-- File naming convention: poi_{number:02}_{lang}.ogg / .mp3
-- ============================================================

BEGIN;

-- ─── POIs ────────────────────────────────────────────────────────────────────
-- Coordinates centred on Jardines de Alfabia, Bunyola, Mallorca
-- Base reference: 39.7633 N, 2.7847 E

INSERT INTO pois
  (number, section, name_key, guide_points, latitude, longitude,
   activation_radius_m, duration_seconds, image_url, sort_order,
   is_bifurcation, bifurcation_targets)
VALUES

-- ── Section A: Jardines ───────────────────────────────────────────────────────
  (1,  'jardines',     'poi_1',  'Pt. 2',          39.76310, 2.78480, 30, 90,  NULL, 1,  FALSE, NULL),
  (2,  'jardines',     'poi_2',  'Pts. 1, 3',       39.76330, 2.78460, 30, 110, NULL, 2,  FALSE, NULL),
  (3,  'jardines',     'poi_3',  'Pts. 4, 5',       39.76355, 2.78440, 30, 75,  NULL, 3,  FALSE, NULL),
  (4,  'jardines',     'poi_4',  'Pts. 6, 7, 8',    39.76385, 2.78420, 30, 80,  NULL, 4,  FALSE, NULL),
  (5,  'jardines',     'poi_5',  'Pt. 9',           39.76410, 2.78400, 30, 80,  NULL, 5,  FALSE, NULL),
  (6,  'jardines',     'poi_6',  'Pts. 10, 11',     39.76435, 2.78375, 30, 90,  NULL, 6,  FALSE, NULL),
  (7,  'jardines',     'poi_7',  'Pts. 13, 14, 15', 39.76460, 2.78350, 30, 100, NULL, 7,  FALSE, NULL),
  (8,  'jardines',     'poi_8',  'Pt. 16',          39.76480, 2.78325, 35, 75,  NULL, 8,  TRUE,  '[5, 10]'::jsonb),
  (9,  'jardines',     'poi_9',  'Pt. 12',          39.76500, 2.78300, 30, 60,  NULL, 9,  FALSE, NULL),

-- ── Section B: La Casa ────────────────────────────────────────────────────────
  (10, 'casa',         'poi_10', 'Pt. 18',          39.76385, 2.78295, 35, 75,  NULL, 10, FALSE, NULL),
  (11, 'casa',         'poi_11', 'Pts. 26, 27',     39.76378, 2.78302, 25, 115, NULL, 11, FALSE, NULL),
  (12, 'casa',         'poi_12', 'Pt. 25',          39.76372, 2.78308, 25, 75,  NULL, 12, FALSE, NULL),
  (13, 'casa',         'poi_13', 'Pts. 24, 23',     39.76366, 2.78314, 25, 120, NULL, 13, FALSE, NULL),
  (14, 'casa',         'poi_14', 'Pts. 22, 19, 20', 39.76361, 2.78320, 25, 100, NULL, 14, FALSE, NULL),
  (15, 'casa',         'poi_15', 'Pt. 21',          39.76368, 2.78327, 25, 110, NULL, 15, FALSE, NULL),

-- ── Section C: Dependencias y Cierre ─────────────────────────────────────────
  (16, 'dependencias', 'poi_16', 'Pts. 28, 29, 30', 39.76342, 2.78348, 35, 110, NULL, 16, FALSE, NULL),
  (17, 'dependencias', 'poi_17', 'Pts. 31, 32, 33', 39.76322, 2.78368, 30, 120, NULL, 17, FALSE, NULL),
  (18, 'dependencias', 'poi_18', 'Pt. 34',          39.76305, 2.78465, 30, 60,  NULL, 18, FALSE, NULL)

ON CONFLICT (number) DO NOTHING;

-- ─── Spanish translations (ES) ───────────────────────────────────────────────
-- description = full audio transcript, used for screen reading and offline text.
-- Placeholder content based on Guion R3 structure; replace with final transcripts.

-- POI 1 — Bienvenida y Portal Forà
INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'es',
  'Bienvenida y Portal Forà',
  'Bienvenidos a los Jardines de Alfabia, una de las joyas del patrimonio histórico y natural de Mallorca. '
  'El portal de piedra que tenéis ante vosotros, conocido como el Portal Forà, marca el umbral entre el mundo exterior y este espacio singular que lleva más de mil años siendo testigo de la historia de la isla. '
  'Los jardines que vais a recorrer fueron trazados siguiendo la más pura tradición de los jardines árabes, con el agua como elemento vertebrador y el sonido de las fuentes como banda sonora permanente del paseo. '
  'La finca de Alfabia tiene sus orígenes en época islámica, cuando fue residencia de Benhabet, gobernador de Medina Mayurca, la Palma árabe. '
  'A lo largo de los siglos pasó por las manos de diversas familias de la nobleza mallorquina, cada una de las cuales dejó su impronta en las piedras, los jardines y las colecciones de la casa. '
  'Os invitamos a explorar a vuestro propio ritmo, sin prisa, dejándoos sorprender por cada rincón de este lugar único. Activad el audio en el punto siguiente para comenzar el recorrido.',
  NULL, NULL, NULL
FROM pois WHERE number = 1
ON CONFLICT (poi_id, language) DO NOTHING;

-- POI 2 — Escalera de piedra y sistema hidráulico
INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'es',
  'Escalera de piedra y sistema hidráulico',
  'La gran escalera de piedra que tenéis frente a vosotros es uno de los elementos más extraordinarios de todo el conjunto. '
  'Fijáos en los canalillos que discurren paralelos a los peldaños a ambos lados: son parte de un sofisticado sistema hidráulico diseñado hace más de mil años por ingenieros árabes que comprendían perfectamente cómo aprovechar la gravedad para mover el agua. '
  'Desde las fuentes y acequias situadas en las cotas más altas de la finca, el agua desciende de forma controlada hasta regar cada rincón del jardín sin necesidad de bombas ni maquinaria. '
  'Este tipo de ingeniería hidráulica, heredada de la tradición árabe y persa, es muy poco frecuente en Europa y constituye uno de los elementos patrimoniales más valiosos de Alfabia. '
  'El sonido que escucháis ahora, ese murmullo constante del agua sobre la piedra, es prácticamente el mismo que oyeron los primeros visitantes de este jardín hace siglos. '
  'Tomad un momento para observar el trabajo de la cantería: cada piedra fue tallada con una precisión que permite que el agua fluya sin desbordarse, con una eficiencia que los ingenieros modernos todavía admiran.',
  NULL, NULL, NULL
FROM pois WHERE number = 2
ON CONFLICT (poi_id, language) DO NOTHING;

-- POI 3 — Chorros de agua y Pergolado
INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'es',
  'Chorros de agua y Pergolado',
  'Los chorros de agua que surgen aquí de forma rítmica son otro ejemplo del ingenio hidráulico árabe presente en Alfabia. '
  'El juego del agua en movimiento no era solo estético: en los jardines islámicos, el sonido y el frescor del agua tenían un significado espiritual profundo, evocando la imagen del paraíso descrita en el Corán. '
  'A vuestra derecha encontráis la gran pérgola, una estructura de madera y hierro cubierta en su mayor parte por una glicinia centenaria cuyas raíces se hunden profundamente en la tierra mallorquina. '
  'En primavera, cuando la glicinia florece, esta pérgola se convierte en un túnel de flores violetas y perfume que es quizá la imagen más fotografiada de todo el jardín. '
  'Incluso fuera de la temporada de floración, la estructura de ramas entrelazadas crea una bóveda vegetal que proporciona sombra y cobijo, ideal para el paseo en los meses de verano. '
  'Tomad vuestro tiempo aquí: es uno de los espacios más íntimos y silenciosos del recorrido.',
  NULL, NULL, NULL
FROM pois WHERE number = 3
ON CONFLICT (poi_id, language) DO NOTHING;

-- POI 4 — Mirador y Fuentes
INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'es',
  'Mirador y Fuentes',
  'Desde este mirador disfrutáis de una de las vistas más amplias de todo el jardín, con las montañas de la Serra de Tramuntana como telón de fondo. '
  'El perfil montañoso que veis al norte es uno de los paisajes más característicos de Mallorca, declarado Patrimonio Mundial de la UNESCO en 2011 por su valor cultural y natural excepcional. '
  'A vuestros pies, las fuentes que forman este conjunto son el corazón visible del sistema hidráulico que alimenta todo el jardín. '
  'Las tres fuentes principales fueron construidas en diferentes épocas, y podéis distinguirlas por los estilos decorativos: la más antigua conserva motivos geométricos de influencia árabe, mientras que las otras dos incorporan elementos del barroco mallorquín. '
  'El agua que emerge aquí nace en los manantiales naturales de la montaña y recorre varios kilómetros de acequias antes de llegar a este punto. '
  'En época árabe existía todo un personal dedicado exclusivamente al mantenimiento de estas conducciones de agua, lo que da idea de la importancia que tenía este recurso para los habitantes de la finca.',
  NULL, NULL, NULL
FROM pois WHERE number = 4
ON CONFLICT (poi_id, language) DO NOTHING;

-- POI 5 — Glicinia y Terraza
INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'es',
  'Glicinia y Terraza',
  'La glicinia que cubre esta terraza es uno de los ejemplares más antiguos y espectaculares de toda la finca. '
  'Nadie conoce con exactitud su edad, pero los botánicos que la han estudiado estiman que podría tener entre ciento cincuenta y doscientos años, lo que la convierte en un ser vivo que ha sido testigo de gran parte de la historia contemporánea de Mallorca. '
  'El tronco principal, que podéis observar retorciéndose sobre la estructura de madera, tiene un grosor que ya no cabe en el abrazo de una sola persona. '
  'La terraza sobre la que os encontráis servía en otros tiempos como espacio de descanso y contemplación para los propietarios de la finca. '
  'Desde aquí se dominaba buena parte del jardín y también el camino de acceso a la casa, lo que le daba también un cierto carácter estratégico. '
  'Si habéis llegado hasta aquí desde el camino de la derecha, bienvenidos al jardín propiamente dicho. Si habéis venido de las palmeras, habréis elegido la ruta del jardín antes de visitar la casa.',
  NULL, NULL, NULL
FROM pois WHERE number = 5
ON CONFLICT (poi_id, language) DO NOTHING;

-- POI 6 — Huerto de naranjos y Animales
INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'es',
  'Huerto de naranjos y Animales',
  'Este espacio combina dos elementos que han sido esenciales en la vida de la finca a lo largo de los siglos: el huerto productivo y la presencia de animales domésticos. '
  'Los naranjos que veis aquí son descendientes de variedades introducidas por los árabes en Mallorca durante el período de dominación islámica de la isla, entre los siglos X y XIII. '
  'El naranjo amargo, que es la variedad predominante en esta zona, no se consume directamente sino que se utiliza para la elaboración de mermeladas, licores y productos cosméticos. '
  'Fijáos en el sistema de riego que alimenta estos árboles: pequeñas acequias de piedra que distribuyen el agua de manera uniforme, siguiendo exactamente el mismo principio que las grandes conducciones que visteis al inicio del recorrido. '
  'En cuanto a los animales, la finca ha mantenido históricamente una pequeña granja con especies autóctonas mallorquinas. '
  'El contacto con estos animales es especialmente apreciado por los visitantes más pequeños, y refleja la voluntad de los propietarios de mantener viva la dimensión agrícola y ganadera de Alfabia junto a su faceta cultural y paisajística.',
  NULL, NULL, NULL
FROM pois WHERE number = 6
ON CONFLICT (poi_id, language) DO NOTHING;

-- POI 7 — Jardinet, Lago y Escultura Miró
INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'es',
  'Jardinet, Lago y Escultura Miró',
  'Llegáis ahora a uno de los rincones más especiales de Alfabia: el jardinet, un pequeño jardín íntimo organizado alrededor de un estanque cuya superficie refleja las copas de los árboles que lo rodean. '
  'El espejo de agua crea una atmósfera de quietud y recogimiento que contrasta con la exuberancia vegetal del resto del jardín. '
  'Junto al estanque encontráis una obra que por sí sola justificaría la visita a Alfabia: se trata de una escultura en bronce titulada "Tête de femme (Déesse)", obra del artista Joan Miró, creada en 1970. '
  'Esta pieza pertenece al Catálogo Razonado de la obra escultórica de Miró con el número 182, y es una de las esculturas más valoradas del conjunto de la finca, con un valor asegurado de novecientos mil euros. '
  'La figura, que Miró concibió como una representación de la diosa o fuerza femenina primordial, dialoga de manera extraordinaria con el entorno natural: sus formas orgánicas y su pátina oscura parecen surgir de la propia tierra del jardín. '
  'Joan Miró tenía una vinculación muy profunda con Mallorca, donde vivió y trabajó desde 1956 hasta su muerte en 1983. Esta escultura es un recordatorio de esa relación íntima entre el artista y la isla. '
  'Tomad vuestro tiempo aquí: la escultura merece ser contemplada desde distintos ángulos y con la luz cambiante del día.',
  NULL, NULL, NULL
FROM pois WHERE number = 7
ON CONFLICT (poi_id, language) DO NOTHING;

-- POI 8 — Palmeras y Picudo rojo (BIFURCACIÓN)
INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'es',
  'Palmeras y Picudo rojo',
  'Las palmeras que enmarcan este espacio son uno de los elementos más reconocibles de la silueta de Alfabia. '
  'Estas palmeras datileras, de la especie Phoenix dactylifera, fueron plantadas hace más de un siglo y en su momento formaban una avenida imponente que daba la bienvenida a los visitantes de la finca. '
  'Sin embargo, como muchas palmeras de Mallorca y de toda la cuenca mediterránea, algunas de ellas han sido gravemente afectadas por el picudo rojo, un coleóptero de origen asiático que llegó a Europa a finales del siglo XX y que se ha convertido en la mayor amenaza para las palmeras del continente. '
  'Los propietarios de Alfabia llevan años luchando contra esta plaga con tratamientos preventivos y curativos, y algunas de las palmeras que veis ya han sido recuperadas gracias a estos esfuerzos. '
  'Os encontráis ahora en un punto de bifurcación del recorrido. Ante vosotros se abren dos caminos: '
  'Si giráis a la izquierda, continuaréis por el jardín hacia la glicinia y la terraza. '
  'Si giráis a la derecha, accederéis a la entrada de la casa, donde comienza la parte interior del recorrido. '
  'Ambas opciones os esperan con historias fascinantes. La elección es vuestra.',
  NULL, NULL, NULL
FROM pois WHERE number = 8
ON CONFLICT (poi_id, language) DO NOTHING;

-- POI 9 — Zona de Eventos y Cedro
INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'es',
  'Zona de Eventos y Cedro',
  'Este amplio espacio abierto es la zona de eventos de los Jardines de Alfabia, un escenario natural incomparable para celebraciones, conciertos, bodas y encuentros culturales. '
  'La combinación de vegetación centenaria, el sonido del agua y la luz característica de Mallorca convierten este lugar en un marco privilegiado para cualquier tipo de acontecimiento. '
  'A lo largo del año Alfabia acoge una agenda cultural variada que incluye conciertos de música clásica y jazz, exposiciones de arte al aire libre y eventos gastronómicos que ponen en valor los productos de la finca y de la isla. '
  'Si estáis interesados en celebrar un evento privado aquí, en la tienda encontraréis información sobre los servicios de catering y organización disponibles. '
  'Ahora, fijaos en el árbol monumental que preside este espacio: un cedro del Atlas, Cedrus atlantica, de dimensiones extraordinarias. '
  'Este ejemplar, cuya copa cubre una superficie de más de doscientos metros cuadrados, tiene aproximadamente ciento veinte años de antigüedad y es uno de los árboles más grandes y notables de toda Mallorca. '
  'En días de viento, el susurro de sus ramas produce un sonido inconfundible que los jardineros de Alfabia describen como la voz del jardín.',
  NULL, NULL, NULL
FROM pois WHERE number = 9
ON CONFLICT (poi_id, language) DO NOTHING;

-- POI 10 — Introducción a la Casa
INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'es',
  'Introducción a la Casa',
  'Bienvenidos a la casa señorial de Alfabia. Tras haber recorrido los jardines, entramos ahora en el corazón histórico de la finca: una residencia nobiliaria que ha ido creciendo y transformándose a lo largo de los siglos, desde sus orígenes árabes hasta la actualidad. '
  'Antes de entrar, conviene tener en cuenta que el orden de visita del interior de la casa es el inverso al de la numeración del guía oficial. Comenzaréis por las estancias más íntimas y personales, asociadas a la visita de la reina Isabel II, y terminaréis en la galería porticada y los documentos hereditarios. '
  'La casa que veis ha pertenecido a la familia Burgues-Zaforteza desde el siglo XVII, y los actuales propietarios son descendientes directos de esa línea familiar. '
  'A diferencia de muchos palacios convertidos en museos, Alfabia es todavía hoy una casa habitada y viva, lo que le confiere un carácter único e irrepetible. '
  'Los muebles, cuadros, esculturas y objetos que vais a ver no son réplicas ni recreaciones: son piezas originales que han pertenecido a esta familia durante generaciones. '
  'Os pedimos que tratéis este espacio con el mismo respeto con que trataríais la casa de un anfitrión que os ha abierto sus puertas.',
  NULL, NULL, NULL
FROM pois WHERE number = 10
ON CONFLICT (poi_id, language) DO NOTHING;

-- POI 11 — Estancias de la Reina
INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'es',
  'Estancias de la Reina',
  'Las habitaciones en las que os encontráis ahora son conocidas popularmente como las Estancias de la Reina, y la historia que las vincula a la monarquía española es una de las más fascinantes de toda la finca. '
  'En el año 1860, la reina Isabel II realizó una visita oficial a Mallorca. Era la primera vez que un monarca reinante pisaba la isla desde hacía siglos, y la visita fue recibida con gran expectación por la sociedad mallorquina. '
  'La familia propietaria de Alfabia fue seleccionada para acoger a la reina durante su estancia en el interior de la isla, lo que supuso un honor extraordinario y también un gasto considerable para los anfitriones, que prepararon estas estancias específicamente para la ocasión. '
  'El mobiliario que veis aquí, de estilo isabelino, fue adquirido en gran parte para esa visita real, y algunas piezas llevan todavía la montura original con las iniciales de la reina. '
  'La cama, el tocador y los demás muebles de estas habitaciones son un testimonio material de ese momento histórico, cuando una reina de España durmió bajo el mismo techo que ahora cobija vuestra visita. '
  'Observad los retratos de las paredes: el de mayor tamaño representa a la propia reina Isabel II, y fue un regalo de la corona a los anfitriones como agradecimiento por su hospitalidad.',
  NULL, NULL, NULL
FROM pois WHERE number = 11
ON CONFLICT (poi_id, language) DO NOTHING;

-- POI 12 — Silla gótica y Grabados
INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'es',
  'Silla gótica y Grabados',
  'La pieza que centra esta sala merece toda vuestra atención: se trata de una silla de madera tallada de estilo gótico catalán, datada en el siglo XV, que es una de las piezas de mobiliario más antiguas conservadas en una casa privada de Mallorca. '
  'Las tallas de los laterales representan escenas religiosas y motivos heráldicos que los especialistas han relacionado con la familia Fortuny, que habitó esta finca durante el período medieval. '
  'El estado de conservación de esta silla es extraordinario si tenemos en cuenta sus seiscientos años de antigüedad, y se debe en parte al microclima favorable que proporcionan los gruesos muros de piedra de la casa. '
  'En las paredes de esta sala encontráis una colección de grabados de los siglos XVII y XVIII que representan vistas de ciudades europeas, mapas insulares y retratos de personajes históricos relacionados con la historia de Mallorca. '
  'Algunos de estos grabados son auténticas piezas de cartografía histórica de gran valor documental, y muestran cómo era Mallorca antes de los grandes cambios del siglo XIX. '
  'Fijáos especialmente en el mapa de la ciudad de Palma con sus antiguas murallas, demolidas en 1902 para permitir la expansión de la ciudad moderna.',
  NULL, NULL, NULL
FROM pois WHERE number = 12
ON CONFLICT (poi_id, language) DO NOTHING;

-- POI 13 — Artesonado mozárabe y Biblioteca
INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'es',
  'Artesonado mozárabe y Biblioteca',
  'Levantad la vista hacia el techo: lo que tenéis sobre vosotros es uno de los artesonados mozárabes mejor conservados de toda España. '
  'Este extraordinario techo de madera tallada y policromada fue construido en el siglo XIV combinando técnicas decorativas islámicas con formas propias del gótico europeo, dando como resultado un estilo único conocido como mudéjar o mozárabe. '
  'Los artesanos que crearon este techo dominaban dos tradiciones aparentemente distintas y las fusionaron con una maestría que todavía asombra a los especialistas en arte medieval. '
  'Los motivos geométricos que veis repetirse en distintas variaciones a lo largo del artesonado son característicos del arte islámico, donde la representación de figuras humanas o animales estaba restringida por razones religiosas, y la geometría se convirtió en el lenguaje visual por excelencia. '
  'Bajo este techo excepcional se encuentra la biblioteca de la familia, que alberga varios centenares de volúmenes, algunos de ellos incunables y manuscritos de los siglos XVI y XVII. '
  'Entre los fondos más destacados se cuentan documentos notariales originales que certifican transacciones de tierras en Mallorca desde el siglo XIII, lo que convierte esta biblioteca en una fuente primaria de historia local de valor incalculable.',
  NULL, NULL, NULL
FROM pois WHERE number = 13
ON CONFLICT (poi_id, language) DO NOTHING;

-- POI 14 — Sala de entrada y Escudos
INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'es',
  'Sala de entrada y Escudos',
  'La sala en la que os encontráis ahora es la zona de representación de la casa, el espacio donde los propietarios recibían a sus visitas más formales a lo largo de los siglos. '
  'Las paredes están dominadas por una impresionante colección de escudos heráldicos que representan los linajes que han habitado o que están emparentados con la familia de Alfabia. '
  'La heráldica, es decir, el sistema de símbolos y colores que identifican a cada familia nobiliaria, fue durante siglos algo más que una cuestión de protocolo: era un sistema de identidad, pertenencia y legitimidad que tenía consecuencias jurídicas y políticas muy concretas. '
  'Cada escudo que veis aquí cuenta una historia familiar: las barras horizontales, los castillos, los leones, las flores de lis o los animales heráldicos no son ornamentos caprichosos, sino símbolos codificados que los contemporáneos sabían leer con precisión. '
  'El escudo de mayor tamaño, situado sobre la chimenea principal, corresponde a la familia Burgues-Zaforteza, que ha sido propietaria de Alfabia desde el siglo XVII. '
  'Los escudos más pequeños a ambos lados representan los distintos linajes con los que esta familia emparentó a lo largo de los siglos a través del matrimonio, creando esa red de alianzas que era la política interior de la nobleza mallorquina.',
  NULL, NULL, NULL
FROM pois WHERE number = 14
ON CONFLICT (poi_id, language) DO NOTHING;

-- POI 15 — Galería porticada y Pasillo hereditario
INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'es',
  'Galería porticada y Pasillo hereditario',
  'La galería porticada que recorréis ahora es uno de los espacios arquitectónicos más elegantes de Alfabia. '
  'Sus arcos de medio punto, construidos en la piedra arenisca dorada característica de la arquitectura mallorquina, crean un ritmo visual sereno que conecta el interior de la casa con el patio y los jardines. '
  'Este tipo de galería con pórtico abierto es un elemento típico de la arquitectura señorial mediterránea que permite disfrutar del aire fresco y la vista del jardín incluso en los meses más calurosos. '
  'En las paredes de este pasillo encontráis los documentos hereditarios originales de la finca, enmarcados y protegidos bajo cristal. '
  'Estos pergaminos y papeles notariales, que abarcan un período de varios siglos, constituyen el árbol genealógico material de la familia y la historia legal de la propiedad. '
  'Entre ellos destacan las capitulaciones matrimoniales del siglo XVIII, documentos extraordinariamente detallados en los que se especifican con precisión los bienes, derechos y obligaciones de cada parte contrayente. '
  'La lectura de estos documentos, para quien conoce el latín notarial de la época, es una ventana directa a la mentalidad y las preocupaciones de la nobleza mallorquina de los siglos pasados. '
  'Habéis concluido la visita a la casa. Os esperan las dependencias exteriores.',
  NULL, NULL, NULL
FROM pois WHERE number = 15
ON CONFLICT (poi_id, language) DO NOTHING;

-- POI 16 — Clastra, Capilla y Tienda
INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'es',
  'Clastra, Capilla y Tienda',
  'Saliendo de la casa principal llegáis a la clastra, el patio central que organiza el conjunto de las dependencias de la finca. '
  'La clastra es un elemento arquitectónico típico de las posesiones mallorquinas, el gran patio alrededor del cual se distribuyen todas las edificaciones auxiliares: los establos, los almacenes, la almazara, los cuartos del personal y la capilla. '
  'En el centro del patio, un pozo de piedra recuerda que hasta mediados del siglo XX el agua de lluvia recogida en las cisternas era el principal suministro de agua potable para los habitantes de la finca. '
  'A vuestra izquierda encontráis la capilla de la familia, una pequeña iglesia privada de uso exclusivo de los propietarios y sus trabajadores. '
  'Esta capilla, consagrada a la Virgen, conserva un retablo del siglo XVIII y algunos exvotos de gran valor devocional que documentan los milagros atribuidos a la imagen titular. '
  'Antes de abandonar Alfabia os invitamos a visitar nuestra tienda, donde encontraréis productos artesanales de la finca, publicaciones sobre la historia de los jardines, mermeladas elaboradas con los frutos del huerto y una selección de artículos relacionados con la cultura y la naturaleza de Mallorca.',
  NULL, NULL, NULL
FROM pois WHERE number = 16
ON CONFLICT (poi_id, language) DO NOTHING;

-- POI 17 — Establo y Almazara
INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'es',
  'Establo y Almazara',
  'Las dos construcciones que completan vuestro recorrido por las dependencias de Alfabia son el establo y la almazara, y juntas ilustran perfectamente la dimensión productiva de la finca a lo largo de los siglos. '
  'El establo, con su estructura de arcos de piedra y sus pesebres todavía en su lugar original, albergaba en otros tiempos los caballos y mulos que eran imprescindibles para el trabajo agrícola y el transporte. '
  'La arquitectura del establo es un ejemplo notable de construcción vernácula mallorquina: sólida, funcional, construida para durar, con ventanas pequeñas que mantienen el interior fresco en verano y protegido del frío en invierno. '
  'La almazara, contigua al establo, es donde se procesaban las aceitunas para obtener el aceite de oliva, producto fundamental de la economía de la finca y de toda Mallorca. '
  'La prensa de madera que veis aquí, de grandes dimensiones, data del siglo XVIII y estuvo en funcionamiento hasta mediados del siglo XX. '
  'El proceso de elaboración del aceite que se realizaba en esta sala, desde la recepción de la aceituna hasta el envasado del aceite, empleaba a decenas de trabajadores durante los meses de noviembre y diciembre, la época de la recogida. '
  'Hoy la almazara ya no produce aceite, pero su maquinaria original perfectamente conservada es un testimonio vivo de la cultura agrícola que durante siglos dio vida a esta finca.',
  NULL, NULL, NULL
FROM pois WHERE number = 17
ON CONFLICT (poi_id, language) DO NOTHING;

-- POI 18 — Despedida y Cierre
INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'es',
  'Despedida y Cierre',
  'Habéis llegado al final del recorrido por los Jardines de Alfabia. Esperamos que esta visita haya sido una experiencia memorable y que os llevéis con vosotros no solo recuerdos e imágenes, sino también un pedazo de la historia y el alma de Mallorca. '
  'Si la visita os ha gustado, os agradeceríamos enormemente que comparaseis vuestra experiencia en Google Reviews. Vuestras valoraciones nos ayudan a llegar a más visitantes y a seguir manteniendo este espacio único. '
  'Los Jardines de Alfabia están disponibles para la celebración de eventos privados: bodas, comuniones, reuniones de empresa y actos culturales. Si estáis interesados, encontraréis toda la información en la tienda o podéis contactarnos a través de nuestra web. '
  'A lo largo del año organizamos también visitas guiadas temáticas, conciertos al atardecer y otras actividades especiales. Seguidnos en redes sociales para estar al día de nuestra agenda. '
  'Gracias por vuestra visita. Hasta pronto en los Jardines de Alfabia.',
  NULL, NULL, NULL
FROM pois WHERE number = 18
ON CONFLICT (poi_id, language) DO NOTHING;

-- ─── App config ───────────────────────────────────────────────────────────────

INSERT INTO app_config (key, value) VALUES
  ('default_language',   '"es"'),
  ('default_radius_m',   '30'),
  ('app_version',        '"1.0.0"'),
  ('review_url_google',  '"https://g.page/r/PLACEHOLDER_REPLACE_WITH_REAL_PLACE_ID/review"'),
  ('offline_audio_size_estimate_mb', '28'),
  ('bifurcation_poi_number', '8')
ON CONFLICT (key) DO NOTHING;

COMMIT;
