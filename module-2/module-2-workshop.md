# 2. modul - Workshop

A korábbi adatbázisban néhány hiba található, ezeket kellene kijavítani. Az előző workshop végére elért adatbázist a [`start-2.sql`](./workshop-sources/start-2.sql) tartalmazza.

1. A `tanar` táblában igen kevés hobi fér bele 12 karakterbe. Bővítse ki, hogy 50 karaktert lehessen eltárolni.

2. A `kor` igen problémás mező, ugyanis évről évre frissítani kell. Törölje a `diakok` és a `tanarok` táblákból is.

3. A `diakok` tábla `szulido` mezőjét nevezze át `szuletett`-re.

4. Módosítsa az osztalyok táblát az alábbiak szerint:
    - A `terem` ezőt nevezze át `tanterem`re.
    - Törölje az `osztalyfonok` mezőt.
    - Hozzon létre egy mezőt `osztalyfonok_id` néven, ami megfelelő lesz idegenkulcsnak. Alapértelmezett értéke legyen `NULL`.

5. Futtassa a [`osztalyfonok.sql`](./workshop-sources/osztalyfonok.sql) fájlt, hogy az osztályfőnökök is bekerüljenek a `tanarok` táblába.

    <summary>Segítség</summary>

    A `kor` mező már törölve lett, így az nincs már a fájlban

    </details>

6. Hozzon létre idegen kulcs megszorítást úgy, hogy
    - az `osztalyok` tábla `osztalyfonok_id` mezője a `tanarok` tábla `id` mezőjére hivatkozzon,
    - továbbá a tanárt ne engedje kitörölni, amíg van hozzá tartozó osztály.

7. Állítsa be, hogy az osztályok a saját, korábban megadott osztályfőnökükre hivatkozzanak.

    | Osztály | Osztályfőnök      |
    | ------- | ----------------- |
    | 9.A     | Kovácsné Erzsébet |
    | 9.B     | Varga László      |
    | 9.C     | Nagy Gábor        |
    | 10.A    | Szabó István      |
    | 10.B    | Tóth Erika        |
    | 10.C    | Papp Ferenc       |
    | 11.A    | Molnár Judit      |
    | 11.B    | Bíró Attila       |
    | 12.A    | Farkas Pál        |
    | 12.B    | Simon Klára       |

    <summary>Segítség</summary>

    Még nem vettük az allekérdezéseket, így elegendő kézzel lekérdezni, hogy az adott tanárnak mi az azonosítója, majd úgy megadni az `UPDATE` lekérdezésnek.

    ```sql
    SELECT id, CONCAT(vezeteknev, ' ', keresztnev) AS nev FROM tanarok ORDER BY nev;
    ```

    </details>

8. Bővítse a `tanarok` táblát egy `vezeto` mezővel, ami megfelelő lesz idegenkulcsnak. Alapértelmezett értéke legyen `NULL`.

9. Hozzon létre idegen kulcs megszorítást úgy, hogy
    - a `tanarok` tábla `vezeto` mezője a `tanarok` tábla `id` mezőjére hivatkozzon,
    - továbbá a tanárt ne engedje kitörölni, amíg van hozzá tartozó tanár.

10. Állítsa be, hogy az `1`-es azonosítójú tanár kivételével mindenkinek az `1`-es azonosítójú tanár legyen a vezetője.

11. Módosítsa úgy a `tanarok` és `diakok` táblákat, hogy a `nem` értéke csak `0` vagy `1` értéket vehessen fel

12. Tesztelje egy lekérdezéssel, ami módosítja az `1`-es azonosítójú tanuló nemét `3`-ra.

13. Hozza létre a `jegyek` táblát az alábbi táblázatnak megfelelően.

    | Mező neve     | Típus      | Leírana                                                |
    | ------------- | ---------- | ------------------------------------------------------ |
    | `id`          | Egész szám | A jegy azonosítója, elsődleges kulcs                   |
    | `diak_id`     | Egész szám | Tanulo azonosítója                                     |
    | `tanar_id`    | Egész szám | Az értékelő tanár azonosítója                          |
    | `tantargy_id` | Egész szám | Tárgyazonosito                                         |
    | `ertek`       | Egész szám | Értékelés (1-5)                                        |
    | `suly`        | Valós      | Az értékeléstúlya                                      |
    | `rogzitve`    | Dátum/idő  | Rögzítés időpontja (alapértelmezett: aktuális idopont) |

    - Az összes mező kötelezően kitöltendő
    - Az `rogzitve` oszlop alapértelmezett értéke legyen a jelenlegi időpont (`CURRENT_TIMESTAMP`).
    - Az `ertek` mezőt eleve úgy hozza létre, hogy csak 1 és 5 közötti egész számot kaphasson
    - A `diak_id`, `tanar_id`, `tantargy_id` is kapjon idegenkulcs megszorítást a megfelelő táblák `id` mezőire nézve.

14. Vigye fel az értékeléseket a `jegyek.sql` fájl futtatásával.