
CREATE TABLE `diakok` (
  `id` int NOT NULL,
  `vezeteknev` varchar(50) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `keresztnev` varchar(50) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `nem` tinyint(1) NOT NULL,
  `osztaly` varchar(10) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `szulido` date NOT NULL,
  `kor` tinyint UNSIGNED NOT NULL,
  `email` varchar(120) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `magassag_cm` smallint UNSIGNED NOT NULL,
  `atlag` float NOT NULL,
  `irsz` int NOT NULL,
  `lakcim` varchar(100) COLLATE utf8mb4_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;



INSERT INTO `diakok` (`id`, `vezeteknev`, `keresztnev`, `nem`, `osztaly`, `szulido`, `kor`, `email`, `magassag_cm`, `atlag`, `irsz`, `lakcim`) VALUES
(1, 'Kiss', 'Anna', 1, '9.A', '2010-06-15', 15, 'kiss.anna@gmail.com', 162, 4.2, 1031, 'Budapest, Vízi utca 5.'),
(2, 'Szabó', 'Bence', 0, '9.A', '2010-01-08', 16, 'szabo.bence@freemail.hu', 170, 3.8, 4024, 'Debrecen, Piac utca 12.'),
(3, 'Varga', 'Dóra', 1, '9.C', '2009-09-30', 16, 'varga.dora@icloud.com', 158, 4.9, 6720, 'Szeged, Tisza Lajos krt. 3.'),
(4, 'Tóth', 'Máté', 0, '9.C', '2009-03-21', 16, 'toth.mate@gmail.hu', 175, 3.2, 3525, 'Miskolc, Városház tér 1.'),
(5, 'Nagy', 'Lili', 1, '9.B', '2010-11-02', 15, NULL, 160, 4.5, 7621, 'Pécs, Király utca 8.'),
(6, 'Kovács', 'Levente', 0, '9.B', '2010-05-27', 15, 'kovacs.levente@gmail.com', 168, 3.4, 9022, 'Győr, Baross út 15.'),
(7, 'Horváth', 'Réka', 1, '11.A', '2008-12-12', 17, 'horvath.reka@yahoo.com', 164, 4.1, 8000, 'Székesfehérvár, Fő utca 2.'),
(8, 'Balogh', 'Ádám', 0, '11.A', '2008-08-09', 17, 'balogh.adam@freemail.hu', 178, 2.7, 4400, 'Nyíregyháza, Kossuth tér 5.'),
(9, 'Balogh', 'Ádám', 0, '11.A', '2008-03-15', 17, 'balogha@gmail.hu', 182, 4.8, 1192, 'Budapest, Pannónia út 6.'),
(10, 'Farkas', 'Zsófi', 1, '10.B', '2009-01-14', 15, 'farkas.zsofi@gmail.com', 161, 4.8, 6000, 'Kecskemét, Rákóczi út 10.'),
(11, 'Papp', 'Noel', 0, '10.B', '2009-07-05', 16, 'papp.noel@outlook.com', 172, 3.9, 5000, 'Szolnok, Kossuth út 3.'),
(12, 'Lakatos', 'Kinga', 1, '10.A', '2010-02-25', 15, 'lakatos.kinga@gmail.hu', 159, 4.3, 2030, 'Érd, Budai út 45.'),
(13, 'Horváth', 'Gergő', 0, '10.A', '2010-09-18', 15, 'molnar.gergo@freemail.hu', 166, 3.1, 2800, 'Tatabánya, Fő tér 12.'),
(14, 'Nagy', 'Emese', 1, '11.B', '2008-04-28', 17, 'szalai.emese@gmail.com', 165, 4.6, 9700, 'Szombathely, Rohonci út 4.'),
(15, 'Kelemen', 'Dániel', 0, '11.B', '2008-10-03', 17, NULL, 180, 3.6, 8200, 'Veszprém, Egyetem utca 10.'),
(16, 'Oláh', 'Petra', 1, '12.A', '2007-06-01', 18, 'olah.petra@gmail.com', 167, 4.9, 7400, 'Kaposvár, Ady Endre utca 7.'),
(17, 'Mészáros', 'Bálint', 0, '12.A', '2007-02-17', 19, 'meszaros.balint@yahoo.com', 182, 3.4, 4032, 'Debrecen, Egyetem tér 1.'),
(18, 'Bíró', 'Vivien', 1, '12.B', '2007-09-09', 18, 'biro.vivien@icloud.com', 163, 4.2, 1117, 'Budapest, Október 23. utca 8.'),
(19, 'Takács', 'Tamás', 0, '12.B', '2007-12-20', 18, 'takacs.tamas@gmail.hu', 176, 2.8, 6724, 'Szeged, Londoni krt. 12.'),
(20, 'Nagy', 'Nóra', 1, '10.C', '2009-11-11', 16, 'sipos.nora@freemail.hu', 160, 4.7, 3530, 'Miskolc, Szemere utca 4.'),
(21, 'Simon', 'Zalán', 0, '10.C', '2009-05-16', 16, 'simon.zalan@gmail.com', 174, 3.5, 1042, 'Budapest, Árpád út 20.');



CREATE TABLE `diak_tantargy` (
  `diak_id` int NOT NULL,
  `tantargy_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;



INSERT INTO `diak_tantargy` (`diak_id`, `tantargy_id`) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 2),
(3, 1),
(3, 2),
(4, 1),
(4, 2),
(5, 1),
(5, 2),
(6, 1),
(6, 2),
(7, 1),
(7, 2),
(8, 1),
(8, 2),
(9, 1),
(9, 2),
(10, 1),
(10, 2),
(11, 1),
(11, 2),
(12, 1),
(12, 2),
(13, 1),
(13, 2),
(14, 1),
(14, 2),
(15, 1),
(15, 2),
(16, 1),
(16, 2),
(17, 1),
(17, 2),
(18, 1),
(18, 2),
(19, 1),
(19, 2),
(20, 1),
(20, 2),
(21, 1),
(21, 2);


CREATE TABLE `jegyek` (
  `id` int NOT NULL,
  `diak_id` int NOT NULL,
  `tanar_id` int NOT NULL,
  `tantargy_id` int NOT NULL,
  `ertek` tinyint UNSIGNED NOT NULL,
  `suly` float NOT NULL,
  `rogzitve` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;



INSERT INTO `jegyek` (`id`, `diak_id`, `tanar_id`, `tantargy_id`, `ertek`, `suly`, `rogzitve`) VALUES
(1, 1, 5, 2, 3, 0.5, '2026-02-03 02:11:04'),
(2, 2, 4, 6, 1, 1, '2025-11-17 02:02:49'),
(3, 3, 3, 6, 3, 0.5, '2025-12-02 04:06:35'),
(4, 4, 6, 2, 5, 0.5, '2025-12-07 13:22:19'),
(5, 5, 4, 1, 5, 1, '2025-09-12 18:18:08'),
(6, 6, 4, 2, 5, 1, '2026-02-20 12:11:15'),
(7, 7, 4, 4, 3, 0.5, '2025-12-23 05:26:06'),
(8, 8, 5, 1, 2, 0.5, '2026-01-20 12:48:55'),
(9, 9, 2, 1, 1, 2, '2025-09-23 15:36:07'),
(10, 10, 3, 1, 2, 0.5, '2025-11-15 02:07:27'),
(11, 11, 7, 1, 4, 2, '2026-01-01 13:14:26'),
(12, 12, 1, 1, 3, 2, '2025-10-25 15:08:52'),
(13, 13, 5, 6, 5, 0.5, '2025-12-15 16:59:09'),
(14, 14, 4, 2, 3, 1, '2025-09-11 15:41:36'),
(15, 15, 3, 6, 2, 2, '2025-11-14 18:35:17'),
(16, 16, 5, 4, 2, 0.5, '2025-11-27 19:22:59'),
(17, 17, 6, 1, 1, 1, '2026-01-17 02:48:25'),
(18, 18, 1, 2, 3, 1, '2026-01-12 15:34:47'),
(19, 19, 1, 2, 3, 1, '2025-10-24 20:35:41'),
(20, 20, 1, 6, 4, 1, '2026-02-01 00:55:34'),
(21, 21, 5, 2, 5, 1, '2025-11-10 13:29:58'),
(22, 1, 7, 6, 1, 1, '2025-11-19 17:33:31'),
(23, 2, 3, 4, 2, 0.5, '2025-10-01 06:44:04'),
(24, 3, 7, 2, 1, 0.5, '2026-02-04 22:49:55'),
(25, 4, 6, 1, 1, 0.5, '2026-01-17 19:44:19'),
(26, 5, 2, 4, 4, 2, '2025-10-29 02:25:55'),
(27, 6, 1, 1, 1, 1, '2025-10-07 16:06:09'),
(28, 7, 7, 1, 5, 1, '2026-02-14 15:26:51'),
(29, 8, 7, 4, 1, 1, '2025-12-24 05:22:12'),
(30, 9, 4, 6, 5, 1, '2025-11-29 12:52:57'),
(31, 10, 4, 1, 2, 1, '2026-01-28 06:45:08');



CREATE TABLE `osztalyok` (
  `id` int NOT NULL,
  `nev` varchar(10) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `terem` varchar(20) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `osztalyfonok` varchar(100) COLLATE utf8mb4_hungarian_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;



INSERT INTO `osztalyok` (`id`, `nev`, `terem`, `osztalyfonok`) VALUES
(1, '9.A', '101. terem', 'Kovácsné Erzsébet'),
(2, '9.B', '102. terem', 'Varga László'),
(3, '9.C', '103. terem', 'Nagy Gábor'),
(4, '10.A', '201. terem', 'Szabó István'),
(5, '10.B', '202. terem', 'Tóth Erika'),
(6, '10.C', '203. terem', 'Papp Ferenc'),
(7, '11.A', '301. terem', 'Molnár Judit'),
(8, '11.B', '302. terem', 'Bíró Attila'),
(9, '12.A', '401. terem', 'Farkas Pál'),
(10, '12.B', '402. terem', 'Simon Klára');



CREATE TABLE `tanarok` (
  `id` int NOT NULL,
  `vezeteknev` varchar(50) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `keresztnev` varchar(50) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `szuletett` date NOT NULL,
  `kor` tinyint UNSIGNED NOT NULL,
  `nem` tinyint(1) NOT NULL,
  `szak` varchar(20) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `hobbi` varchar(12) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `tanora` tinyint NOT NULL,
  `szakkor` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;



INSERT INTO `tanarok` (`id`, `vezeteknev`, `keresztnev`, `szuletett`, `kor`, `nem`, `szak`, `hobbi`, `tanora`, `szakkor`) VALUES
(1, 'Nagy', 'Péter', '1982-04-12', 43, 1, 'Matematika/Fizika', 'Futás', 24, 1),
(2, 'Kovács', 'Anna', '1986-11-03', 40, 0, 'Angol/Biológia', 'fotózás', 22, 2),
(3, 'Tóth', 'Gábor', '1996-02-20', 30, 1, 'Testnevelés/Biológia', NULL, 12, 0),
(4, 'Szabó', 'Eszter', '1988-07-01', 37, 0, 'Digitális kultúra', 'kertészkedés', 14, 2),
(5, 'Tóth', 'Miklós', '1979-09-18', 46, 1, NULL, NULL, 22, 2),
(6, 'Nagy', 'Anna', '1992-12-05', 33, 0, 'Etika/Hittan', 'fotózás', 12, 0),
(7, 'Karácsony', 'Mária', '1980-12-05', 45, 0, 'Matematika/Kémia', 'terepfutás', 20, 1);



CREATE TABLE `tantargyak` (
  `id` int NOT NULL,
  `nev` varchar(50) COLLATE utf8mb4_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;


INSERT INTO `tantargyak` (`id`, `nev`) VALUES
(1, 'Matematika'),
(2, 'Magyar nyelv és irodalom'),
(3, 'Történelem'),
(4, 'Fizika'),
(5, 'Informatika'),
(6, 'Angol nyelv');


ALTER TABLE `diakok`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);


ALTER TABLE `diak_tantargy`
  ADD PRIMARY KEY (`diak_id`,`tantargy_id`);


ALTER TABLE `jegyek`
  ADD PRIMARY KEY (`id`);


ALTER TABLE `osztalyok`
  ADD PRIMARY KEY (`id`);


ALTER TABLE `tanarok`
  ADD PRIMARY KEY (`id`);


ALTER TABLE `tantargyak`
  ADD PRIMARY KEY (`id`);


ALTER TABLE `diakok`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;


ALTER TABLE `jegyek`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;


ALTER TABLE `osztalyok`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;


ALTER TABLE `tanarok`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;


ALTER TABLE `tantargyak`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
