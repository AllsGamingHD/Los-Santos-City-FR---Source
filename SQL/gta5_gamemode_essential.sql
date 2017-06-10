-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Client :  127.0.0.1
-- Généré le :  Ven 02 Juin 2017 à 17:37
-- Version du serveur :  5.7.14
-- Version de PHP :  5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `gta5_gamemode_essential`
--

-- --------------------------------------------------------

--
-- Structure de la table `bans`
--

CREATE TABLE `bans` (
  `id` int(10) UNSIGNED NOT NULL,
  `banned` varchar(50) NOT NULL DEFAULT '0',
  `banner` varchar(50) NOT NULL,
  `reason` varchar(150) NOT NULL DEFAULT '0',
  `expires` datetime NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `coordinates`
--

CREATE TABLE `coordinates` (
  `id` int(11) UNSIGNED NOT NULL,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `z` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `coordinates`
--

INSERT INTO `coordinates` (`id`, `x`, `y`, `z`) VALUES
(1, 2222.84301757813, 5578.4443359375, 53.7291946411133),
(2, 2477.29931640625, 3784.62109375, 41.4352760314941),
(3, -1476.54870605469, 171.836669921875, 55.8890762329102),
(4, -596.851, 2090.85, 130.68),
(5, 2713.46, 1652.24, 24.358),
(6, 132.698, -378.574, 43.0553),
(7, 2875.08, 4651.49, 48.1153),
(8, -1350.2, 4843.57, 137.616),
(9, 1174.52, 2725.68, 37.629),
(10, -1812.52, 2132.77, 125.379),
(11, 837.595, -1931.65, 28.5999),
(12, 474.555, -1857.27, 27.1367),
(13, -2287.62, 357.993, 174.602),
(14, -2945.45, 482.45, 14.8777),
(15, -285.018, -1921.89, 29.946),
(16, 1431.78, -2094.28, 54.2555),
(17, 621.486, -2795.37, 5.82042),
(18, 653.939, 277.673, 102.798),
(19, -458.678, -2223.53, 0.0563157),
(20, 1199.4, 3330.14, 5.53372),
(21, -1056.12, -1371.66, 4.64688),
(22, 2313.55, 5118.42, 48.3041),
(23, 749.045, -1858.53, 28.7954),
(24, -1114.74, -1257.8, 5.9775),
(25, -1545.21, 4419.82, 2.57718),
(26, -578.518, 5276.92, 70.4162),
(27, -97.6906, -965.082, 20.7751),
(28, 2436.29, 5013.85, 46.1963),
(29, -84.263, 6234.88, 31.0917),
(30, -137.52, -256.173, 43.595);

-- --------------------------------------------------------

--
-- Structure de la table `items`
--

CREATE TABLE `items` (
  `id` int(11) UNSIGNED NOT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `limitation` int(11) NOT NULL DEFAULT '40',
  `isIllegal` tinyint(1) NOT NULL DEFAULT '0',
  `value` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `items`
--

INSERT INTO `items` (`id`, `libelle`, `limitation`, `isIllegal`, `value`, `type`) VALUES
(1, 'Weed', 20, 1, 0, 0),
(2, 'Pefra', 20, 1, 0, 0),
(4, 'Cuivre', 40, 0, 0, 0),
(5, 'Lingo de Cuivre', 40, 0, 0, 0),
(6, 'Patate sales', 40, 0, 0, 0),
(7, 'Patate propre', 40, 0, 0, 0),
(8, 'Grappe de raisins', 40, 0, 0, 0),
(9, 'Tonneau de vins', 40, 0, 0, 0),
(10, 'Argents sales', 40, 0, 0, 0),
(11, 'Argents propres', 40, 0, 0, 0),
(12, 'Pétrole pur', 40, 0, 0, 0),
(13, 'Essences', 40, 0, 0, 0),
(14, 'Poissons frais', 40, 0, 0, 0),
(15, 'Poissons traités', 40, 0, 0, 0),
(16, 'Plantes d\'alcool', 40, 0, 0, 0),
(17, 'Alcool pur', 40, 0, 0, 0),
(18, 'Buches', 40, 0, 0, 0),
(19, 'Copeaux de bois', 40, 0, 0, 0),
(20, 'Poulets', 40, 0, 0, 0),
(21, ' Ailes de poulets', 40, 0, 0, 0),
(22, 'Bouteille d\'eau', 40, 0, 20, 1),
(23, 'sandwich', 40, 0, 20, 2);

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

CREATE TABLE `jobs` (
  `job_id` int(11) NOT NULL,
  `job_name` varchar(40) NOT NULL,
  `salary` int(11) NOT NULL DEFAULT '500'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `jobs`
--

INSERT INTO `jobs` (`job_id`, `job_name`, `salary`) VALUES
(1, 'Chomeur', 100),
(2, 'Mineur', 200),
(3, 'Fermier', 200),
(4, 'Vigneron', 200),
(5, 'Convoyeur de fonds', 200),
(6, 'Petrolier', 200),
(7, 'Pecheur', 200),
(8, 'Brasseur', 200),
(9, 'Bucheron', 200),
(10, 'Eleveur de poulets', 200),
(11, 'Jobs Illégal', 50),
(12, 'Policer [Hors-Service]', 750),
(13, 'Policer [En Service]', 750),
(14, 'Ambulancier', 700),
(15, 'Président', 1500);

-- --------------------------------------------------------

--
-- Structure de la table `licences`
--

CREATE TABLE `licences` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `licences`
--

INSERT INTO `licences` (`id`, `name`, `price`) VALUES
(1, 'De conduire', 1000),
(2, 'De port d\'arme', 5000);

-- --------------------------------------------------------

--
-- Structure de la table `personalvehicle`
--

CREATE TABLE `personalvehicle` (
  `id` int(11) NOT NULL,
  `owner` varchar(255) NOT NULL DEFAULT '0',
  `vehicle` varchar(255) NOT NULL DEFAULT '0',
  `colorp` varchar(255) NOT NULL DEFAULT '0',
  `colors` varchar(255) NOT NULL DEFAULT '0',
  `auto_upgrade` int(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `police`
--

CREATE TABLE `police` (
  `identifier` varchar(255) NOT NULL,
  `rank` varchar(255) NOT NULL DEFAULT 'Recrue'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `police_outfits`
--

CREATE TABLE `police_outfits` (
  `identifier` varchar(30) NOT NULL,
  `skin` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT 'mp_m_freemode_01',
  `face` int(11) NOT NULL DEFAULT '0',
  `face_text` int(11) NOT NULL DEFAULT '0',
  `hair` int(11) NOT NULL DEFAULT '0',
  `hair_text` int(11) NOT NULL DEFAULT '0',
  `pants` int(11) NOT NULL DEFAULT '0',
  `pants_text` int(11) NOT NULL DEFAULT '0',
  `shoes` int(11) NOT NULL DEFAULT '0',
  `shoes_text` int(11) NOT NULL DEFAULT '0',
  `torso` int(11) NOT NULL DEFAULT '0',
  `torso_text` int(11) NOT NULL DEFAULT '0',
  `shirt` int(11) NOT NULL DEFAULT '0',
  `shirt_text` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `president`
--

CREATE TABLE `president` (
  `identifier` varchar(255) NOT NULL,
  `rankpres` varchar(255) NOT NULL DEFAULT 'President'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `recolt`
--

CREATE TABLE `recolt` (
  `ID` int(11) UNSIGNED NOT NULL,
  `raw_id` int(11) UNSIGNED DEFAULT NULL,
  `treated_id` int(11) UNSIGNED DEFAULT NULL,
  `job_id` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `field_id` int(10) UNSIGNED DEFAULT NULL,
  `treatment_id` int(10) UNSIGNED DEFAULT NULL,
  `seller_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `recolt`
--

INSERT INTO `recolt` (`ID`, `raw_id`, `treated_id`, `job_id`, `price`, `field_id`, `treatment_id`, `seller_id`) VALUES
(1, 1, 2, 11, 3000, 1, 2, 3),
(2, 4, 5, 2, 65, 4, 5, 6),
(3, 6, 7, 3, 65, 7, 8, 9),
(4, 8, 9, 4, 75, 10, 11, 12),
(5, 10, 11, 5, 100, 13, 14, 15),
(6, 12, 13, 6, 80, 16, 17, 18),
(7, 14, 15, 7, 65, 19, 20, 21),
(8, 16, 17, 8, 90, 22, 23, 24),
(9, 18, 19, 9, 70, 25, 26, 27),
(10, 20, 21, 10, 70, 28, 29, 30);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `identifier` varchar(255) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
  `player_state` int(255) NOT NULL DEFAULT '0',
  `group` varchar(50) NOT NULL DEFAULT '0',
  `permission_level` int(11) NOT NULL DEFAULT '0',
  `money` double NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT '',
  `dirty_money` double NOT NULL DEFAULT '0',
  `personalvehicle` varchar(255) NOT NULL DEFAULT 'faggio2',
  `nom` varchar(128) NOT NULL DEFAULT '',
  `prenom` varchar(128) NOT NULL DEFAULT '',
  `dateNaissance` date DEFAULT '0000-01-01',
  `sexe` varchar(1) NOT NULL DEFAULT 'f',
  `taille` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `job` int(11) DEFAULT '1',
  `bankbalance` int(32) DEFAULT '0',
  `isFirstConnection` int(11) DEFAULT '1',
  `lastpos` varchar(255) DEFAULT '{-1049.59094238281, -2768.25708007813,  4.63980388641357, 308.763458251953}',
  `enService` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `user_clothes`
--

CREATE TABLE `user_clothes` (
  `identifier` varchar(255) NOT NULL,
  `skin` varchar(255) NOT NULL DEFAULT 'mp_m_freemode_01',
  `face` varchar(255) NOT NULL DEFAULT '0',
  `face_texture` varchar(255) NOT NULL DEFAULT '0',
  `hair` varchar(255) NOT NULL DEFAULT '11',
  `hair_texture` varchar(255) NOT NULL DEFAULT '4',
  `shirt` varchar(255) NOT NULL DEFAULT '0',
  `shirt_texture` varchar(255) NOT NULL DEFAULT '0',
  `pants` varchar(255) NOT NULL DEFAULT '8',
  `pants_texture` varchar(255) NOT NULL DEFAULT '0',
  `shoes` varchar(255) NOT NULL DEFAULT '1',
  `shoes_texture` varchar(255) NOT NULL DEFAULT '0',
  `vest` varchar(255) NOT NULL DEFAULT '0',
  `vest_texture` varchar(255) NOT NULL DEFAULT '0',
  `bag` varchar(255) NOT NULL DEFAULT '40',
  `bag_texture` varchar(255) NOT NULL DEFAULT '0',
  `hat` varchar(255) NOT NULL DEFAULT '1',
  `hat_texture` varchar(255) NOT NULL DEFAULT '1',
  `mask` varchar(255) NOT NULL DEFAULT '0',
  `mask_texture` varchar(255) NOT NULL DEFAULT '0',
  `glasses` varchar(255) NOT NULL DEFAULT '6',
  `glasses_texture` varchar(255) NOT NULL DEFAULT '0',
  `gloves` varchar(255) NOT NULL DEFAULT '2',
  `gloves_texture` varchar(255) NOT NULL DEFAULT '0',
  `jacket` varchar(255) NOT NULL DEFAULT '7',
  `jacket_texture` varchar(255) NOT NULL DEFAULT '2',
  `ears` varchar(255) NOT NULL DEFAULT '1',
  `ears_texture` varchar(255) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `user_inventory`
--

CREATE TABLE `user_inventory` (
  `user_id` varchar(255) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
  `item_id` int(11) UNSIGNED NOT NULL,
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `user_licence`
--

CREATE TABLE `user_licence` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `licence_id` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `user_vehicle`
--

CREATE TABLE `user_vehicle` (
  `ID` int(11) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `vehicle_name` varchar(60) DEFAULT NULL,
  `vehicle_model` varchar(60) DEFAULT NULL,
  `vehicle_price` int(11) DEFAULT NULL,
  `vehicle_plate` varchar(60) DEFAULT NULL,
  `vehicle_state` varchar(60) DEFAULT NULL,
  `vehicle_colorprimary` varchar(60) DEFAULT NULL,
  `vehicle_colorsecondary` varchar(60) DEFAULT NULL,
  `vehicle_pearlescentcolor` varchar(60) NOT NULL,
  `vehicle_wheelcolor` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `user_weapons`
--

CREATE TABLE `user_weapons` (
  `ID` int(10) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `weapon_model` varchar(60) NOT NULL,
  `withdraw_cost` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `vehicles`
--

CREATE TABLE `vehicles` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` int(255) NOT NULL,
  `model` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `vehicles`
--

INSERT INTO `vehicles` (`id`, `name`, `price`, `model`) VALUES
(1, 'Blista', 15000, 'blista'),
(2, 'Brioso R/A', 155000, 'brioso'),
(3, 'Dilettante', 25000, 'Dilettante'),
(4, 'Issi', 18000, 'issi2'),
(5, 'Panto', 85000, 'panto'),
(6, 'Prairie', 30000, 'prairie'),
(7, 'Rhapsody', 120000, 'rhapsody'),
(8, 'Cognoscenti Cabrio', 180000, 'cogcabrio'),
(9, 'Exemplar', 200000, 'exemplar'),
(10, 'F620', 80000, 'f620'),
(11, 'Felon', 90000, 'felon'),
(12, 'Felon GT', 95000, 'felon2'),
(13, 'Jackal', 60000, 'jackal'),
(14, 'Oracle', 80000, 'oracle'),
(15, 'Oracle XS', 82000, 'oracle2'),
(16, 'Sentinel', 90000, 'sentinel'),
(17, 'Sentinel XS', 60000, 'sentinel2'),
(18, 'Windsor', 800000, 'windsor'),
(19, 'Windsor Drop', 850000, 'windsor2'),
(20, 'Zion', 60000, 'zion'),
(21, 'Zion Cabrio', 65000, 'zion2'),
(22, '9F', 120000, 'ninef'),
(23, '9F Cabrio', 130000, 'ninef2'),
(24, 'Alpha', 150000, 'alpha'),
(25, 'Banshee', 105000, 'banshee'),
(26, 'Bestia GTS', 610000, 'bestiagts'),
(27, 'Blista Compact', 42000, 'blista'),
(28, 'Buffalo', 35000, 'buffalo'),
(29, 'Buffalo S', 96000, 'buffalo2'),
(30, 'Carbonizzare', 195000, 'carbonizzare'),
(31, 'Comet', 100000, 'comet2'),
(32, 'Coquette', 138000, 'coquette'),
(33, 'Drift Tampa', 995000, 'tampa2'),
(34, 'Feltzer', 130000, 'feltzer2'),
(35, 'Furore GT', 448000, 'furoregt'),
(36, 'Fusilade', 36000, 'fusilade'),
(37, 'Jester', 240000, 'jester'),
(38, 'Jester(Racecar)', 350000, 'jester2'),
(39, 'Kuruma', 95000, 'kuruma'),
(40, 'Lynx', 1735000, 'lynx'),
(41, 'Massacro', 275000, 'massacro'),
(42, 'Massacro(Racecar)', 385000, 'massacro2'),
(43, 'Omnis', 701000, 'omnis'),
(44, 'Penumbra', 24000, 'penumbra'),
(45, 'Rapid GT', 140000, 'rapidgt'),
(46, 'Rapid GT Convertible', 150000, 'rapidgt2'),
(47, 'Schafter V12', 140000, 'schafter3'),
(48, 'Sultan', 12000, 'sultan'),
(49, 'Surano', 110000, 'surano'),
(50, 'Tropos', 816000, 'tropos'),
(51, 'Verkierer', 695000, 'verlierer2'),
(52, 'Casco', 680000, 'casco'),
(53, 'Coquette Classic', 665000, 'coquette2'),
(54, 'JB 700', 350000, 'jb700'),
(55, 'Pigalle', 400000, 'pigalle'),
(56, 'Stinger', 850000, 'stinger'),
(57, 'Stinger GT', 875000, 'stingergt'),
(58, 'Stirling GT', 975000, 'feltzer3'),
(59, 'Z-Type', 950000, 'ztype'),
(60, 'Adder', 1000000, 'adder'),
(61, 'Banshee 900R', 565000, 'banshee2'),
(62, 'Bullet', 155000, 'bullet'),
(63, 'Cheetah', 650000, 'cheetah'),
(64, 'Entity XF', 795000, 'entityxf'),
(65, 'ETR1', 199500, 'sheava'),
(66, 'FMJ', 1750000, 'fmj'),
(67, 'Infernus', 440000, 'infernus'),
(68, 'Osiris', 1950000, 'osiris'),
(69, 'RE-7B', 2475000, 'le7b'),
(70, 'Reaper', 1595000, 'reaper'),
(71, 'Sultan RS', 795000, 'sultanrs'),
(72, 'T20', 2200000, 't20'),
(73, 'Turismo R', 500000, 'turismor'),
(74, 'Tyrus', 2550000, 'tyrus'),
(75, 'Vacca', 240000, 'vacca'),
(76, 'Voltic', 150000, 'voltic'),
(77, 'X80 Proto', 2700000, 'prototipo'),
(78, 'Zentorno', 725000, 'zentorno'),
(79, 'Blade', 160000, 'blade'),
(80, 'Buccaneer', 29000, 'buccaneer'),
(81, 'Chino', 225000, 'chino'),
(82, 'Coquette BlackFin', 695000, 'coquette3'),
(83, 'Dominator', 35000, 'dominator'),
(84, 'Dukes', 62000, 'dukes'),
(85, 'Gauntlet', 32000, 'gauntlet'),
(86, 'Hotknife', 90000, 'hotknife'),
(87, 'Faction', 36000, 'faction'),
(88, 'Nightshade', 585000, 'nightshade'),
(89, 'Picador', 9000, 'picador'),
(90, 'Sabre Turbo', 15000, 'sabregt'),
(91, 'Tampa', 375000, 'tampa'),
(92, 'Virgo', 195000, 'virgo'),
(93, 'Vigero', 21000, 'vigero'),
(94, 'Bifta', 75000, 'bifta'),
(95, 'Blazer', 8000, 'blazer'),
(96, 'Brawler', 715000, 'brawler'),
(97, 'Bubsta 6x6', 249000, 'dubsta3'),
(98, 'Dune Buggy', 20000, 'dune'),
(99, 'Rebel', 22000, 'rebel2'),
(100, 'Sandking', 38000, 'sandking'),
(101, 'The Liberator', 550000, 'monster'),
(102, 'Trophy Truck', 550000, 'trophytruck'),
(103, 'Baller', 90000, 'baller'),
(104, 'Cavalcade', 60000, 'cavalcade'),
(105, 'Grabger', 35000, 'granger'),
(106, 'Huntley S', 195000, 'huntley'),
(107, 'Landstalker', 58000, 'landstalker'),
(108, 'Radius', 32000, 'radi'),
(109, 'Rocoto', 85000, 'rocoto'),
(110, 'Seminole', 30000, 'seminole'),
(111, 'XLS', 253000, 'xls'),
(112, 'Bison', 30000, 'bison'),
(113, 'Bobcat XL', 23000, 'bobcatxl'),
(114, 'Gang Burrito', 65000, 'gburrito'),
(115, 'Journey', 15000, 'journey'),
(116, 'Minivan', 30000, 'minivan'),
(117, 'Paradise', 25000, 'paradise'),
(118, 'Rumpo', 13000, 'rumpo'),
(119, 'Surfer', 11000, 'surfer'),
(120, 'Youga', 16000, 'youga'),
(121, 'Asea', 1000000, 'asea'),
(122, 'Asterope', 1000000, 'asterope'),
(123, 'Fugitive', 24000, 'fugitive'),
(124, 'Glendale', 200000, 'glendale'),
(125, 'Ingot', 9000, 'ingot'),
(126, 'Intruder', 16000, 'intruder'),
(127, 'Premier', 10000, 'premier'),
(128, 'Primo', 9000, 'primo'),
(129, 'Primo Custom', 9500, 'primo2'),
(130, 'Regina', 8000, 'regina'),
(131, 'Schafter', 65000, 'schafter2'),
(132, 'Stanier', 10000, 'stanier'),
(133, 'Stratum', 10000, 'stratum'),
(134, 'Stretch', 30000, 'stretch'),
(135, 'Super Diamond', 250000, 'superd'),
(136, 'Surge', 38000, 'surge'),
(137, 'Tailgater', 55000, 'tailgater'),
(138, 'Warrener', 120000, 'warrener'),
(139, 'Washington', 15000, 'washington'),
(140, 'Akuma', 9000, 'AKUMA'),
(141, 'Bagger', 5000, 'bagger'),
(142, 'Bati 801', 15000, 'bati'),
(143, 'Bati 801RR', 15000, 'bati2'),
(144, 'BF400', 95000, 'bf400'),
(145, 'Carbon RS', 40000, 'carbonrs'),
(146, 'Cliffhanger', 225000, 'cliffhanger'),
(147, 'Daemon', 5000, 'daemon'),
(148, 'Double T', 12000, 'double'),
(149, 'Enduro', 48000, 'enduro'),
(150, 'Faggio', 4000, 'faggio2'),
(151, 'Gargoyle', 120000, 'gargoyle'),
(152, 'Hakuchou', 82000, 'hakuchou'),
(153, 'Hexer', 15000, 'hexer'),
(154, 'Innovation', 90000, 'innovation'),
(155, 'Lectro', 700000, 'lectro'),
(156, 'Nemesis', 12000, 'nemesis'),
(157, 'PCJ-600', 9000, 'pcj'),
(158, 'Ruffian', 9000, 'ruffian'),
(159, 'Sanchez', 7000, 'sanchez'),
(160, 'Sovereign', 90000, 'sovereign'),
(161, 'Thrust', 75000, 'thrust'),
(162, 'Vader', 9000, 'vader'),
(163, 'Vindicator', 600000, 'vindicator');

--
-- Index pour les tables exportées
--

--
-- Index pour la table `bans`
--
ALTER TABLE `bans`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `coordinates`
--
ALTER TABLE `coordinates`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`job_id`);

--
-- Index pour la table `licences`
--
ALTER TABLE `licences`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `personalvehicle`
--
ALTER TABLE `personalvehicle`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `police`
--
ALTER TABLE `police`
  ADD PRIMARY KEY (`identifier`);

--
-- Index pour la table `police_outfits`
--
ALTER TABLE `police_outfits`
  ADD KEY `identifier` (`identifier`);

--
-- Index pour la table `president`
--
ALTER TABLE `president`
  ADD PRIMARY KEY (`identifier`);

--
-- Index pour la table `recolt`
--
ALTER TABLE `recolt`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `raw_id` (`raw_id`),
  ADD KEY `treated_id` (`treated_id`),
  ADD KEY `job_id` (`job_id`),
  ADD KEY `field_id` (`field_id`),
  ADD KEY `treatment_id` (`treatment_id`),
  ADD KEY `seller_id` (`seller_id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`identifier`);

--
-- Index pour la table `user_clothes`
--
ALTER TABLE `user_clothes`
  ADD PRIMARY KEY (`identifier`);

--
-- Index pour la table `user_inventory`
--
ALTER TABLE `user_inventory`
  ADD PRIMARY KEY (`user_id`,`item_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Index pour la table `user_licence`
--
ALTER TABLE `user_licence`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user_vehicle`
--
ALTER TABLE `user_vehicle`
  ADD PRIMARY KEY (`ID`);

--
-- Index pour la table `user_weapons`
--
ALTER TABLE `user_weapons`
  ADD PRIMARY KEY (`ID`);

--
-- Index pour la table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `bans`
--
ALTER TABLE `bans`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `coordinates`
--
ALTER TABLE `coordinates`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT pour la table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT pour la table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `job_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT pour la table `licences`
--
ALTER TABLE `licences`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pour la table `personalvehicle`
--
ALTER TABLE `personalvehicle`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `recolt`
--
ALTER TABLE `recolt`
  MODIFY `ID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT pour la table `user_licence`
--
ALTER TABLE `user_licence`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pour la table `user_vehicle`
--
ALTER TABLE `user_vehicle`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT pour la table `user_weapons`
--
ALTER TABLE `user_weapons`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=164;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `user_inventory`
--
ALTER TABLE `user_inventory`
  ADD CONSTRAINT `user_inventory_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
