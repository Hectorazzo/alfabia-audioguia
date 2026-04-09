-- ============================================================
-- Jardines de Alfabia — Translations seed v1.0
-- 18 POIs × 4 languages: EN, DE, CA, FR
--
-- Descriptions are 2-3 sentence placeholders summarising the
-- Spanish audio content. Replace with final ElevenLabs transcripts.
-- Audio URLs are NULL pending upload to Supabase Storage.
-- ============================================================

BEGIN;

-- ─── POI 1 — Bienvenida y Portal Forà ────────────────────────────────────────

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'en',
  'Welcome and Portal Forà',
  'Welcome to the Gardens of Alfabia, one of the jewels of Mallorca''s historic and natural heritage. '
  'The stone gateway known as the Portal Forà marks the threshold of a unique space shaped by over a thousand years of history, first as an Arab governor''s residence and later as a Mallorcan noble estate. '
  'The gardens were designed following the tradition of Arab gardens, with water as the central element and the sound of fountains as the permanent backdrop of your visit.',
  NULL, NULL, NULL
FROM pois WHERE number = 1
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'de',
  'Willkommen und Portal Forà',
  'Willkommen in den Gärten von Alfabia, einem der Kleinode des historischen und natürlichen Erbes Mallorcas. '
  'Das Steinportal, bekannt als Portal Forà, markiert die Schwelle zu einem einzigartigen Raum, der seit über tausend Jahren Geschichte bezeugt — zunächst als Residenz eines arabischen Gouverneurs, später als mallorquinisches Adelsgut. '
  'Die Gärten wurden nach der Tradition arabischer Gärten gestaltet, mit Wasser als zentralem Element und dem Klang der Brunnen als ständiger Begleitung.',
  NULL, NULL, NULL
FROM pois WHERE number = 1
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'ca',
  'Benvinguda i Portal Forà',
  'Benvinguts als Jardins d''Alfabia, una de les joies del patrimoni històric i natural de Mallorca. '
  'El portal de pedra conegut com el Portal Forà marca el llindar d''un espai singular que fa més de mil anys que és testimoni de la història de l''illa, primer com a residència del governador àrab i després com a finca nobiliària mallorquina. '
  'Els jardins van ser dissenyats seguint la tradició dels jardins àrabs, amb l''aigua com a element vertebrador i el so de les fonts com a banda sonora permanent.',
  NULL, NULL, NULL
FROM pois WHERE number = 1
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'fr',
  'Bienvenue et Portal Forà',
  'Bienvenue aux Jardins d''Alfabia, l''un des joyaux du patrimoine historique et naturel de Majorque. '
  'Le portail de pierre connu sous le nom de Portal Forà marque le seuil d''un espace unique qui témoigne de plus de mille ans d''histoire, d''abord comme résidence d''un gouverneur arabe, puis comme domaine noble majorquin. '
  'Les jardins ont été tracés selon la tradition des jardins arabes, avec l''eau comme élément central et le murmure des fontaines comme bande sonore permanente de votre promenade.',
  NULL, NULL, NULL
FROM pois WHERE number = 1
ON CONFLICT (poi_id, language) DO NOTHING;

-- ─── POI 2 — Escalera de piedra y sistema hidráulico ─────────────────────────

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'en',
  'Stone Staircase and Hydraulic System',
  'The great stone staircase before you is one of the most extraordinary elements of the estate, with channels running alongside the steps that carry water downhill by gravity alone — a design over a thousand years old. '
  'This sophisticated hydraulic engineering, inherited from Arab and Persian tradition, is exceptionally rare in Europe and one of Alfabia''s most valuable heritage features. '
  'The constant murmur of water over stone that you hear now is essentially the same sound that greeted the first visitors to this garden centuries ago.',
  NULL, NULL, NULL
FROM pois WHERE number = 2
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'de',
  'Steintreppe und Hydrauliksystem',
  'Die große Steintreppe vor Ihnen ist eines der außergewöhnlichsten Elemente des Anwesens, mit Kanälen entlang der Stufen, die Wasser allein durch die Schwerkraft bergab leiten — ein über tausend Jahre altes Design. '
  'Diese ausgeklügelte Hydrauliktechnik, aus arabischer und persischer Tradition übernommen, ist in Europa außerordentlich selten und eines der wertvollsten Kulturerbe-Elemente von Alfabia. '
  'Das ständige Murmeln des Wassers über Stein, das Sie jetzt hören, ist im Wesentlichen dasselbe Geräusch, das die ersten Besucher dieses Gartens vor Jahrhunderten begrüßte.',
  NULL, NULL, NULL
FROM pois WHERE number = 2
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'ca',
  'Escala de pedra i sistema hidràulic',
  'La gran escala de pedra que teniu davant és un dels elements més extraordinaris de la finca, amb canaletes que discorren paral·leles als graons i condueixen l''aigua cuesta avall per gravetat — un disseny de fa més de mil anys. '
  'Aquesta enginyeria hidràulica sofisticada, heretada de la tradició àrab i persa, és molt poc freqüent a Europa i un dels elements patrimonials més valuosos d''Alfabia. '
  'El murmuri constant de l''aigua sobre la pedra que sentiu ara és pràcticament el mateix que van escoltar els primers visitants d''aquest jardí fa segles.',
  NULL, NULL, NULL
FROM pois WHERE number = 2
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'fr',
  'Escalier de pierre et système hydraulique',
  'Le grand escalier de pierre devant vous est l''un des éléments les plus extraordinaires de la propriété, avec des canaux longeant les marches qui acheminent l''eau vers le bas par simple gravité — une conception vieille de plus de mille ans. '
  'Cette ingénierie hydraulique sophistiquée, héritée de la tradition arabe et persane, est exceptionnellement rare en Europe et constitue l''une des caractéristiques patrimoniales les plus précieuses d''Alfabia. '
  'Le murmure constant de l''eau sur la pierre que vous entendez maintenant est essentiellement le même son qui accueillait les premiers visiteurs de ce jardin il y a des siècles.',
  NULL, NULL, NULL
FROM pois WHERE number = 2
ON CONFLICT (poi_id, language) DO NOTHING;

-- ─── POI 3 — Chorros de agua y Pergolado ─────────────────────────────────────

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'en',
  'Water Jets and Pergola',
  'The rhythmic water jets here are another example of Arab hydraulic ingenuity, where water carried both aesthetic and spiritual meaning — evoking the paradise described in the Quran. '
  'The large pergola to your right is covered by a century-old wisteria whose intertwined branches form a natural vault of shade and shelter, ideal for a summer stroll. '
  'In spring, when the wisteria blooms, this pergola becomes a tunnel of violet flowers and fragrance — perhaps the most photographed image of the entire garden.',
  NULL, NULL, NULL
FROM pois WHERE number = 3
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'de',
  'Wasserstrahlen und Pergola',
  'Die rhythmischen Wasserstrahlen hier sind ein weiteres Beispiel arabischen Hydraulik-Ideenreichtums, bei dem Wasser sowohl ästhetische als auch spirituelle Bedeutung trug — als Evokation des im Koran beschriebenen Paradieses. '
  'Die große Pergola zu Ihrer Rechten ist von einer jahrhundertealten Glyzinie bedeckt, deren verschlungene Äste ein natürliches Gewölbe aus Schatten und Schutz bilden, ideal für einen Sommerrundgang. '
  'Im Frühling, wenn die Glyzinie blüht, wird diese Pergola zu einem Tunnel aus violetten Blüten und Duft — vielleicht das meistfotografierte Bild des gesamten Gartens.',
  NULL, NULL, NULL
FROM pois WHERE number = 3
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'ca',
  'Rajolins d''aigua i Pergolat',
  'Els rajolins d''aigua rítmics d''aquí són un altre exemple de l''enginy hidràulic àrab, on l''aigua tenia tant un significat estètic com espiritual, evocant la imatge del paradís descrita a l''Alcorà. '
  'La gran pérgola a la vostra dreta està coberta per una glicínia centenària les branques entrellaçades de la qual formen una volta natural d''ombra i recer, ideal per al passeig a l''estiu. '
  'A la primavera, quan la glicínia floreix, aquesta pérgola es converteix en un túnel de flors violetes i perfum — potser la imatge més fotografiada de tot el jardí.',
  NULL, NULL, NULL
FROM pois WHERE number = 3
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'fr',
  'Jets d''eau et Pergola',
  'Les jets d''eau rythmiques ici sont un autre exemple du génie hydraulique arabe, où l''eau portait une signification à la fois esthétique et spirituelle, évoquant le paradis décrit dans le Coran. '
  'La grande pergola sur votre droite est couverte d''une glycine centenaire dont les branches entrelacées forment une voûte naturelle d''ombre et d''abri, idéale pour une promenade estivale. '
  'Au printemps, quand la glycine fleurit, cette pergola devient un tunnel de fleurs violettes et de parfum — peut-être l''image la plus photographiée de tout le jardin.',
  NULL, NULL, NULL
FROM pois WHERE number = 3
ON CONFLICT (poi_id, language) DO NOTHING;

-- ─── POI 4 — Mirador y Fuentes ───────────────────────────────────────────────

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'en',
  'Viewpoint and Fountains',
  'From this viewpoint you enjoy one of the broadest vistas in the garden, with the Serra de Tramuntana mountains — a UNESCO World Heritage Site since 2011 — as a dramatic backdrop. '
  'At your feet the fountains display three distinct styles spanning the centuries: the oldest retains geometric motifs of Arab influence, while the others incorporate elements of Mallorcan Baroque. '
  'The water that emerges here originates in natural mountain springs and travels several kilometres of channels before reaching this point.',
  NULL, NULL, NULL
FROM pois WHERE number = 4
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'de',
  'Aussichtspunkt und Brunnen',
  'Von diesem Aussichtspunkt aus genießen Sie einen der weitesten Ausblicke im Garten, mit der Serra de Tramuntana — seit 2011 UNESCO-Weltkulturerbe — als dramatische Kulisse. '
  'Zu Ihren Füßen zeigen die Brunnen drei unterschiedliche Stile aus verschiedenen Jahrhunderten: der älteste bewahrt geometrische Motive arabischen Einflusses, während die anderen Elemente des mallorquinischen Barocks einbeziehen. '
  'Das Wasser, das hier entspringt, stammt aus natürlichen Gebirgsquellen und legt mehrere Kilometer durch Kanäle zurück, bevor es diesen Punkt erreicht.',
  NULL, NULL, NULL
FROM pois WHERE number = 4
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'ca',
  'Mirador i Fonts',
  'Des d''aquest mirador gaudiu d''una de les vistes més àmplies de tot el jardí, amb les muntanyes de la Serra de Tramuntana — Patrimoni Mundial de la UNESCO des del 2011 — com a teló de fons. '
  'Als vostres peus, les fonts mostren tres estils distints que abasten els segles: la més antiga conserva motius geomètrics d''influència àrab, mentre que les altres incorporen elements del barroc mallorquí. '
  'L''aigua que sorgeix aquí neix en manantials naturals de la muntanya i recorre diversos quilòmetres d''acequeies abans d''arribar a aquest punt.',
  NULL, NULL, NULL
FROM pois WHERE number = 4
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'fr',
  'Belvédère et Fontaines',
  'De ce belvédère, vous profitez d''une des vues les plus larges du jardin, avec les montagnes de la Serra de Tramuntana — classées au Patrimoine Mondial de l''UNESCO depuis 2011 — en toile de fond. '
  'À vos pieds, les fontaines présentent trois styles distincts couvrant plusieurs siècles : la plus ancienne conserve des motifs géométriques d''influence arabe, tandis que les autres incorporent des éléments du baroque majorquin. '
  'L''eau qui jaillit ici provient de sources naturelles de la montagne et parcourt plusieurs kilomètres de canaux avant d''arriver à ce point.',
  NULL, NULL, NULL
FROM pois WHERE number = 4
ON CONFLICT (poi_id, language) DO NOTHING;

-- ─── POI 5 — Glicinia y Terraza ──────────────────────────────────────────────

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'en',
  'Wisteria and Terrace',
  'The wisteria covering this terrace is one of the oldest and most spectacular specimens on the entire estate, estimated by botanists to be between one hundred and fifty and two hundred years old. '
  'Its main trunk, twisted around the wooden structure, is too thick for one person to embrace — a living witness to much of Mallorca''s contemporary history. '
  'This terrace once served as a space of rest and contemplation for the estate''s owners, commanding views over much of the garden and the approach to the house.',
  NULL, NULL, NULL
FROM pois WHERE number = 5
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'de',
  'Glyzinie und Terrasse',
  'Die Glyzinie, die diese Terrasse bedeckt, ist eines der ältesten und spektakulärsten Exemplare der gesamten Anlage, von Botanikern auf zwischen hundertfünfzig und zweihundert Jahre geschätzt. '
  'Ihr Hauptstamm, der sich um die Holzkonstruktion windet, ist zu dick, um ihn alleine zu umarmen — ein lebendiger Zeuge eines Großteils der zeitgenössischen Geschichte Mallorcas. '
  'Diese Terrasse diente einst als Ruhe- und Betrachtungsraum für die Eigentümer des Anwesens und bot einen Überblick über einen Großteil des Gartens und den Zufahrtsweg zum Haus.',
  NULL, NULL, NULL
FROM pois WHERE number = 5
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'ca',
  'Glicínia i Terrassa',
  'La glicínia que cobreix aquesta terrassa és un dels exemplars més antics i espectaculars de tota la finca, que els botànics estimen entre cent cinquanta i dos-cents anys d''antiguitat. '
  'El tronc principal, que es retorça sobre l''estructura de fusta, té un gruix que ja no cap en l''abraçada d''una sola persona — un testimoni viu de gran part de la història contemporània de Mallorca. '
  'Aquesta terrassa servia en altres temps com a espai de descans i contemplació per als propietaris de la finca, dominant bona part del jardí i el camí d''accés a la casa.',
  NULL, NULL, NULL
FROM pois WHERE number = 5
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'fr',
  'Glycine et Terrasse',
  'La glycine qui couvre cette terrasse est l''un des spécimens les plus anciens et les plus spectaculaires de toute la propriété, estimé par les botanistes entre cent cinquante et deux cents ans. '
  'Son tronc principal, enroulé autour de la structure en bois, est trop épais pour être embrassé par une seule personne — un témoin vivant d''une grande partie de l''histoire contemporaine de Majorque. '
  'Cette terrasse servait autrefois d''espace de repos et de contemplation pour les propriétaires, dominant une bonne partie du jardin et l''allée menant à la maison.',
  NULL, NULL, NULL
FROM pois WHERE number = 5
ON CONFLICT (poi_id, language) DO NOTHING;

-- ─── POI 6 — Huerto de naranjos y Animales ───────────────────────────────────

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'en',
  'Orange Grove and Animals',
  'This space combines two elements essential to the life of the estate for centuries: the productive orchard and the presence of domestic animals. '
  'The orange trees here are descendants of varieties introduced to Mallorca by the Arabs during the Islamic period, and the irrigation channels feeding them follow the same ancient system visible at the start of the tour. '
  'The estate has historically maintained a small farm with native Mallorcan breeds, and encounters with these animals are especially appreciated by younger visitors.',
  NULL, NULL, NULL
FROM pois WHERE number = 6
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'de',
  'Orangenhain und Tiere',
  'Dieser Bereich verbindet zwei Elemente, die für das Leben des Anwesens seit Jahrhunderten wesentlich sind: den produktiven Obstgarten und die Anwesenheit von Haustieren. '
  'Die Orangenbäume hier sind Nachkommen von Sorten, die von den Arabern während der islamischen Periode auf Mallorca eingeführt wurden, und die Bewässerungskanäle folgen demselben alten System wie zu Beginn der Führung. '
  'Das Anwesen unterhält seit jeher einen kleinen Bauernhof mit einheimischen mallorquinischen Rassen, und der Kontakt mit diesen Tieren wird besonders von jüngeren Besuchern geschätzt.',
  NULL, NULL, NULL
FROM pois WHERE number = 6
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'ca',
  'Hort de tarongers i Animals',
  'Aquest espai combina dos elements que han estat essencials en la vida de la finca al llarg dels segles: l''hort productiu i la presència d''animals domèstics. '
  'Els tarongers d''aquí són descendents de varietats introduïdes pels àrabs a Mallorca durant el període islàmic de l''illa, i les acequeies de reg segueixen el mateix sistema antic visible a l''inici del recorregut. '
  'La finca ha mantingut històricament una petita granja amb espècies autòctones mallorquines, i el contacte amb aquests animals és especialment apreciat pels visitants més petits.',
  NULL, NULL, NULL
FROM pois WHERE number = 6
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'fr',
  'Orangeraie et Animaux',
  'Cet espace combine deux éléments essentiels à la vie de la propriété depuis des siècles : le verger productif et la présence d''animaux domestiques. '
  'Les orangers ici sont les descendants de variétés introduites à Majorque par les Arabes pendant la période islamique de l''île, et les canaux d''irrigation suivent le même système ancestral visible au début de la visite. '
  'La propriété a historiquement maintenu une petite ferme avec des races majorquines autochtones, et le contact avec ces animaux est particulièrement apprécié des jeunes visiteurs.',
  NULL, NULL, NULL
FROM pois WHERE number = 6
ON CONFLICT (poi_id, language) DO NOTHING;

-- ─── POI 7 — Jardinet, Lago y Escultura Miró ─────────────────────────────────

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'en',
  'Jardinet, Lake and Miró Sculpture',
  'You now arrive at one of Alfabia''s most special corners: the jardinet, an intimate garden arranged around a still pond whose surface mirrors the surrounding trees. '
  'Beside the pond stands a bronze sculpture titled "Tête de femme (Déesse)" by Joan Miró, created in 1970, catalogued as number 182 in his sculptural catalogue raisonné and insured for nine hundred thousand euros. '
  'Miró had a profound connection with Mallorca, where he lived and worked from 1956 until his death in 1983 — this sculpture is a testament to that intimate bond between artist and island.',
  NULL, NULL, NULL
FROM pois WHERE number = 7
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'de',
  'Jardinet, See und Miró-Skulptur',
  'Sie erreichen nun einen der schönsten Winkel von Alfabia: den Jardinet, einen intimen Garten rund um einen stillen Teich, dessen Oberfläche die umliegenden Bäume spiegelt. '
  'Neben dem Teich steht eine Bronzeskulptur mit dem Titel „Tête de femme (Déesse)" von Joan Miró, geschaffen 1970, als Nummer 182 in seinem Skulpturen-Werkverzeichnis katalogisiert und auf neunhunderttausend Euro versichert. '
  'Miró hatte eine tiefe Verbindung zu Mallorca, wo er von 1956 bis zu seinem Tod 1983 lebte und arbeitete — diese Skulptur ist ein Zeugnis dieser innigen Beziehung zwischen Künstler und Insel.',
  NULL, NULL, NULL
FROM pois WHERE number = 7
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'ca',
  'Jardinet, Llac i Escultura Miró',
  'Arribeu ara a un dels racons més especials d''Alfabia: el jardinet, un petit jardí íntim organitzat al voltant d''un estany tranquil la superfície del qual reflecteix les copes dels arbres que l''envolten. '
  'Al costat de l''estany hi ha una escultura en bronze titulada "Tête de femme (Déesse)" de Joan Miró, creada el 1970, catalogada com a número 182 del seu catàleg raonat escultòric i assegurada per nou-cents mil euros. '
  'Miró tenia una vinculació molt profunda amb Mallorca, on va viure i treballar des del 1956 fins a la seva mort el 1983 — aquesta escultura és un testimoni d''aquest lligam íntim entre artista i illa.',
  NULL, NULL, NULL
FROM pois WHERE number = 7
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'fr',
  'Jardinet, Lac et Sculpture Miró',
  'Vous arrivez maintenant à l''un des coins les plus spéciaux d''Alfabia : le jardinet, un petit jardin intime organisé autour d''un étang tranquille dont la surface reflète les arbres environnants. '
  'À côté de l''étang se trouve une sculpture en bronze intitulée « Tête de femme (Déesse) » de Joan Miró, créée en 1970, cataloguée sous le numéro 182 dans son catalogue raisonné sculptural et assurée pour neuf cent mille euros. '
  'Miró avait un lien profond avec Majorque, où il vécut et travailla de 1956 jusqu''à sa mort en 1983 — cette sculpture témoigne de ce lien intime entre l''artiste et l''île.',
  NULL, NULL, NULL
FROM pois WHERE number = 7
ON CONFLICT (poi_id, language) DO NOTHING;

-- ─── POI 8 — Palmeras y Picudo rojo (BIFURCACIÓN) ────────────────────────────

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'en',
  'Palm Trees and Red Weevil',
  'The palm trees framing this space were planted over a century ago as a grand avenue welcoming visitors; like many Mediterranean palms, some have been severely affected by the red palm weevil, an Asian beetle that arrived in Europe in the late twentieth century. '
  'The owners have worked for years to recover affected specimens through preventive and curative treatments, and some of the palms you see here have already been saved. '
  'You now stand at a fork: turn left to continue through the garden towards the wisteria terrace, or turn right to enter the house — both paths await with fascinating stories.',
  NULL, NULL, NULL
FROM pois WHERE number = 8
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'de',
  'Palmen und Roter Palmrüssler',
  'Die Palmen, die diesen Bereich einrahmen, wurden vor über einem Jahrhundert als prächtige Allee gepflanzt; wie viele Mittelmeerpalmen wurden einige durch den Roten Palmrüssler, einen asiatischen Käfer der im späten zwanzigsten Jahrhundert in Europa ankam, stark befallen. '
  'Die Eigentümer haben jahrelang durch präventive und kurative Behandlungen daran gearbeitet, befallene Exemplare zu retten, und einige der Palmen, die Sie hier sehen, wurden bereits gerettet. '
  'Sie stehen nun an einer Weggabelung: links geht es durch den Garten zur Glyzinienterrasse, rechts betreten Sie das Haus — beide Wege halten faszinierende Geschichten bereit.',
  NULL, NULL, NULL
FROM pois WHERE number = 8
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'ca',
  'Palmeres i Morrut vermell',
  'Les palmeres que emmarquen aquest espai van ser plantades fa més d''un segle com una avinguda imponent; com moltes palmeres mediterrànies, algunes han estat greument afectades pel morrut vermell, un coleòpter asiàtic que va arribar a Europa a finals del segle XX. '
  'Els propietaris han treballat durant anys per recuperar els exemplars afectats mitjançant tractaments preventius i curatius, i algunes de les palmeres que veieu ja han estat salvades. '
  'Us trobeu ara en un punt de bifurcació: gireu a l''esquerra per continuar pel jardí cap a la terrassa de la glicínia, o gireu a la dreta per accedir a la casa — tots dos camins us esperen amb històries fascinants.',
  NULL, NULL, NULL
FROM pois WHERE number = 8
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'fr',
  'Palmiers et Charançon rouge',
  'Les palmiers qui encadrent cet espace ont été plantés il y a plus d''un siècle comme une grande allée d''accueil ; comme de nombreux palmiers méditerranéens, certains ont été gravement touchés par le charançon rouge du palmier, un coléoptère asiatique arrivé en Europe à la fin du XXe siècle. '
  'Les propriétaires ont travaillé pendant des années à récupérer les spécimens affectés par des traitements préventifs et curatifs, et certains des palmiers que vous voyez ont déjà été sauvés. '
  'Vous vous trouvez maintenant à une bifurcation : tournez à gauche pour continuer à travers le jardin vers la terrasse de glycine, ou tournez à droite pour entrer dans la maison — les deux chemins vous réservent des histoires fascinantes.',
  NULL, NULL, NULL
FROM pois WHERE number = 8
ON CONFLICT (poi_id, language) DO NOTHING;

-- ─── POI 9 — Zona de Eventos y Cedro ─────────────────────────────────────────

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'en',
  'Events Area and Cedar',
  'This broad open space is Alfabia''s events area, an incomparable natural setting for celebrations, concerts, weddings, and cultural gatherings hosted throughout the year. '
  'Presiding over the space is a monumental Atlas cedar — Cedrus atlantica — estimated at around one hundred and twenty years old, with a canopy covering more than two hundred square metres, making it one of the largest trees in Mallorca. '
  'If you are interested in hosting a private event here, you will find information about catering and organisation services in the estate shop.',
  NULL, NULL, NULL
FROM pois WHERE number = 9
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'de',
  'Veranstaltungsbereich und Zeder',
  'Dieser weitläufige offene Raum ist Alfabias Veranstaltungsbereich, ein unvergleichlicher natürlicher Rahmen für Feste, Konzerte, Hochzeiten und kulturelle Zusammenkünfte das ganze Jahr über. '
  'Den Raum beherrscht eine monumentale Atlaszeder — Cedrus atlantica — die auf etwa hundertzwanzig Jahre geschätzt wird und mit einer Krone von mehr als zweihundert Quadratmetern zu den größten Bäumen Mallorcas gehört. '
  'Wenn Sie daran interessiert sind, hier eine private Veranstaltung abzuhalten, finden Sie Informationen zu Catering- und Organisationsleistungen im Anwesensladen.',
  NULL, NULL, NULL
FROM pois WHERE number = 9
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'ca',
  'Zona d''Esdeveniments i Cedre',
  'Aquest ampli espai obert és la zona d''esdeveniments dels Jardins d''Alfabia, un escenari natural incomparable per a celebracions, concerts, casaments i trobades culturals que s''organitzen al llarg de l''any. '
  'Presidint l''espai hi ha un cedre de l''Atles monumental — Cedrus atlantica — estimat en uns cent vint anys d''antiguitat, amb una copa que cobreix més de dos-cents metres quadrats, fent-lo un dels arbres més grans de Mallorca. '
  'Si esteu interessats a celebrar un esdeveniment privat aquí, trobareu informació sobre els serveis de càtering i organització a la botiga de la finca.',
  NULL, NULL, NULL
FROM pois WHERE number = 9
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'fr',
  'Espace Événements et Cèdre',
  'Ce vaste espace ouvert est la zone événementielle des Jardins d''Alfabia, un cadre naturel incomparable pour les célébrations, concerts, mariages et rassemblements culturels organisés tout au long de l''année. '
  'Dominant cet espace se dresse un cèdre de l''Atlas monumental — Cedrus atlantica — estimé à environ cent vingt ans, avec un houppier couvrant plus de deux cents mètres carrés, ce qui en fait l''un des plus grands arbres de Majorque. '
  'Si vous souhaitez organiser un événement privé ici, vous trouverez des informations sur les services de restauration et d''organisation dans la boutique de la propriété.',
  NULL, NULL, NULL
FROM pois WHERE number = 9
ON CONFLICT (poi_id, language) DO NOTHING;

-- ─── POI 10 — Introducción a la Casa ─────────────────────────────────────────

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'en',
  'Introduction to the House',
  'Welcome to the manor house of Alfabia — having walked the gardens, you now enter the historic heart of the estate: a noble residence that has grown and transformed over the centuries from its Arab origins to the present day. '
  'The house has belonged to the Burgues-Zaforteza family since the seventeenth century, and unlike many palaces converted into museums, Alfabia is still a lived-in home, giving it a uniquely intimate character. '
  'The furniture, paintings, sculptures, and objects you are about to see are not replicas — they are original pieces that have belonged to this family for generations.',
  NULL, NULL, NULL
FROM pois WHERE number = 10
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'de',
  'Einführung ins Haus',
  'Willkommen im Herrenhaus von Alfabia — nachdem Sie die Gärten durchquert haben, betreten Sie nun das historische Herz des Anwesens: eine noble Residenz, die sich über die Jahrhunderte von ihren arabischen Ursprüngen bis in die Gegenwart entwickelt hat. '
  'Das Haus gehört seit dem siebzehnten Jahrhundert der Familie Burgues-Zaforteza, und anders als viele in Museen umgewandelte Paläste ist Alfabia noch immer ein bewohntes Haus, was ihm einen einzigartig intimen Charakter verleiht. '
  'Die Möbel, Gemälde, Skulpturen und Objekte, die Sie sehen werden, sind keine Repliken — es sind originale Stücke, die dieser Familie seit Generationen gehören.',
  NULL, NULL, NULL
FROM pois WHERE number = 10
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'ca',
  'Introducció a la Casa',
  'Benvinguts a la casa senyorial d''Alfabia — després d''haver recorregut els jardins, entreu ara al cor històric de la finca: una residència nobiliària que ha anat creixent i transformant-se al llarg dels segles des dels seus orígens àrabs fins a l''actualitat. '
  'La casa ha pertangut a la família Burgues-Zaforteza des del segle XVII, i a diferència de molts palaus convertits en museus, Alfabia és encara una casa habitada i viva, la qual cosa li confereix un caràcter únic i inigualable. '
  'Els mobles, quadres, escultures i objectes que veureu no són rèpliques — són peces originals que han pertangut a aquesta família durant generacions.',
  NULL, NULL, NULL
FROM pois WHERE number = 10
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'fr',
  'Introduction à la Maison',
  'Bienvenue dans le manoir d''Alfabia — après avoir parcouru les jardins, vous entrez maintenant dans le cœur historique de la propriété : une résidence noble qui a grandi et évolué au fil des siècles depuis ses origines arabes jusqu''à nos jours. '
  'La maison appartient à la famille Burgues-Zaforteza depuis le XVIIe siècle, et contrairement à de nombreux palais transformés en musées, Alfabia est encore aujourd''hui une maison habitée et vivante, ce qui lui confère un caractère unique. '
  'Les meubles, tableaux, sculptures et objets que vous allez voir ne sont pas des répliques — ce sont des pièces originales appartenant à cette famille depuis des générations.',
  NULL, NULL, NULL
FROM pois WHERE number = 10
ON CONFLICT (poi_id, language) DO NOTHING;

-- ─── POI 11 — Estancias de la Reina ──────────────────────────────────────────

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'en',
  'The Queen''s Chambers',
  'These rooms are known as the Queen''s Chambers, linked to a remarkable chapter of Spanish royal history: in 1860, Queen Isabel II visited Mallorca — the first reigning monarch to set foot on the island in centuries. '
  'The family who owned Alfabia was chosen to host the queen during her stay inland, and the furniture here, in the Isabelline style, was largely acquired for that royal occasion. '
  'The large portrait on the wall represents Queen Isabel II herself — a gift from the crown to the hosts as thanks for their hospitality.',
  NULL, NULL, NULL
FROM pois WHERE number = 11
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'de',
  'Die Gemächer der Königin',
  'Diese Räume sind bekannt als die Gemächer der Königin und sind mit einem bemerkenswerten Kapitel der spanischen Königsgeschichte verbunden: Im Jahr 1860 besuchte Königin Isabel II. Mallorca — der erste regierende Monarch seit Jahrhunderten, der die Insel betrat. '
  'Die Familie, der Alfabia gehörte, wurde ausgewählt, die Königin während ihres Aufenthalts im Landesinneren zu beherbergen, und die Möbel hier, im Isabellischen Stil, wurden größtenteils für diesen königlichen Anlass erworben. '
  'Das große Porträt an der Wand zeigt Königin Isabel II. selbst — ein Geschenk der Krone an die Gastgeber als Dank für ihre Gastfreundschaft.',
  NULL, NULL, NULL
FROM pois WHERE number = 11
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'ca',
  'Estances de la Reina',
  'Aquestes habitacions es coneixen com les Estances de la Reina, vinculades a un capítol notable de la història reial espanyola: l''any 1860, la reina Isabel II va visitar Mallorca — el primer monarca regnant que trepitjava l''illa en segles. '
  'La família propietària d''Alfabia va ser escollida per acollir la reina durant la seva estada a l''interior, i el mobiliari d''aquí, d''estil isabelí, va ser adquirit en gran part per a aquella ocasió reial. '
  'El gran retrat de la paret representa la pròpia reina Isabel II — un regal de la corona als amfitrions en agraïment per la seva hospitalitat.',
  NULL, NULL, NULL
FROM pois WHERE number = 11
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'fr',
  'Les Appartements de la Reine',
  'Ces pièces sont connues sous le nom d''Appartements de la Reine, liées à un remarquable chapitre de l''histoire royale espagnole : en 1860, la reine Isabel II visita Majorque — premier monarque régnant à fouler l''île depuis des siècles. '
  'La famille propriétaire d''Alfabia fut choisie pour accueillir la reine lors de son séjour dans l''intérieur de l''île, et le mobilier ici, de style isabelin, fut en grande partie acquis pour cette occasion royale. '
  'Le grand portrait sur le mur représente la reine Isabel II elle-même — un cadeau de la couronne aux hôtes en remerciement de leur hospitalité.',
  NULL, NULL, NULL
FROM pois WHERE number = 11
ON CONFLICT (poi_id, language) DO NOTHING;

-- ─── POI 12 — Silla gótica y Grabados ────────────────────────────────────────

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'en',
  'Gothic Chair and Engravings',
  'The centrepiece of this room is a carved wooden chair in the Catalan Gothic style, dating from the fifteenth century — one of the oldest pieces of furniture preserved in a private house in Mallorca. '
  'Its carvings depict religious scenes and heraldic motifs linked to the Fortuny family, who inhabited the estate during the medieval period; its extraordinary preservation is partly due to the favourable microclimate created by the thick stone walls. '
  'The walls display a collection of seventeenth and eighteenth-century engravings showing European city views, island maps, and portraits of historical figures connected to the history of Mallorca.',
  NULL, NULL, NULL
FROM pois WHERE number = 12
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'de',
  'Gotischer Stuhl und Stiche',
  'Das Herzstück dieses Raumes ist ein geschnitzter Holzstuhl im katalanisch-gotischen Stil aus dem fünfzehnten Jahrhundert — eines der ältesten erhaltenen Möbelstücke in einem Privathaus auf Mallorca. '
  'Seine Schnitzereien zeigen religiöse Szenen und heraldische Motive der Familie Fortuny, die das Anwesen im Mittelalter bewohnte; der außerordentliche Erhaltungszustand ist teilweise dem günstigen Mikroklima der dicken Steinmauern zu verdanken. '
  'Die Wände zeigen eine Sammlung von Stichen aus dem siebzehnten und achtzehnten Jahrhundert mit Stadtansichten, Inselkarten und Porträts historischer Persönlichkeiten der Geschichte Mallorcas.',
  NULL, NULL, NULL
FROM pois WHERE number = 12
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'ca',
  'Cadira gòtica i Gravats',
  'La peça central d''aquesta sala és una cadira de fusta tallada d''estil gòtic català, datada al segle XV — un dels mobles més antics conservats en una casa privada de Mallorca. '
  'Les seves talles representen escenes religioses i motius heràldics vinculats a la família Fortuny, que va habitar la finca durant el període medieval; l''estat de conservació extraordinari es deu en part al microclima favorable dels gruixuts murs de pedra. '
  'Les parets mostren una col·lecció de gravats dels segles XVII i XVIII que representen vistes de ciutats europees, mapes insulars i retrats de personatges històrics relacionats amb la història de Mallorca.',
  NULL, NULL, NULL
FROM pois WHERE number = 12
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'fr',
  'Chaise gothique et Gravures',
  'La pièce maîtresse de cette salle est une chaise en bois sculpté de style gothique catalan datant du XVe siècle — l''un des meubles les plus anciens conservés dans une maison privée de Majorque. '
  'Ses sculptures représentent des scènes religieuses et des motifs héraldiques liés à la famille Fortuny, qui habitait la propriété pendant la période médiévale ; son état de conservation extraordinaire est en partie dû au microclimat favorable des épais murs de pierre. '
  'Les murs présentent une collection de gravures des XVIIe et XVIIIe siècles représentant des vues de villes européennes, des cartes insulaires et des portraits de personnages historiques liés à l''histoire de Majorque.',
  NULL, NULL, NULL
FROM pois WHERE number = 12
ON CONFLICT (poi_id, language) DO NOTHING;

-- ─── POI 13 — Artesonado mozárabe y Biblioteca ───────────────────────────────

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'en',
  'Mozarabic Coffered Ceiling and Library',
  'Look up: what you see above you is one of the best-preserved Mozarabic coffered ceilings in all of Spain, built in the fourteenth century by craftsmen who masterfully fused Islamic geometric decoration with Gothic European forms — a style known as Mudéjar. '
  'The repeating geometric patterns across the ceiling are characteristic of Islamic art, where human and animal representation was restricted for religious reasons, making geometry the supreme visual language. '
  'Beneath this exceptional ceiling lies the family library, holding several hundred volumes including incunabula and manuscripts from the sixteenth and seventeenth centuries, as well as original notarial documents dating back to the thirteenth century.',
  NULL, NULL, NULL
FROM pois WHERE number = 13
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'de',
  'Maurische Kassettendecke und Bibliothek',
  'Blicken Sie nach oben: Was Sie über sich sehen, ist eine der am besten erhaltenen mozarabischen Kassettendecken in ganz Spanien, im vierzehnten Jahrhundert von Handwerkern erbaut, die islamische geometrische Dekoration meisterhaft mit gotischen europäischen Formen verbanden — ein Stil, der als Mudéjar bekannt ist. '
  'Die sich wiederholenden geometrischen Muster sind charakteristisch für die islamische Kunst, wo die Darstellung von Menschen und Tieren aus religiösen Gründen eingeschränkt war, wodurch Geometrie zur höchsten visuellen Sprache wurde. '
  'Unter dieser außergewöhnlichen Decke befindet sich die Familienbibliothek mit mehreren hundert Bänden, darunter Inkunabeln und Manuskripte aus dem sechzehnten und siebzehnten Jahrhundert sowie originale Notariatsdokumente bis zurück ins dreizehnte Jahrhundert.',
  NULL, NULL, NULL
FROM pois WHERE number = 13
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'ca',
  'Artesonat mozàrab i Biblioteca',
  'Aixequeu la vista: el que teniu sobre vosaltres és un dels artesonats mozàrabs millor conservats de tota Espanya, construït al segle XIV per artesans que van fusionar magistralment la decoració geomètrica islàmica amb formes del gòtic europeu — un estil conegut com a mudèjar. '
  'Els motius geomètrics repetits al llarg de l''artesonat són característics de l''art islàmic, on la representació de figures humanes o animals estava restringida per raons religioses, convertint la geometria en el llenguatge visual per excel·lència. '
  'Sota aquest sostre excepcional es troba la biblioteca familiar, que alberga uns quants centenars de volums incloent incunables i manuscrits dels segles XVI i XVII, així com documents notarials originals que es remunten al segle XIII.',
  NULL, NULL, NULL
FROM pois WHERE number = 13
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'fr',
  'Plafond à caissons mozarabe et Bibliothèque',
  'Levez les yeux : ce que vous voyez au-dessus de vous est l''un des plafonds à caissons mozarabes les mieux conservés de toute l''Espagne, construit au XIVe siècle par des artisans qui ont magistralement fusionné la décoration géométrique islamique avec les formes du gothique européen — un style connu sous le nom de mudéjar. '
  'Les motifs géométriques répétés sur tout le plafond sont caractéristiques de l''art islamique, où la représentation d''êtres humains et d''animaux était restreinte pour des raisons religieuses, faisant de la géométrie le langage visuel par excellence. '
  'Sous ce plafond exceptionnel se trouve la bibliothèque familiale, contenant plusieurs centaines de volumes dont des incunables et manuscrits des XVIe et XVIIe siècles, ainsi que des documents notariaux originaux remontant au XIIIe siècle.',
  NULL, NULL, NULL
FROM pois WHERE number = 13
ON CONFLICT (poi_id, language) DO NOTHING;

-- ─── POI 14 — Sala de entrada y Escudos ──────────────────────────────────────

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'en',
  'Entrance Hall and Heraldic Shields',
  'This is the representative hall of the house, where owners received their most formal visitors over the centuries; its walls are dominated by an impressive collection of heraldic shields representing the lineages connected to the Alfabia family. '
  'Heraldry was for centuries far more than a matter of protocol — it was a system of identity, belonging, and legitimacy with concrete legal and political consequences. '
  'The largest shield above the main fireplace belongs to the Burgues-Zaforteza family, owners since the seventeenth century; the smaller shields on either side represent the lineages with which they intermarried over the generations.',
  NULL, NULL, NULL
FROM pois WHERE number = 14
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'de',
  'Eingangshalle und Wappen',
  'Dies ist der Repräsentationssaal des Hauses, in dem die Eigentümer über die Jahrhunderte ihre formalsten Besucher empfingen; seine Wände werden von einer beeindruckenden Sammlung heraldischer Wappen dominiert, die die mit der Familie Alfabia verbundenen Geschlechter darstellen. '
  'Heraldik war jahrhundertelang weit mehr als eine Frage des Protokolls — sie war ein System der Identität, Zugehörigkeit und Legitimität mit konkreten rechtlichen und politischen Konsequenzen. '
  'Das größte Wappen über dem Hauptkamin gehört der Familie Burgues-Zaforteza, Eigentümer seit dem siebzehnten Jahrhundert; die kleineren Wappen auf beiden Seiten repräsentieren die Geschlechter, mit denen sie sich im Laufe der Generationen verschwägerten.',
  NULL, NULL, NULL
FROM pois WHERE number = 14
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'ca',
  'Sala d''entrada i Escuts',
  'Aquesta és la sala de representació de la casa, on els propietaris rebien les seves visites més formals al llarg dels segles; les seves parets estan dominades per una impressionant col·lecció d''escuts heràldics que representen els llinatges vinculats a la família d''Alfabia. '
  'L''heràldica va ser durant segles molt més que una qüestió de protocol — era un sistema d''identitat, pertinença i legitimitat amb conseqüències jurídiques i polítiques molt concretes. '
  'L''escut de major grandària sobre la xemeneia principal correspon a la família Burgues-Zaforteza, propietaris des del segle XVII; els escuts més petits a banda i banda representen els llinatges amb els quals van emparentar al llarg de les generacions.',
  NULL, NULL, NULL
FROM pois WHERE number = 14
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'fr',
  'Salle d''entrée et Blasons',
  'Voici la salle de représentation de la maison, où les propriétaires recevaient leurs visiteurs les plus formels au fil des siècles ; ses murs sont dominés par une impressionnante collection d''écus héraldiques représentant les lignées liées à la famille d''Alfabia. '
  'L''héraldique fut pendant des siècles bien plus qu''une question de protocole — c''était un système d''identité, d''appartenance et de légitimité aux conséquences juridiques et politiques très concrètes. '
  'Le plus grand écu au-dessus de la cheminée principale appartient à la famille Burgues-Zaforteza, propriétaires depuis le XVIIe siècle ; les écus plus petits de chaque côté représentent les lignées avec lesquelles ils se sont alliés par mariage au fil des générations.',
  NULL, NULL, NULL
FROM pois WHERE number = 14
ON CONFLICT (poi_id, language) DO NOTHING;

-- ─── POI 15 — Galería porticada y Pasillo hereditario ────────────────────────

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'en',
  'Porticoed Gallery and Hereditary Corridor',
  'The porticoed gallery you are walking through is one of Alfabia''s most elegant architectural spaces: its round arches in the golden sandstone characteristic of Mallorcan architecture create a serene rhythm connecting the interior with the courtyard and gardens. '
  'On the walls of this corridor you will find the estate''s original hereditary documents, framed and protected under glass — parchments and notarial papers spanning several centuries that constitute the family''s material genealogical tree and the legal history of the property. '
  'You have now completed the visit to the house; the outer dependencies await you.',
  NULL, NULL, NULL
FROM pois WHERE number = 15
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'de',
  'Portikus-Galerie und Erbschaftsflur',
  'Die Portikus-Galerie, durch die Sie gehen, ist einer der elegantesten Architekturräume von Alfabia: ihre Rundbögen aus dem goldenen Sandstein, der für die mallorquinische Architektur charakteristisch ist, schaffen einen ruhigen Rhythmus zwischen Hausinneren, Innenhof und Gärten. '
  'An den Wänden dieses Korridors finden Sie die originalen Erbschaftsdokumente des Anwesens, gerahmt und unter Glas geschützt — Pergamente und Notariatspapiere, die mehrere Jahrhunderte umspannen und den materiellen Stammbaum der Familie sowie die Rechtsgeschichte der Liegenschaft darstellen. '
  'Sie haben nun den Besuch des Hauses abgeschlossen; die Außendependancen erwarten Sie.',
  NULL, NULL, NULL
FROM pois WHERE number = 15
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'ca',
  'Galeria porxada i Passadís hereditari',
  'La galeria porxada que recorreu ara és un dels espais arquitectònics més elegants d''Alfabia: els seus arcs de mig punt, construïts en la pedra arenosa daurada característica de l''arquitectura mallorquina, creen un ritme serè que connecta l''interior de la casa amb el pati i els jardins. '
  'A les parets d''aquest passadís trobareu els documents hereditaris originals de la finca, emmarcats i protegits sota vidre — pergamins i papers notarials que abasten diversos segles i constitueixen l''arbre genealògic material de la família i la història legal de la propietat. '
  'Heu completat la visita a la casa; les dependències exteriors us esperen.',
  NULL, NULL, NULL
FROM pois WHERE number = 15
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'fr',
  'Galerie à portiques et Couloir héréditaire',
  'La galerie à portiques que vous traversez est l''un des espaces architecturaux les plus élégants d''Alfabia : ses arcs en plein cintre en grès doré caractéristique de l''architecture majorquine créent un rythme serein reliant l''intérieur de la maison à la cour et aux jardins. '
  'Sur les murs de ce couloir vous trouverez les documents héréditaires originaux de la propriété, encadrés et protégés sous verre — parchemins et papiers notariaux couvrant plusieurs siècles qui constituent l''arbre généalogique matériel de la famille et l''histoire juridique de la propriété. '
  'Vous avez maintenant terminé la visite de la maison ; les dépendances extérieures vous attendent.',
  NULL, NULL, NULL
FROM pois WHERE number = 15
ON CONFLICT (poi_id, language) DO NOTHING;

-- ─── POI 16 — Clastra, Capilla y Tienda ──────────────────────────────────────

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'en',
  'Clastra, Chapel and Shop',
  'Leaving the main house you arrive at the clastra, the central courtyard that organises the estate''s outbuildings — a typical architectural element of Mallorcan country estates, around which stables, storehouses, the oil mill, staff quarters, and the chapel are arranged. '
  'The family chapel to your left, consecrated to the Virgin, preserves an eighteenth-century altarpiece and ex-votos of great devotional value. '
  'Before leaving Alfabia, we invite you to visit our shop, where you will find artisan products from the estate, publications on the history of the gardens, jams made from the orchard''s fruits, and a selection of items related to Mallorcan culture and nature.',
  NULL, NULL, NULL
FROM pois WHERE number = 16
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'de',
  'Clastra, Kapelle und Laden',
  'Wenn Sie das Haupthaus verlassen, gelangen Sie zur Clastra, dem zentralen Innenhof, der die Nebengebäude organisiert — ein typisches Architekturelement mallorquinischer Landhäuser, um das sich Ställe, Lagerhäuser, Ölmühle, Personalquartiere und die Kapelle gruppieren. '
  'Die Familienkapelle zu Ihrer Linken, der Jungfrau geweiht, bewahrt ein Altarbild aus dem achtzehnten Jahrhundert und Votivgaben von großem devotionalen Wert. '
  'Bevor Sie Alfabia verlassen, laden wir Sie ein, unseren Laden zu besuchen, in dem Sie handwerkliche Produkte, Veröffentlichungen zur Geschichte der Gärten, Marmeladen aus dem Obstgarten und eine Auswahl von Artikeln zur mallorquinischen Kultur und Natur finden.',
  NULL, NULL, NULL
FROM pois WHERE number = 16
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'ca',
  'Clastra, Capella i Botiga',
  'En sortir de la casa principal, arribeu a la clastra, el pati central que organitza el conjunt de les dependències — un element arquitectònic típic de les possessions mallorquines al voltant del qual es distribueixen els estables, els magatzems, l''almàssera, els quarts del personal i la capella. '
  'La capella familiar a la vostra esquerra, consagrada a la Verge, conserva un retaule del segle XVIII i alguns exvots de gran valor devocional. '
  'Abans d''abandonar Alfabia us convidem a visitar la nostra botiga, on trobareu productes artesanals de la finca, publicacions sobre la història dels jardins, melmelades dels fruits de l''hort i una selecció d''articles relacionats amb la cultura i la natura de Mallorca.',
  NULL, NULL, NULL
FROM pois WHERE number = 16
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'fr',
  'Clastra, Chapelle et Boutique',
  'En quittant la maison principale, vous arrivez à la clastra, la cour centrale qui organise les dépendances de la propriété — un élément architectural typique des domaines ruraux majorquins autour duquel s''organisent écuries, entrepôts, moulin à huile, logements du personnel et chapelle. '
  'La chapelle familiale à votre gauche, consacrée à la Vierge, conserve un retable du XVIIIe siècle et des ex-votos d''une grande valeur dévotionnelle. '
  'Avant de quitter Alfabia, nous vous invitons à visiter notre boutique, où vous trouverez des produits artisanaux de la propriété, des publications sur l''histoire des jardins, des confitures élaborées avec les fruits du verger et une sélection d''articles liés à la culture et à la nature de Majorque.',
  NULL, NULL, NULL
FROM pois WHERE number = 16
ON CONFLICT (poi_id, language) DO NOTHING;

-- ─── POI 17 — Establo y Almazara ─────────────────────────────────────────────

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'en',
  'Stable and Oil Mill',
  'The stable and oil mill together perfectly illustrate the productive dimension of the estate over the centuries. '
  'The stable, with its stone arches and original mangers still in place, once housed the horses and mules indispensable for agricultural work; the adjacent oil mill houses a large wooden press dating from the eighteenth century that remained in operation until the mid-twentieth century. '
  'Today the oil mill no longer produces oil, but its perfectly preserved original machinery is a living testimony to the agricultural culture that gave life to this estate for centuries.',
  NULL, NULL, NULL
FROM pois WHERE number = 17
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'de',
  'Stall und Ölmühle',
  'Stall und Ölmühle veranschaulichen zusammen perfekt die produktive Dimension des Anwesens über die Jahrhunderte. '
  'Der Stall mit seinen Steinbögen und noch vorhandenen Krippen beherbergte einst die für die Landwirtschaft unverzichtbaren Pferde und Maultiere; die angrenzende Ölmühle beherbergt eine große Holzpresse aus dem achtzehnten Jahrhundert, die bis Mitte des zwanzigsten Jahrhunderts in Betrieb war. '
  'Heute produziert die Ölmühle kein Öl mehr, aber ihre perfekt erhaltene Originalmaschinerie ist ein lebendiges Zeugnis der Agrarkultur, die dieses Anwesen jahrhundertelang belebte.',
  NULL, NULL, NULL
FROM pois WHERE number = 17
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'ca',
  'Estable i Almàssera',
  'L''estable i l''almàssera il·lustren junts perfectament la dimensió productiva de la finca al llarg dels segles. '
  'L''estable, amb els seus arcs de pedra i els pessebrells encara al seu lloc original, albergava en altres temps els cavalls i mules imprescindibles per al treball agrícola; l''almàssera contigua alberga una gran premsa de fusta del segle XVIII que va estar en funcionament fins a mitjan del segle XX. '
  'Avui l''almàssera ja no produeix oli, però la seva maquinària original perfectament conservada és un testimoni viu de la cultura agrícola que durant segles va donar vida a aquesta finca.',
  NULL, NULL, NULL
FROM pois WHERE number = 17
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'fr',
  'Écurie et Moulin à huile',
  'L''écurie et le moulin à huile illustrent ensemble parfaitement la dimension productive de la propriété au fil des siècles. '
  'L''écurie, avec ses arcs de pierre et ses mangeoires encore en place, abritait autrefois les chevaux et mules indispensables au travail agricole ; le moulin à huile adjacent abrite une grande presse en bois du XVIIIe siècle qui resta en service jusqu''au milieu du XXe siècle. '
  'Aujourd''hui le moulin ne produit plus d''huile, mais sa machinerie originale parfaitement conservée témoigne de la culture agricole qui a animé cette propriété pendant des siècles.',
  NULL, NULL, NULL
FROM pois WHERE number = 17
ON CONFLICT (poi_id, language) DO NOTHING;

-- ─── POI 18 — Despedida y Cierre ─────────────────────────────────────────────

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'en',
  'Farewell',
  'You have reached the end of your visit to the Gardens of Alfabia — we hope this has been a memorable experience and that you carry with you not only memories and images, but also a piece of the history and soul of Mallorca. '
  'If you have enjoyed your visit, we would be very grateful if you shared your experience on Google Reviews; your feedback helps us reach more visitors and continue maintaining this unique space. '
  'We also organise themed guided tours, sunset concerts, and special activities throughout the year — follow us on social media to stay up to date. Thank you, and until next time at the Gardens of Alfabia.',
  NULL, NULL, NULL
FROM pois WHERE number = 18
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'de',
  'Auf Wiedersehen',
  'Sie haben das Ende Ihres Besuchs in den Gärten von Alfabia erreicht — wir hoffen, dass dies ein unvergessliches Erlebnis war und dass Sie nicht nur Erinnerungen und Bilder, sondern auch ein Stück Geschichte und Seele Mallorcas mit sich tragen. '
  'Wenn Ihnen der Besuch gefallen hat, wären wir sehr dankbar, wenn Sie Ihre Erfahrung auf Google Reviews teilen würden; Ihre Bewertungen helfen uns, mehr Besucher zu erreichen und diesen einzigartigen Ort weiter zu pflegen. '
  'Wir veranstalten auch thematische Führungen, Konzerte bei Sonnenuntergang und besondere Aktivitäten das ganze Jahr über — folgen Sie uns in den sozialen Medien. Vielen Dank und bis bald in den Gärten von Alfabia.',
  NULL, NULL, NULL
FROM pois WHERE number = 18
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'ca',
  'Comiat',
  'Heu arribat al final del recorregut pels Jardins d''Alfabia — esperem que aquesta visita hagi estat una experiència memorable i que us endingueu no només records i imatges, sinó també un tros de la història i l''ànima de Mallorca. '
  'Si la visita us ha agradat, us agrairíem enormement que compartíssiu la vostra experiència a Google Reviews; les vostres valoracions ens ajuden a arribar a més visitants i a seguir mantenint aquest espai únic. '
  'Organitzem també visites guiades temàtiques, concerts al capvespre i activitats especials al llarg de l''any — seguiu-nos a les xarxes socials. Gràcies i fins aviat als Jardins d''Alfabia.',
  NULL, NULL, NULL
FROM pois WHERE number = 18
ON CONFLICT (poi_id, language) DO NOTHING;

INSERT INTO translations (poi_id, language, title, description, audio_url_mp3, audio_url_ogg, audio_size_bytes)
SELECT id, 'fr',
  'Au revoir',
  'Vous avez atteint la fin de votre visite aux Jardins d''Alfabia — nous espérons que cette expérience a été mémorable et que vous emportez avec vous non seulement des souvenirs et des images, mais aussi un morceau de l''histoire et de l''âme de Majorque. '
  'Si votre visite vous a plu, nous vous serions très reconnaissants de partager votre expérience sur Google Reviews ; vos évaluations nous aident à toucher plus de visiteurs et à continuer à entretenir cet espace unique. '
  'Nous organisons également des visites guidées thématiques, des concerts au coucher du soleil et des activités spéciales tout au long de l''année — suivez-nous sur les réseaux sociaux. Merci et à bientôt aux Jardins d''Alfabia.',
  NULL, NULL, NULL
FROM pois WHERE number = 18
ON CONFLICT (poi_id, language) DO NOTHING;

COMMIT;
