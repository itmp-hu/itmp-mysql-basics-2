-- 1. feladat
SELECT d.vezeteknev, d.keresztnev, d.szuletett, o.nev AS 'osztály'
FROM diakok d
JOIN osztalyok o ON d.osztaly_id = o.id;


-- 2. feladat
SELECT d.vezeteknev, d.keresztnev, d.szuletett, o.nev AS 'osztály',
       CONCAT(ofo.vezeteknev, ' ', ofo.keresztnev) AS `OF`
FROM diakok d
JOIN osztalyok o ON d.osztaly_id = o.id
LEFT JOIN tanarok ofo ON o.osztalyfonok_id = ofo.id;



-- 3. feladat
SELECT d.vezeteknev, d.keresztnev, d.szuletett, j.ertek, j.suly, t.nev AS 'tantárgy'
FROM diakok d
LEFT JOIN jegyek j ON d.id = j.diak_id
LEFT JOIN tantargyak t ON j.tantargy_id = t.id;


-- 4.feladat
SELECT CONCAT(t.vezeteknev, ' ', t.keresztnev) AS 'tanár',
       CONCAT(v.vezeteknev, ' ', v.keresztnev) AS 'vezető'
FROM tanarok t
LEFT JOIN tanarok v ON t.vezeto = v.id;


-- 5. feladat A
SELECT CONCAT(t.vezeteknev, ' ', t.keresztnev) AS 'tanár'
FROM tanarok t
LEFT JOIN jegyek j ON t.id = j.tanar_id
WHERE j.id IS NULL;

-- 5. feladat B
SELECT CONCAT(vezeteknev, ' ', keresztnev) AS 'tanár'
FROM tanarok
WHERE id NOT IN (SELECT DISTINCT tanar_id FROM jegyek);


-- 6. feladat A
SELECT d.vezeteknev, d.keresztnev, d.magassag_cm
FROM diakok d
WHERE d.magassag_cm > (
    SELECT AVG(d2.magassag_cm)
    FROM diakok d2
    WHERE d2.osztaly_id = d.osztaly_id
);


-- 6. feladat B
SELECT d.vezeteknev, d.keresztnev, d.magassag_cm
FROM diakok d
JOIN (
    SELECT osztaly_id, AVG(magassag_cm) AS atlag
    FROM diakok
    GROUP BY osztaly_id
) avg_mag ON d.osztaly_id = avg_mag.osztaly_id
WHERE d.magassag_cm > avg_mag.atlag;


-- 7. feladat
SELECT d.vezeteknev, d.keresztnev
FROM diakok d
JOIN diakok c ON d.osztaly_id = c.osztaly_id
WHERE c.vezeteknev = 'Mészáros' AND c.keresztnev = 'Bálint'
  AND d.id != c.id;

-- 8. feladat
SELECT d.vezeteknev, d.keresztnev
FROM diakok d
WHERE EXISTS (SELECT 1 FROM jegyek j WHERE j.diak_id = d.id)
  AND NOT EXISTS (SELECT 1 FROM jegyek j WHERE j.diak_id = d.id AND j.ertek < 5);


-- 9. feladat

INSERT INTO jegyek (diak_id, tanar_id, tantargy_id, ertek, suly)
VALUES (
    (SELECT id FROM diakok WHERE email = 'balogh.adam@freemail.hu'),
    (SELECT j.tanar_id 
     FROM jegyek j
     JOIN tantargyak t ON j.tantargy_id = t.id
     WHERE t.nev = 'Matematika'
     ORDER BY j.rogzitve DESC 
     LIMIT 1),
    (SELECT id FROM tantargyak WHERE nev = 'Matematika'),
    5, 1.0
);


-- 10. feladat A
SELECT DISTINCT CONCAT(vezeteknev, ' ', keresztnev) AS 'tanár'
FROM tanarok t
JOIN jegyek j ON t.id = j.tanar_id
WHERE j.ertek = 5;


-- 10. feladat B
SELECT CONCAT(vezeteknev, ' ', keresztnev) AS 'tanár'
FROM tanarok t
WHERE EXISTS (
    SELECT 1 FROM jegyek j 
    WHERE j.tanar_id = t.id AND j.ertek = 5
);