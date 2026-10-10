# 2. modul - Módosítás és megszorítások

# Adatbázis módosítása és megszorítások

- Adatbázis módosítása
    - ALTER DATABASE
- Tábla módosítása
    - ALTER: ADD, DROP, CHANGE, MODIFY
- Adatok módosítása
    - UPDATE
- Megszorítások
    - UNIQUE
    - FOREIGN KEY
    - CHECK


## Adatbázis módosítása - ALTER DATABASE

- Amennyiben elfelejtettük beállítani, utólag is módosíthatjuk a karakterkódolást.
- Ezt lehetőleg az adatok beszúrása előtt tegyük meg!

```sql
ALTER DATABASE `database_neve`
 CHARACTER SET utf8
 COLLATE utf8_hungarian_ci;
```

- Karakterkészletek lekérdezése: `SHOW CHARACTER SET`
- Nyelvi beállítások lekérdezése: `SHOW COLLATION`

---

## Táblák módosítása - ALTER TABLE

```sql
ALTER TABLE `tabla_nev`
 modositasok_listaja;
```

A módosítások listája tartalmazhatja:
- mező hozzáadása/törlése
- index hozzáadása/törlése
- kulcs hozzáadása/törlése
- megszorítás hozzáadása/törlése

További olvasnivaló:
- https://dev.mysql.com/doc/refman/9.7/en/alter-table.html
- https://en.wikibooks.org/wiki/Structured_Query_Language/Alter_Table

---

## Új mező hozzáadása - ADD COLUMN

**DOKUMENTÁCIÓ**: 

```sql
ALTER TABLE `tabla_nev`
ADD [COLUMN] `mezo_neve` `tipus_deffinicio` [FIRST | AFTER `masik_mezo_neve`];
```

- A `COLUMN` kulcsszó elhagyható.
- Megadhatjuk, hogy az új mező legyen az első (`FIRST`)
- Vagy állhat egy meghatározott másik mező után (`AFTER`).

---

## Új mező hozzáadása példa

Adja hozzá a leírásnak megfelelő mezőt a `tanarok` táblához!

| Mező      | Típus                | Megkötés                      |
| --------- | -------------------- | ----------------------------- |
| `szulvar` | VARCHAR(50) (Szöveg) | alapértelmezett érték: `NULL` |

```sql
ALTER TABLE `tanarok`
 ADD COLUMN `szulvar` VARCHAR(50) NULL;
```

- Az `ADD COLUMN` egy új mezőt ad hozzá a táblánkhoz

---

## Új mező hozzáadása - több mező egyszerre példa

Adja hozzá a leírásnak megfelelő mezőket az `tanarok` táblához!

| Mező       | Típus   | Megkötés              | Leírás                     |
| ---------- | ------- | --------------------- | -------------------------- |
| `fizetes`  | Egész   | Kötelezően kitöltendő | Fizetés forintban          |
| `gyerekek` | Egész   | Alapértelmezett: `0`  | Gyerekeinek száma          |
| `hazas`    | Logikai | Kötelezően kitöltendő | Házas-e (adókedvezményhez) |

```sql
ALTER TABLE `tanarok`
 ADD COLUMN `fizetes` INT NOT NULL,
 ADD COLUMN `gyerekek` INT DEFAULT '0',
 ADD COLUMN `hazas` BOOLEAN NOT NULL;
```

- Egyszerre több mezőt is hozzáadhatunk

---

## Mező törlése - DROP COLUMN

```sql
ALTER TABLE `tabla_nev`
    DROP [COLUMN] `mezo_neve`;
```

- A `COLUMN` kulcsszó elhagyható.

Példa: Törölje a `tanarok` táblából a `hobbi` mezőt!

```sql
ALTER TABLE `tanarok`
    DROP COLUMN `hobbi`;
```

---

## Mező törlése - több mező egyszerre példa

Törölje az `osztalyok` táblából az `tanora` és `szakkor` mezőket is!

```sql
ALTER TABLE `osztalyok`
    DROP COLUMN `tanora`,
    DROP COLUMN `szakkor`;
```

**MEGJEGYZÉS**:

- MySQL-ben a szabványtól eltérően egyszerre több mezőt is törölhetünk egy `ALTER` utasításban.

---

## Mező módosítása - CHANGE COLUMN

```sql
ALTER TABLE `tabla_nev`
 CHANGE [COLUMN] `regi_nev` `uj_nev` `tipus_deffinicio`;
```

- A `COLUMN` kulcsszó elhagyható.
- Módosíthatjuk egyszerre a mező nevét és típusát is!
- Ha a típusát nem szeretnénk módosítani, akkor ugyanazt kell megadni, mint a jelenlegi típusa.
- Ha a nevét nem szeretnénk módosítani, akkor a `regi_nev` és az `uj_nev` helyére is ugyanazt kell írni, vagy mást (`MODIFY`) használni!

---

## Mező módosítása (CHANGE) példák

1. Módosítsa a `tanarok` táblában a `szak` mező nevét `szakkod`-ra!

```sql
ALTER TABLE `tanarok`
CHANGE COLUMN `szak` `szakkod` VARCHAR(30);
```

2. Módosítsa az `osztalyok` tábla `terem` mezőt úgy, hogy 30 karaktert lehessen eltárolni benne!

```sql
ALTER TABLE `osztalyok`
CHANGE COLUMN `terem` `terem` VARCHAR(30) NULL;
```

3. Tegye kötelezően kitöltendővé az `osztalyok` tábla `nev` mezőjét!

```sql
ALTER TABLE `osztalyok`
CHANGE COLUMN `nev` `nev` VARCHAR(10) NOT NULL;
```

---

## Mező módosítása - MODIFY COLUMN

```sql
ALTER TABLE `tabla_nev`
    MODIFY [COLUMN] `mezo_neve` `tipus_deffinicio`;
```

- A `COLUMN` kulcsszó elhagyható.
- A `MODIFY` **nem** tudja a mező nevét módosítani!

---

## Mező módosítása (MODIFY) példák

1. Módosítsa a `tanarok` tábla `vezeteknev` mezőjét úgy, hogy 100 karaktert lehessen eltárolni benne!

```sql
ALTER TABLE `tanarok`
    MODIFY COLUMN `vezeteknev` VARCHAR(100) NOT NULL;
```

2. Tegye opcionálissá az `osztalyok` tábla `terem` mezőjét!

```sql
ALTER TABLE `osztalyok`
    MODIFY COLUMN `terem` VARCHAR(30) DEFAULT NULL;
```

**TIPP**: Amikor a mező nevét nem szeretnénk módosítani, célszerűbb a MODIFY-t választani!

---

## Összetett módosítások példa

Módosítsa az `osztalyok` táblát az alábbiak szerint:

- Módosítsa a `terem` mezőjét úgy, hogy 30 karaktert lehessen eltárolni benne!
- Törölje a `terem` mezőjét!
- Adjon hozzá egy `megjegyzes` mezőt, amiben hosszabb szöveget fogunk eltárolni!

```sql
ALTER TABLE `osztalyok`
 MODIFY COLUMN `terem` VARCHAR(30) NULL,
 DROP COLUMN `terem`,
 ADD COLUMN `megjegyzes` TEXT DEFAULT NULL;
```

---

## Tábla mezőinek módosítása - összefoglaló

Az `ALTER TABLE` a tábla szerkezetének módosítására használható DDL utasítás.

| Parancs  | Leírás                  |
| -------- | ----------------------- |
| `ADD`    | Új mező hozzáadása      |
| `DROP`   | Mező törlése            |
| `CHANGE` | Név és típus módosítása |
| `MODIFY` | Csak típus módosítása   |

---

## Tábla módosítása - átnevezése

Nevezze át a `tanarok` táblát `oktatok` táblának.

```sql
ALTER TABLE `tanarok` RENAME TO `oktatok`;
```

- Ez az SQL:2003 szabványnak megfelelő és MySQL-ben is működik.

```sql
RENAME TABLE `tanarok` TO `oktatok`;
```

- MySQL egyedi megoldása

---

## Az UPDATE parancs

**DOKUMENTÁCIÓ**:
```sql
UPDATE [LOW_PRIORITY] [IGNORE] `tabla`
SET `mezo1` = `value1`, `mezo2` = `value2`, ...
[WHERE where_condition] [ORDER BY ...] [LIMIT row_count];
```

- `value`: `{expr | DEFAULT}`
- `assignment`: `col_name = value`

**Példa**

```sql
UPDATE `tanarok`
SET `vezeteknev` = 'Kovácsné'
WHERE `id` = 5;
```

---

## UPDATE - egyszerű példák

**Kor frissítése — minden tanárnak:**

```sql
UPDATE `tanarok` SET `kor` = `kor` + 1;
```

**Jegy javítása:**

```sql
UPDATE `jegyek` SET `ertek` = 5;
```

**FIGYELEM**:

- Feltétel nélkül az összes rekordra érvényesülni fog a lekérdezés!
- Jól végig kell gondolni, hogy ez kell-e nekük!

---

## UPDATE - feltételes példa

```sql
UPDATE `tanarok`
SET `vezeteknev` = 'Kovácsné'
WHERE `id` = 5;
```

- A legtöbb esetben szükség lehet feltétel megadására!
- Tetszőleges logikai feltétel megadható

**FIGYELEM**: 
```sql
UPDATE `tanarok` SET `vezeteknev` = 'Kovácsné';
WHERE `id` = 5;
```

- Mindenki Kovácsné lesz - Klasszikus hiba, ha túl korán került lezárásra az utasítás

---

## UPDATE - ID növelése példa

**Az ID értékének növelése:**

```sql
UPDATE `jegyek`
SET `id` = `id` + 1
ORDER BY `id` DESC;
```

A fenti példa csak akkor működik, ha rendezzük az adatokat id szerint fordított sorrendben!

---

## Összetett UPDATE

SELECT lekérdezés írása
Átalakítás UPDATE lekérdezéssé.

- Join vagy alalekérdezés használható.

Példa: Minden matematikát tanuló diák jegyeit javítsuk!

```sql
UPDATE `jegyek`
 SET `ertek` = `ertek` + 1
WHERE `tantargy_id` = (
 SELECT `id`
 FROM `tantargyak`
 WHERE `nev` = 'Matematika'
);
```

---

## Megszorítások - Áttekintés

MySQL CONSTRAINTS (megszorítások):

- `DEFAULT` - Alapértelmezett érték megadása
- `NOT NULL` - Adott mező értékei nem vehetik fel a NULL-t
- `UNIQUE` - Az adott mezőben nem szerepelhet kétszer ugyanaz az érték
- `PRIMARY KEY` - Elsődleges kulcs
- `FOREIGN KEY` - Idegen kulcs
- `CHECK` - Adat egyszerű validálása

**FONTOS**:
A megszorításokat hozzáadhatjuk a táblához már létrehozáskor (CREATE), vagy később is a tábla módosításával (ALTER).
Utóbbi esetén a már beszúrt adatok okozhatnak problémát!

- https://mariadb.com/docs/server/reference/sql-statements/data-definition/constraint

---

## Elsődleges kulcs (PRIMARY KEY) - Tulajdonságai

- Az elsődleges kulcs egyértelműen meghatároz egy rekordot (sort) a táblában.
- Az elsődleges kulcs állhat több mezőből, ekkor összetett kulcsról beszélünk.
- Egy táblának csak egy elsődleges kulcsa lehet!
- Kitöltése kötelező! Atomatikusan `NOT NULL` lesz.
- Nem ismétlődhet! Automatikusan `UNIQUE` lesz.
- Az `AUTO_INCREMENT` hozzáadásával automatikusan növekvő mezőt hoz létre.

```sql
CREATE TABLE `pelda` (
 `id` INT NOT NULL PRIMARY KEY
);
```

```sql
CREATE TABLE `tanarok` (
 `id` INT AUTO_INCREMENT PRIMARY KEY,
 `vezeteknev` VARCHAR(50) NOT NULL,
 ...
);
```

---

## Elsődleges kulcs meghatározásának módjai

```sql
CREATE TABLE `pelda` (
 `id` INT NOT NULL PRIMARY KEY
);
```

```sql
CREATE TABLE `pelda` (
 `id` INT NOT NULL,
 PRIMARY KEY (`id`)
);
```

- Meghatározható a mező definiálásakor
- Bizonyos esetekben külön kell meghatározni a mezők után

---

## Összetett elsődleges kulcs

Az elsődleges kulcs állhat több mezőből, ekkor összetett kulcsról beszélünk.

**HIBA #1068**:
```sql
CREATE TABLE `pelda` (
        `nev` VARCHAR(20) NOT NULL PRIMARY KEY,
        `kor` INT(11) NOT NULL PRIMARY KEY,
        `cim` VARCHAR(20)
);
```

- Többszörös elsődleges kulcs definiálás
- Azt hiszi, hogy két mezőt is szeretnénk elsődlegesnek megtenni

**HELYES PÉLDA**:

```sql
CREATE TABLE `pelda` (
    `nev` VARCHAR(20) NOT NULL,
    `kor` INT(11) NOT NULL,
    `cim` VARCHAR(20), PRIMARY KEY (`nev`, `kor`)
    );
```

- Egyetlen, **összetett kulcs**

---

## Hivatkozási integritás és idegen kulcs

- A normalizálás során az adatok több táblába kerülhetnek.
- **Hivatkozási integritás**: Az egyi táblából csak létező rekodra hivatkozhatunk
- A hivatkozási integritást az idegen kulcsok biztosítják!
- A megszorítás következményei:
 - Új rekord hozzáadása egy kapcsolt táblához csak akkor lehetséges, ha az elsődleges táblában már létezik egy ugyanolyan rekord.
 - Az elsődleges tábla elsődleges kulcsának értékét nem módosíthatjuk, amíg a kapcsolt táblában tartoznak hozzá adatok

---

## Idegen kulcs definíciója

**DOKUMENTÁCIÓ**: 
```sql
[CONSTRAINT [symbol]] FOREIGN KEY (col_name, ...)
REFERENCES tbl_name (col_name,...)
[ON DELETE reference_option] [ON UPDATE reference_option];
```

| Opció                    | Leírás                                                                                                                        |
| ------------------------ | ----------------------------------------------------------------------------------------------------------------------------- |
| `RESTRICT` / `NO ACTION` | Nem engedi a törlést/módosítást (alapértelmezett viselkedés)                                                                  |
| `CASCADE`                | A szülő táblában történő törlést/módosítást végrehajtja a gyerek táblán is                                                    |
| `SET NULL`               | A szülő táblában történő törlés/módosítás esetén a gyerek táblában NULL-ra állítja az értéket. Nem lehet `NOT NULL` az érték! |
| `SET DEFAULT`            | Alapértelmezettre állítja, az InnoDB és az NDB figyelmen kívül hagyja                                                         |

- https://dev.mysql.com/doc/refman/8.0/en/create-table-foreign-keys.html

---

## Idegen kulcs példa

Az `osztalyok` tábla:

```sql
CREATE TABLE `osztalyok` (
 `id` INT AUTO_INCREMENT PRIMARY KEY,
 `nev` VARCHAR(10) NOT NULL,
 ...
);
```

A `diakok` tábla idegen kulccsal:

```sql
CREATE TABLE `diakok` (
 ...
 `osztaly_id` INT NOT NULL,
 FOREIGN KEY (`osztaly_id`) REFERENCES `osztalyok`(`id`)
);
```

- Ahhoz, hogy új diákot adhassunk hozzá, az `osztaly_id`-nak létező osztályra kell hivatkoznia!
- A mezők típusának meg kell egyezni!

---

## Idegen kulcs példa - CASCADE

`ALTER TABLE` használata:

```sql
ALTER TABLE `jegyek`
 ADD CONSTRAINT `fk_jegyek_diak_id`
 FOREIGN KEY (`diak_id`)
 REFERENCES `diakok`(`id`)
 ON DELETE CASCADE
 ON UPDATE CASCADE;
```

 - A diák törlésekor a jegyei is törlésre kerülnek
 - Kérdés, hogy tanulmányi rendszerben ez a viselkedés megengedhető -e?

---

## Idegen kulcs példa - Önmagára mutató (SELF JOIN)

Önmagára mutató idegen kulcs - egy dolgozó főnöke is egy dolgozó:

```sql
ALTER TABLE `felhasznalo`
 ADD COLUMN `fonok_id` INT,
 ADD CONSTRAINT `fk_felhasznalo_fonok_id`
 FOREIGN KEY (`fonok_id`)
 REFERENCES `felhasznalo`(`id`)
 ON DELETE RESTRICT
 ON UPDATE RESTRICT;
```

A főnök törlését nem engedjük, amíg van hozzá tartozó beosztott dolgozó.

---

## Idegen kulcs törlése

MySQL:

```sql
ALTER TABLE `felhasznalo`
 DROP FOREIGN KEY `fk_fonok_id`;
```

MS SQL / Oracle:

```sql
ALTER TABLE felhasznalo
 DROP CONSTRAINT fk_fonok_id;
```

---

## Idegen kulcs hibák

**HIBA #1451**: Cannot delete or update a parent row: a foreign key constraint fails.

- A megadott sor(ok) nem törölhető(ek) idegen kulcs miatt

**HIBA #1217**: Cannot delete or update a parent row: a foreign key constraint fails

- A tábla nem törölhető idegen kulcs miatt

Megoldás:

```sql
SET foreign_key_checks = 0;
-- műveletek elvégzése
SET foreign_key_checks = 1;
```

- Ideiglenesen szükséges lehet az idegenkulcsok ellenőrzésének a kikapcsolása
- Utána állítsuk vissza! Ha megsérti valami a szabályokat, akkor nem lehet visszakapcsolni!

---

## Példa idegen kulcsra - jegyek

```sql
CREATE TABLE `jegyek` (
 `id` INT AUTO_INCREMENT PRIMARY KEY,
 `diak_id` INT NOT NULL,
 `tanar_id` INT NOT NULL,
 `tantargy_id` INT NOT NULL,
 ...
 FOREIGN KEY (`diak_id`)
 REFERENCES `diakok`(`id`)
 ON DELETE CASCADE
 ON UPDATE CASCADE,
 FOREIGN KEY (`tanar_id`)
 REFERENCES `tanarok`(`id`)
 ON DELETE CASCADE
 ON UPDATE NO ACTION,
 FOREIGN KEY (`tantargy_id`)
 REFERENCES `tantargyak`(`id`)
 ON DELETE CASCADE
 ON UPDATE NO ACTION,
);
```

- Csak olyan diáknak írható be jegy, aki már létezik.
 - Az azonosító módosításakor ebben a táblában is frissül.
 - A diák törlésekor törlésre kerül az összes jegye.
- Csak olyan tanár nevében írahtó be jegy, aki létezik.
- Csak olyan tantárgyhoz lehet jegyet beírni, ami létezik.

---

## Egyedi mező (UNIQUE)

```sql
ALTER TABLE `pelda`
 ADD UNIQUE (`email`);
```

```sql
CREATE TABLE `diakok` (
 ...
 `email` VARCHAR(120) DEFAULT NULL UNIQUE,
 ...
);
```

- Az adott oszlopban ugyanaz az érték kétszer nem szerepelhet!
- A megszorítás hozzáadható létrehozáskor, és utólóag is.
- Ha a tábla már tartalmaz ismétlődést, akkor nem adható hozzá, előtte javítani kell
- Egy táblában több `UNIQUE` is lehet

```sql
ALTER TABLE `szemelyek`
 ADD UNIQUE (`keresztnev`, `vezeteknev`, `szuletesi_datum`);
```

- Több mező megadása: csak akkor számít azonosnak két sor, ha mindegyik felsorolt mező megegyezik.

---

## UNIQUE példák

Az email mező UNIQUE megszorításával:

```sql
CREATE TABLE `diakok` (
 ...
 `email` VARCHAR(120) DEFAULT NULL UNIQUE,
 ...
);
```

- Ez azt jelenti, hogy két diák sem használhatja ugyanazt az email címet. NULL még lehetséges

```sql
CREATE TABLE `diak_tantargy` (
 `diak_id` INT NOT NULL,
 `tantargy_id` INT NOT NULL,
 PRIMARY KEY (`diak_id`, `tantargy_id`),
 ...
);
```

- Az összetett elsődleges kulcs automatikusan biztosítja az egyediséget: ugyanaz a diák nem tanulhatja ugyanazt a tantárgyat kétszer!

---

## CHECK megszorítás

A `CHECK` megszorítással egyszerű validáció határozható meg egy mező értékére.

```sql
ALTER TABLE `demo`
 ADD CONSTRAINT chk_szabaly
 CHECK (`mezo_neve` > 0);
```

- MySQL 8.0.16-tól, MariaDB 10.2-től kikényszeríti a feltételeket
- Csak ha a feltétel `false`, akkor utasítja vissza a műveletet
- Ha `true`, vagy `NULL`, akkor nem
- Allekérdezés, JOIN nem használható, csak egyszerű feltétel
- https://dev.mysql.com/blog-archive/mysql-8-0-16-introducing-check-constraint

---

## Példa: átlag tartomány

A `diakok` táblában az átlagnak 1 és 5 között kell lennie:

```sql
ALTER TABLE `diakok`
 ADD CONSTRAINT chk_atlag CHECK (`atlag` >= 1 AND `atlag` 

vagy

```sql
ALTER TABLE `diakok`
 ADD CONSTRAINT chk_atlag CHECK (`atlag` BETWEEN 1 AND 5);
```

**ERROR: CHECK CONSTRAINT FAILED**:
```sql
INSERT INTO `diakok` (..., `atlag`, ...)
VALUES ('Új', 'Diák', 0, '2010-01-01', 14, NULL, 155, 6.1, 1000, 'Budapest, Minta utca 1.');
```

- Az átlag túl nagy, így nem engedi meg a beszúrást

---

## Példa: Az e-mail cím tartalmazzon kukacot

A `diakok` tábla `email` mezőjének tartalmaznia kell a "@" jelet:

```sql
ALTER TABLE `diakok`
 ADD CONSTRAINT chk_email CHECK (`email` IS NULL OR LOCATE('@', `email`) > 0);
```

**EREDMÉNY**:
```sql
INSERT INTO `diakok` (..., `email`, ...)
VALUES ('Új', 'Valaki', ...); 
```

- Hibát nem okoz, mert NULL megengedett

**CHECK HIBA**:

```sql
UPDATE `diakok`
SET `email` = 'nolmail.com'
WHERE `id` = 1;
```

- Ha ki van töltve, akkor tartalmaznia kell a @-ot.

---

## Példa: Ellenőrzés után lekérdezése

A már létező CHECK megszorítások listázása:

```sql
SHOW CREATE TABLE `tanarok`;
```

A kimenetben megtalálod az összes CONSTRAINT sort. Ha több táblához tartozó CHECK-eket szeretnéd nézni:

```sql
SELECT 
 TABLE_NAME,
 CONSTRAINT_NAME,
 CHECK_CLAUSE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_TYPE = 'CHECK';
```

---

## Példa: Több mező együttműködése

Az `diakok` tábla esetén: ha van email, akkor az átlagnak minimum 2-nek kell lennie:

```sql
ALTER TABLE `diakok`
 ADD CONSTRAINT chk_email_vs_atlag CHECK (
 (`email` IS NULL) OR (`atlag` >= 2)
 );
```

Ez azt jelenti:

E-mail nélkül - bármilyen átlag megengedett
E-mailel - az átlagnak legalább 2-nek kell lennie

---

## Megszorítások - Összefoglaló

| Megszorítás   | Leírás |  |
| ------------- | ------------------------------------------ | ----------------------------------- |
| `PRIMARY KEY` | Egyedi azonosító, automatikusan `NOT NULL` | `id INT AUTO_INCREMENT PRIMARY KEY` |
| `FOREIGN KEY` | Hivatkozási integritás biztosítása | `diak_id` → `diakok.id`|
| `UNIQUE`      | Érték csak egyszer szerepelhet | `email VARCHAR(120) UNIQUE` |
| `NOT NULL`    | Mező nem lehet üres | `vezeteknev VARCHAR(50) NOT NULL` |
| `DEFAULT`     | Alapértelmezett érték, ha nincs megadva | `szakkor INT DEFAULT 0` |
| `CHECK`       | Érték validálása | - |

**MEGJEGYZÉS**: Az elsődleges kulcs automatikusan UNIQUE is! Nem kell külön UNIQUE-t megadni rá.

