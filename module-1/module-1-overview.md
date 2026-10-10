# 1. modul - Létrehozás és törlés

## A modul témakörei

- MySQL-ben használt típusok
- Adatbázis létrehozása és törlése
    - CREATE DATABASE <!-- SHOW COLLATE, utf8mb4 -->
    - DROP DATABASE
- Táblák létrehozása és törlése
    - CREATE TABLE <!-- Primary is benne van,  CREATE TABLE AS SELECT-->
    - DROP TABLE
- Adatok beszúrása, törlése
    - INSERT INTO
    - DELETE FROM
    - TRUNCATE

---

## Típusok áttekintés

- Főbb adattípusok
  - Szöveges típusok
  - Numerikus típusok
  - Dátum és idő típusok
  - Speciális típusok

További információk a MySQL dokumentációjában: https://dev.mysql.com/doc/refman/9.7/en/data-types.html

---

## Gyakori típusok

| Típus      | Leírás                             | Csoport      |
| ---------- | ---------------------------------- | ------------ |
| `CHAR`     | Fix hosszúságú karakterlánc        | Szöveges     |
| `VARCHAR`  | Változó hosszúságú karakterlánc    | Szöveges     |
| `TEXT`     | Nagy mennyiségű szöveg             | Szöveges     |
| `INT`      | Egész szám                         | Numerikus    |
| `FLOAT`    | Lebegőpontos szám                  | Numerikus    |
| `DOUBLE`   | Dupla pontosságú lebegőpontos szám | Numerikus    |
| `DATE`     | Dátum                              | Dátum és idő |
| `TIME`     | Idő                                | Dátum és idő |
| `DATETIME` | Dátum és idő                       | Dátum és idő |

---

## Szöveges típusok - CHAR(n)

- Fix hosszúságú karakterlánc
- Megadott darabszámú (n) karaktert tud eltárolni
- Méret: 0-255 karakter között mozoghat
- Az eltárolt adatok hossza fix
- Rövidebb szövegnél kitölti szóközökkel
- A `PAD_CHAR_TO_FULL_LENGTH` paraméter adja meg, hogy az adatok kiolvasásakor megjelenjenek-e a kitöltő szóközök
- Túl hosszú szöveg esetén adatvesztés történik

---

## Szöveges típusok - VARCHAR(n)

- Változó hosszúságú karakterlánc
- Legfeljebb megadott darabszámú (n) karaktert tud eltárolni
- Méret: 0-65 535 karakter között van
- El kell az adat mellett azt is tárolni, hogy hány karakterből áll
- Rövidebb szövegnél nem történik semmi
- Túl hosszú szövegnél adatvesztés történik!
- Függ a karakterkészlettől és hogy mekkora adatot tárolhat

---

## Szöveges típusok - TEXT(M)

Nagyobb szövegtartalom tárolására alkalmas, például üzenet vagy blogbejegyzés.

| Típus        | Méret (karakter)     |
| ------------ | -------------------- |
| `TINYTEXT`   | 255                  |
| `TEXT`       | 65 535               |
| `MEDIUMTEXT` | 16 777 215           |
| `LONGTEXT`   | 4 294 967 295 (4 GB) |

- Az `M` megadásakor a megfelelő méretet választja ki
- https://dev.mysql.com/doc/refman/9.7/en/string-type-syntax.html

---

## Numerikus típusok - INT(M) előjeles

Előjeles egész szám tárolása:

| Előtag      | Méret (byte) | Minimum        | Maximum       |
| ----------- | ------------ | -------------- | ------------- |
| TINYINT     | 1            | -128           | 127           |
| SMALLINT    | 2            | -32 768        | 32 767        |
| MEDIUMINT   | 3            | -8 388 608     | 8 388 607     |
| INT/INTEGER | 4            | -2 147 483 648 | 2 147 483 647 |
| BIGINT      | 8            | -2^63          | 2^63-1        |

**Fontos:** Az `M` itt a minimum megjelenítési szélességet jelenti! Ez az érték elavult, későbbi verziókból kikerülhet. INT(11) helyett INT-et használjunk!

**FIGYELEM**: Az M megadása elavult, későbbi verziókból kikerülhet. INT(11) helyett INT-et használjunk!

- https://dev.mysql.com/doc/refman/9.7/en/integer-types.html

---

## Numerikus típusok - UNSIGNED INT

- Előjel nélküli egész számok
- Negatív szám nem írható be, cserébe kétszer annyi pozitív számot tudunk tárolni!

| Típus              | Méret (byte) | Maximum       |
| ------------------ | ------------ | ------------- |
| TINYINT UNSIGNED   | 1            | 255           |
| SMALLINT UNSIGNED  | 2            | 65 535        |
| MEDIUMINT UNSIGNED | 3            | 16 777 215    |
| INT UNSIGNED       | 4            | 4 294 967 295 |
| BIGINT UNSIGNED    | 8            | ~1,8x10^19    |

---

## Numerikus típusok - FLOAT(p)

Lebegőpontos szám tárolására alkalmas típus.

- `p` számábrázolás pontossága (bitekben): 0-23 -> 4 byte, míg 24-53 -> 8 byte
- A `p` elhagyásával a kapott kód hordozhatóbb a különböző típusú adatbázisok között

**FIGYELEM**: Megközelítő értéket tárol, nem a pontos értéket.

- https://dev.mysql.com/doc/refman/9.7/en/floating-point-types.html
- https://dev.mysql.com/doc/refman/9.7/en/problems-with-float.html

---

## Numerikus típusok - DECIMAL(M,D)

Pontos tizedes tört szám tárolására alkalmas típus.

- `M` teljes számjegy száma (1-65 közötti érték)
  - 0 <= D < M, ahol D a tizedesjegyek száma
- A `(M,D)` megadás kötelező a kiszámítható viselkedés érdekében; elhagyása esetén az adatbázis dinamikusan állítja be a pontosságot

**FONTOS**: Pontos értéket tárol, nem közelítést. Pénzügyi, adózási és tudományos számításokhoz ajánlott FLOAT helyett.

- https://dev.mysql.com/doc/refman/9.7/en/fixed-point-types.html
- https://dev.mysql.com/doc/refman/9.7/en/precision-math.html

---

## Dátum és idő típusok

| Típus       | Értékkifejezés formátuma | Tartomány                                          |
| ----------- | ------------------------ | -------------------------------------------------- |
| `DATE`      | 'YYYY-MM-DD'             | 1000-01-01 és 9999-12-31                           |
| `DATETIME`  | 'YYYY-MM-DD HH:MM:SS'    | 1000-01-01 00:00:00 és 9999-12-31 23:59:59         |
| `TIMESTAMP` | 'YYYY-MM-DD HH:MM:SS'    | 1970-01-01 00:00:01 UTC és 2038-01-19 03:14:07 UTC |
| `TIME`      | 'HH:MM:SS'               | -838:59:59 és +838:59:59 között                    |

- A `TIMESTAMP` időzóna konverziót is végez!

**2038-AS PROBLÉMA**: A TIMESTAMP az 1970-01-01 óta eltelt másodpercek számát számolja, egy 32 bites rendszeren ez túlcsordul 2038-ban.

---

## Dátum és idő jelölése

- Az SQL szabvány szerint szövegként megadható, de előtte jelölni kell típusát, MySQL-ben opcionális
  - Például: `DATE '2026-10-10'`
- A `DATE` típus elfogadja a `'YYYY-MM-DD'` formátumot.
- A `TIME` típus elfogadja a `'D hh:mm:ss'` formátumot, ahol opcionális a D, a napok száma (0-34).
- A `DATETIME` és a `TIMESTAMP` a `'YYYY-MM-DD hh:mm:ss'` formátumot preferálja. Szóköz helyett egy `T` is elválaszthatja.
- Bizonyos esetekben rövidíthető lehet pl.: `'97-12-6 16:5:41'`
- https://dev.mysql.com/doc/refman/9.7/en/date-and-time-literals.html

---

## Speciális típusok - ENUM

Az `ENUM` egy speciális felsoroló típus:

- Csak a megadott értékeket veheti fel az adott mező
- Az adat amit megadunk az szöveg, de a háttérben számként tárolja el
- A lekérdezés könnyen olvasható marad

```sql
`jegy_tipus` ENUM('hazi','dolgozat','temazaro')
```

Ekkor a `jegy_tipus` mezőben csak a felsorolt értékek lehetnek. Feltételben:

```sql
WHERE `jegy_tipus` = 'temazaro'
```

---

## Speciális típusok - BOOL/BOOLEAN

- `BOOL` vagy `BOOLEAN` a MySQL-ben valójában alias a `TINYINT(1)` típusra
- Az 1 IGAZ
- Minden más HAMIS

# D02 - Adatbázis és tábla létrehozás

---

## Adatbázis létrehozása - CREATE DATABASE

A legegyszerűbb parancs adatbázis létrehozásához:

```sql
CREATE DATABASE `iskola`;
```

- A karakterkódolás a szerver alapértelmezett beállítása lesz (pl.: `latin1_swedish`)
  - MariaDB esetében `latin1`
  - MySQL 8-tól már `utf8`

**FIGYELEM**: A magyar ékezetes betűket nem kezeli jól a `latin1` karakterkódolás.

---

## Adatbázis létrehozása karakterkódolással

```sql
CREATE DATABASE `iskola`
    DEFAULT CHARACTER SET utf8mb4
    COLLATE utf8mb4_hungarian_ci;
```

| Beállítás          | Érték                         | Leírás           |
| ------------------ | ----------------------------- | ---------------- |
| Adatbázis neve     | `iskola`                      | Tetszőleges név  |
| Karakterkódolás    | `utf8mb4`                     | UTF-8 kódolás    |
| Nyelvi beállítások | `utf8mb4_hungarian_ci`        | Rendezés: Magyar |
| Kis/nagybetű       | Érzéketlen (Case Insensitive) |                  |

---

## utf8 és utf8mb4

| Tulajdonság          | utf8           | utf8mb4 |
| -------------------- | -------------- | ------- |
| Karakter max. mérete | 3 byte         | 4 byte  |
| Angol ABC            | Igen           | Igen    |
| Magyar ékezetes betű | Igen           | Igen    |
| Kínai, Japán         | Többnyire igen | Igen    |
| Emoji                | Nem            | Igen    |

- Új adatbázist célszerű `utf8mb4` karakterkódolással létrehozni
- Az angol ABC karakterei ugyanannyit foglalnak, mint `latin1`-ben

---

## Adatbázis létrehozása - csak ha nem létezik

```sql
CREATE DATABASE IF NOT EXISTS `iskola`
    DEFAULT CHARACTER SET utf8mb4
    COLLATE utf8mb4_hungarian_ci;
```

- Csak akkor hozza létre az adatbázist, ha még nem létezik
- Ezzel az "adatbázis már létezik" hibaüzenet kiküszöbölhető egy script futtatásakor
- Hibaüzenet helyett csak figyelmeztetést kapunk

---

## Alapértelmezett adatbázis kiválasztása - USE

```sql
USE `iskola`;
```

- Mivel még csak most hoztuk létre az adatbázist, így a `USE` paranccsal megadhatjuk, hogy a lekérdezésekhez ezentúl ezt szeretnénk használni
- PHPMyAdminban elég rákattintani az adatbázis nevére
  - Ha nem jelenik meg, akkor frissíteni kell

---

## Adatbázis törlése - DROP DATABASE

```sql
DROP { DATABASE | SCHEMA } [IF EXISTS] db_name;
```

- A `DROP DATABASE` segítségével dobhatjuk el az adatbázist
- A MySQL `DATABASE` és `SCHEMA` között nem tesz különbséget

Példák:

```sql
DROP DATABASE `iskola`;
```

```sql
DROP DATABASE IF EXISTS `iskola`;
```

**FIGYELEM**: Az adatbázisban tárolt adatok véglegesen elvesznek!

- https://dev.mysql.com/doc/refman/9.7/en/drop-database.html

---

## Tábla létrehozása - CREATE TABLE

```sql
CREATE TABLE `tabla_neve`(
    `mezo`   tipus1 egyebek1,
    `mezo2`  tipus2 egyebek2
);
```

- A `tabla_neve` tetszőleges, általunk választható név!
- Célszerű eldönteni, hogy egyes vagy többesszámot alkalmazzuk — mind a kettő lehet jó megoldás, de legyen egységes!
- A mezőnevek is tetszőlegesek
- https://dev.mysql.com/doc/refman/9.7/en/create-table.html

---

## Elnevezési szabályok

1. A választott név **ne legyen kulcsszó**!
2. **Ne tartalmazzon szóközt**!
3. Amennyiben mindenképpen kulcsszót szeretnénk alkalmazni névként, akkor azt határolók közé kell elhelyezni — MySQL esetében ez a backtick.

```sql
CREATE TABLE `user`(
    `name`   VARCHAR(25) NOT NULL,
    `date`  DATE NOT NULL
);
```

- A `date` kulcsszó
- https://dev.mysql.com/doc/refman/9.7/en/keywords.html

---

## Alapértelmezett érték érték

A `DEFAULT <ertek>` megszorítással adhatjuk meg, az alapértelmezett értéket:

```sql
CREATE TABLE `pelda`(
    `szin` VARCHAR(25) DEFAULT 'sárga'
);
```

- Ez lehet konkrét érték: `sárga`

```sql
CREATE TABLE `pelda`(
    `szin` VARCHAR(25) DEFAULT NULL
);
```

- Akár lehet `NULL` is
- Ha mást nem adunk meg ez lesz az alapértelmezett értéke.

---

## Kötelező mezők - NOT NULL

A `NOT NULL` megszorítás megadásával kötelezően kitöltendővé tehetünk egy adott mezőt:

```sql
CREATE TABLE `pelda`(
    `szin` VARCHAR(25) NOT NULL
);
```

**FIGYELEM**: Nem lehet egyszerre `DEFAULT NULL` és `NOT NULL` is! Hibás kombináció (Szintaktikai hiba)

---

## Példa tábla létrehozására

Hozzunk létre az alábbi leírás alapján egy táblát:

| Mező | Típus                | Megkötés              | Leírás     |
| ---- | -------------------- | --------------------- | ---------- |
| név  | VARCHAR(25) (Szöveg) | kötelezően kitöltendő | Tanár neve |
| kor  | INT (Egész)          | kötelezően kitöltendő | Tanár kora |

```sql
CREATE TABLE `tanarok`(
    `nev` VARCHAR(25) NOT NULL COMMENT 'Tanár neve',
    `kor` INT NOT NULL COMMENT 'Tanár kora'
);
```

- A `COMMENT` segítségével magunknak tárolhatunk el információkat az adott mezőről.

---

## Elsődleges kulcs (PRIMARY KEY) - két lehetséges mód

**1. módszer: mező tulajdonságként**

```sql
CREATE TABLE `pelda`(
    `id` INT NOT NULL PRIMARY KEY
);
```

**2. módszer: a mezők felsorolása után**

```sql
CREATE TABLE `pelda`(
    `id` INT NOT NULL,
    PRIMARY KEY (`id`)
);
```

- A fenti két utasítás ugyanazt eredményezi!

---

## Elsődleges kulcs - összetett kulcs hibás példa

Az elsődleges kulcs állhat több mezőből, ekkor **összetett kulcsról** beszélünk.

**HIBA #1068**: Többszörös elsődleges kulcs definiálás. Mind a kettőt szeretné elsődleges kulcsnak, amiből csak egy lehet.

```sql
CREATE TABLE `pelda`(
    `nev` VARCHAR(20) NOT NULL PRIMARY KEY,
    `kor` INT(11) NOT NULL PRIMARY KEY,
    `cim` VARCHAR(20)
);
```

---

## Elsődleges kulcs - összetett kulcs helyes példa

```sql
CREATE TABLE `pelda`(
    `nev` VARCHAR(20) NOT NULL,
    `kor` INT(11) NOT NULL,
    `cim` VARCHAR(20),
    PRIMARY KEY (`nev`, `kor`)
);
```

- A mezők felsorolása után adhatjuk meg
- Jelentése: A két mező együttesen legyen elsődleges kulcs

---

## ID mező példa - AUTO_INCREMENT

```sql
CREATE TABLE `tantargy`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `nev` VARCHAR(30) NOT NULL,
    PRIMARY KEY (`id`)
);
```

| Kulcsszó         | Leírás                                       |
| ---------------- | -------------------------------------------- |
| `BIGINT`         | 2^63-1 szám tárolására alkalmas              |
| `UNSIGNED`       | Nem lehet negatív                            |
| `NOT NULL`       | Az elsődleges kulcs kitöltése kötelező       |
| `AUTO_INCREMENT` | Az adott mező egy automatikusan növekvő szám |

- Az ID alapértelmezett értékét a különböző adatbázis-kezelő rendszerekben máshogy kell beállítani
- https://www.w3schools.com/sql/sql_autoincrement.asp

---

## Táblák törlése - DROP TABLE

**Egy tábla és adatainak törlése:**

```sql
DROP TABLE `tantargyak`;
```

**Egy tábla és adatainak törlése, ha létezik:**

```sql
DROP TABLE IF EXISTS `tanarok`;
```

**Több tábla törlése az adatokkal együtt:**

```sql
DROP TABLE `diakok`, `osztalyok`;
```

---

## Adatok beszúrása - INSERT INTO

Adatok beszúrására az `INSERT INTO` szolgál:

```sql
INSERT INTO `osztalyok` (`nev`, `terem`, `osztalyfonok`) VALUES
('9.A',  '101. terem', 'Kovácsné Erzsébet');
```

- Új sor beszúrásánál meg kell adni, hogy melyik táblába szeretnénk beszúrni.
- Megadhatjuk, hogy mely mezőkbe szeretnénk adatot beszúrni, a `VALUES()` részbe pedig a beszúrandó értékek kerülnek.

```sql
INSERT INTO `osztalyok` VALUES
('9.A',  '101. terem', 'Kovácsné Erzsébet');
```

- A mezők felsorolása elhagyható, de ilyenkor ki kell tölteni minden mezőt!

---

## INSERT INTO - hibás zárójelezés

**HIBA #1241**: A felesleges zárójelezés okozza a hibát!

```sql
INSERT INTO `osztalyok` (`nev`, `terem`, `osztalyfonok`)
VALUES (
    ('9.A',  '101. terem', 'Kovácsné Erzsébet'),
    ('9.B',  '102. terem', 'Varga László')
);
```

---

## Több sor beszúrása helyesen

```sql
INSERT INTO `osztalyok` (`nev`, `terem`, `osztalyfonok`)
VALUES
    ('9.A',  '101. terem', 'Kovácsné Erzsébet'),
    ('9.B',  '102. terem', 'Varga László'),
    ('9.C',  '103. terem', 'Nagy Gábor')
;
```

- Több sor beszúrásakor a `VALUES()` részt **egyszer** kell feltüntetni!
- A rekordokat vesszővel kell elválasztani
- Az utasítás végén pontosvessző lesz.

---

## Adat törlése - DELETE FROM

**Összes adat törlése:**

```sql
DELETE FROM `diakok`;
```

- Kérdés nélkül töröl minden adatot a táblából véglegesen!

**Feltételes törlés:**

```sql
DELETE FROM `diakok`
WHERE `keresztnev` = 'Péter';
```

```sql
DELETE FROM `diakok`
WHERE `kor` < 5;
```

- A `WHERE` záradékban tetszőleges feltétel megadható

**FIGYELEM**: Az adatok törlése végleges!

---

## Tábla összes adatának törlése - TRUNCATE

```sql
TRUNCATE [TABLE] tabla_neve;
```

- Amennyiben a táblára még szükségünk van, de az adatokra nem, akkor kiüríthetjük a tartalmát.
- Kifejezetten hasznos `INSERT` gyakorláskor elkövetett hibák javítására.

```sql
TRUNCATE TABLE `diakok`;
```

**FIGYELEM**: Az adatok törlése végleges!

---

## DELETE és TRUNCATE összehasonlítása

**DELETE FROM**

- Minden sort töröl
- DML utasítás (adatokat töröl)
- Az `AUTO_INCREMENT` értéke megmarad
- Lassú, mert soronként hajtja végre
- Kezeli az idegenkulcs megszorításokat (`CASCADE`)

**TRUNCATE TABLE**

- Minden sort töröl
- DDL utasítás (táblát töröl, majd újra létrehozza)
- Az `AUTO_INCREMENT` értékét kinullázza
- Gyors
- Idegenkulcs megszorítás meggátolhatja a futásban
