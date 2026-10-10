-- 1. feladat
ALTER TABLE `tanarok`
    MODIFY COLUMN `hobbi` VARCHAR(50) DEFAULT NULL;

-- 2. feladat
ALTER TABLE `tanarok` DROP COLUMN `kor`;
ALTER TABLE `diakok` DROP COLUMN `kor`;

-- 3. feladat
ALTER TABLE `diakok` CHANGE COLUMN `szulido` `szuletett` DATE NOT NULL;


-- 4. feladat
ALTER TABLE `osztalyok`
  RENAME COLUMN `terem` TO `tanterem`,
  DROP COLUMN `osztalyfonok`,
  ADD COLUMN `osztalyfonok_id` INT DEFAULT NULL;


-- 5. feladat
INSERT INTO `tanarok` (`vezeteknev`, `keresztnev`, `szuletett`, `nem`, `szak`, `hobbi`, `tanora`, `szakkor`) VALUES
('Kovácsné', 'Erzsébet', '1978-03-15', 0, 'Magyar',              'Kertészkedés', 18, 2),
('Varga',    'László',   '1975-11-22', 1, 'Történelem',          'Tenisz',       20, 1),
('Nagy',     'Gábor',    '1982-06-08', 1, 'Matematika',          'Futás',        24, 1),
('Szabó',    'István',   '1970-09-30', 1, 'Fizika',              'Olvasás',      16, 2),
('Tóth',     'Erika',    '1985-12-01', 0, 'Angol',               'Könyv',        18, 3),
('Papp',     'Ferenc',   '1968-04-17', 1, 'Biológia',            'Vadászat',     22, 0),
('Molnár',   'Judit',    '1990-07-23', 0, 'Testnevelés',         'Sportolás',    14, 1),
('Bíró',     'Attila',   '1988-02-14', 1, 'Informatika',         'Horgászat',    20, 2),
('Farkas',   'Pál',      '1973-10-05', 1, 'Történelem/Ökon.',    'Kötés',        18, 1),
('Simon',    'Klára',    '1992-08-19', 0, 'Informatika',         'Utazás',       16, 2);


-- 6. feladat
ALTER TABLE `osztalyok`
  ADD CONSTRAINT `fk_osztalyok_tanar` 
    FOREIGN KEY (`osztalyfonok_id`) REFERENCES `tanarok`(`id`) ON DELETE RESTRICT;

-- 7. feladat
-- Segítség

UPDATE `osztalyok` SET `osztalyfonok_id` = 8 WHERE `nev` = '9.A';
UPDATE `osztalyok` SET `osztalyfonok_id` = 9 WHERE `nev` = '9.B';
UPDATE `osztalyok` SET `osztalyfonok_id` = 10 WHERE `nev` = '9.C';
UPDATE `osztalyok` SET `osztalyfonok_id` = 11 WHERE `nev` = '10.A';
UPDATE `osztalyok` SET `osztalyfonok_id` = 12 WHERE `nev` = '10.B';
UPDATE `osztalyok` SET `osztalyfonok_id` = 13 WHERE `nev` = '10.C';
UPDATE `osztalyok` SET `osztalyfonok_id` = 14 WHERE `nev` = '11.A';
UPDATE `osztalyok` SET `osztalyfonok_id` = 15 WHERE `nev` = '11.B';
UPDATE `osztalyok` SET `osztalyfonok_id` = 16 WHERE `nev` = '12.A';
UPDATE `osztalyok` SET `osztalyfonok_id` = 17 WHERE `nev` = '12.B';



-- 8. feladat
ALTER TABLE `tanarok` ADD COLUMN `vezeto` INT DEFAULT NULL;

-- 9. feladat
ALTER TABLE `tanarok`
  ADD CONSTRAINT `fk_tanarok_vezeto` 
    FOREIGN KEY (`vezeto`) REFERENCES `tanarok`(`id`) ON DELETE RESTRICT;


-- 10. feladat
UPDATE `tanarok` SET `vezeto` = 1 WHERE `id` <> 1;

-- 11. feladat
ALTER TABLE `tanarok` ADD CONSTRAINT `chk_tanar_nem` CHECK (`nem` IN (0, 1));
ALTER TABLE `diakok`  ADD CONSTRAINT `chk_diak_nem`  CHECK (`nem` IN (0, 1));

-- 12. feladat
UPDATE `tanarok` SET `nem` = 3 WHERE `id` = 1;

-- 13. feladat
CREATE TABLE `jegyek` (
  `id`          INT AUTO_INCREMENT PRIMARY KEY,
  `diak_id`     INT NOT NULL,
  `tanar_id`    INT NOT NULL,
  `tantargy_id` INT NOT NULL,
  `ertek`       TINYINT NOT NULL CHECK (`ertek` BETWEEN 1 AND 5),
  `suly`        FLOAT NOT NULL,
  `rogzitve`    DATETIME DEFAULT CURRENT_TIMESTAMP,
  
  CONSTRAINT `fk_jegyek_diak`  FOREIGN KEY (`diak_id`)   REFERENCES `diakok`(`id`),
  CONSTRAINT `fk_jegyek_tanar` FOREIGN KEY (`tanar_id`)   REFERENCES `tanarok`(`id`),
  CONSTRAINT `fk_jegyek_tantargy` FOREIGN KEY (`tantargy_id`) REFERENCES `tantargyak`(`id`)
);

-- 14. feladat
INSERT INTO `jegyek` (`diak_id`, `tanar_id`, `tantargy_id`, `ertek`, `suly`, `rogzitve`) VALUES
(1, 5, 2, 3, 0.5, '2026-02-03 02:11:04'),
(2, 4, 6, 1, 1.0, '2025-11-17 02:02:49'),
(3, 3, 6, 3, 0.5, '2025-12-02 04:06:35'),
(4, 6, 2, 5, 0.5, '2025-12-07 13:22:19'),
(5, 4, 1, 5, 1.0, '2025-09-12 18:18:08'),
(6, 4, 2, 5, 1.0, '2026-02-20 12:11:15'),
(7, 4, 4, 3, 0.5, '2025-12-23 05:26:06'),
(8, 5, 1, 2, 0.5, '2026-01-20 12:48:55'),
(9, 2, 1, 1, 2.0, '2025-09-23 15:36:07'),
(10, 3, 1, 2, 0.5, '2025-11-15 02:07:27'),
(11, 7, 1, 4, 2.0, '2026-01-01 13:14:26'),
(12, 1, 1, 3, 2.0, '2025-10-25 15:08:52'),
(13, 5, 6, 5, 0.5, '2025-12-15 16:59:09'),
(14, 4, 2, 3, 1.0, '2025-09-11 15:41:36'),
(15, 3, 6, 2, 2.0, '2025-11-14 18:35:17'),
(16, 5, 4, 2, 0.5, '2025-11-27 19:22:59'),
(17, 6, 1, 1, 1.0, '2026-01-17 02:48:25'),
(18, 1, 2, 3, 1.0, '2026-01-12 15:34:47'),
(19, 1, 2, 3, 1.0, '2025-10-24 20:35:41'),
(20, 1, 6, 4, 1.0, '2026-02-01 00:55:34'),
(21, 5, 2, 5, 1.0, '2025-11-10 13:29:58'),
(1, 7, 6, 1, 1.0, '2025-11-19 17:33:31'),
(2, 3, 4, 2, 0.5, '2025-10-01 06:44:04'),
(3, 7, 2, 1, 0.5, '2026-02-04 22:49:55'),
(4, 6, 1, 1, 0.5, '2026-01-17 19:44:19'),
(5, 2, 4, 4, 2.0, '2025-10-29 02:25:55'),
(6, 1, 1, 1, 1.0, '2025-10-07 16:06:09'),
(7, 7, 1, 5, 1.0, '2026-02-14 15:26:51'),
(8, 7, 4, 1, 1.0, '2025-12-24 05:22:12'),
(9, 4, 6, 5, 1.0, '2025-11-29 12:52:57'),
(10, 4, 1, 2, 1.0, '2026-01-28 06:45:08');
