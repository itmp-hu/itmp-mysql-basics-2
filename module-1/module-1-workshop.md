# 1. modul - Workshop

Az első modul feladata, hogy létrejöjjenek a táblák, amik legyenek adatokkal feltöltve.

1. Hozza létre az `iskola` adatbázist. Ügyeljen rá, hogy a karakterkódolás `utf-8` legyen, továbbá a rendezést a magyar nyelvi szabályoknak megfelelően kezelje.

<summary>Tipp</summary>

Az `utf8mb4` olyan karakterkészlet, ami támogatja a magyar ékezetes karaktereket, sőt még emoji karaktereket is kezeli.

A `SHOW CHARACTER SET` lekérdezés megadja, hogy milyen karakterkészleteket ismer az adatbáziskezelő.

A `SHOW COLLATION` lekérdezés megadja, hogy milyen nyelvi beállításokat ismer az adatbáziskezelő.

</details>

2. Állítsa be, hogy az `iskola` adatbázis legyen a kiválasztott.

3. Törölje a `tanarok` táblát az adatbázisból, ha már létezne.


    <summary>Tipp</summary>

    Éles rendszeren nem érdemes előre törölni a táblát, de az első óra alkalmával segít, ha ez a lekérdezés is megvan.

    Amíg a diákok nem tudnak szerkeszteni a hibákat törléssel tudják korrigálni.

    </details>

4. Hozza létre a `tanarok` táblát az alábbi táblázatnak megfelelően.

    | Mező neve    | Típus            | Leírás                                                              |
    | ------------ | ---------------- | ------------------------------------------------------------------- |
    | `id`         | Egész szám       | A tanár azonosítója, ez az elsődleges kucs, automatikusan növekszik |
    | `vezeteknev` | Szöveg (max. 50) | Tanár vezetékneve                                                   |
    | `keresztnev` | Szöveg (max. 50) | Tanár keresztneve                                                   |
    | `szuletett`  | Dátum            | Születési dátum                                                     |
    | `kor`        | Egész szám       | Életkor (évben)                                                     |
    | `nem`        | Logikai          | A tanár neme: 0 = nő, 1 = férfi                                     |
    | `szak`       | Szöveg (max. 20) | Szakok megnevezése (opcionális)                                     |
    | `hobbi`      | Szöveg (max. 12) | Hobbi megnevezése (opcionális)                                      |
    | `tanora`     | Egész szám       | Heti tanórák száma                                                  |
    | `szakkor`    | Egész            | Szakkörök száma                                                     |
    

    - Az opcionális mezők kivételével legyen minden mást kötelező kitölteni.

5. Vigye fel Nagy Pétert az alábbi táblázat szerint:

    | Vezetéknév | Keresztnév | Született  | Kor | Nem | Szak              | Hobbi | Tanóra | Szakkör |
    | ---------- | ---------- | ---------- | --- | --- | ----------------- | ----- | ------ | ------- |
    | Nagy       | Péter      | 1982-04-12 | 43  | 1   | Matematika/Fizika | Futás | 24     | 1       |


6. Szúrja be az **összes többi** tanár adatát a `tanar` táblába! Az adatokat a [`tanarok.csv`](./workshop-sources/tanarok.csv) fájl tartalmazza.
    - Nagy Péter már szerepel az adatbázisban, őt már nem kell felvini.
    - Az összes többi tanárt egyetlen lekérdezés segítségével vigye fel az adatbázisba.
    - Célszerű a multikurzor használata VS Code-ban.

7. Törölje az `osztalyok` táblát az adatbázisból, ha már létezne.

8. Hozza létre az `osztalyok` táblát az alábbi táblázatnak megfelelően.

    | Mező neve      | Típus             | Leírana                                  |
    | -------------- | ----------------- | ---------------------------------------- |
    | `id`           | Egész szám        | Az osztály azonosítója, elsődleges kulcs |
    | `nev`          | Szöveg (max. 10)  | Osztálynév (pl. 9.A)                     |
    | `terem`        | Szöveg (max. 20)  | A tanterem helye                         |
    | `osztalyfonok` | Szöveg (max. 100) | Osztályfőnök neve                        |

    - Minden mező legyen kötelező kitölteni.

9. Vigye fel az összes osztály adatait az `osztalyok` táblába! Az adatokat a [`osztalyok.csv`](./workshop-sources/osztalyok.csv) fájl tartalmazza.

10. Törölje a `diakok` táblát az adatbázisból, ha már létezne.

11. Hozza létre a `diakok` táblát az alábbi táblázatnak megfelelően.

    | Mező neve     | Típus             | Leírás                               |
    | ------------- | ----------------- | ------------------------------------ |
    | `id`          | Egész szám        | A diák azonosítója, elsődleges kulcs |
    | `vezeteknev`  | Szöveg (max. 50)  | Diák vezetékneve                     |
    | `keresztnev`  | Szöveg (max. 50)  | Diák keresztneve                     |
    | `nem`         | Logikai           | A diák neme: 0 = nő, 1 = férfi       |
    | `osztaly_id`  | Egész             | Az osztály azonosítója               |
    | `szulido`     | Dátum             | Születési dátum                      |
    | `kor`         | Egész szám        | Életkor (évben)                      |
    | `email`       | Szöveg (max. 120) | Email cím (opcionális)               |
    | `magassag_cm` | Egész szám        | Magasság centiméterben               |
    | `atlag`       | Lebegőpontos      | Tanulmányi átlag                     |
    | `irsz`        | Egész szám        | Irányítószám                         |
    | `lakcim`      | Szöveg (max. 100) | Lakcím                               |

    - Az opcionális mezők kivételével legyen minden mást kötelező kitölteni.

10. Vigye fel az összes diák adatát a `diakok` táblába! Az adatokat a [`diakok.csv`](./workshop-sources/diakok.csv) fájl tartalmazza.

11. Hozza létre a `tantargyak` táblát az alábbi táblázatnak megfelelően.

    | Mező neve | Típus            | Leírana                               |
    | --------- | ---------------- | ------------------------------------- |
    | `id`      | Egész szám       | A tárgy azonosítója, elsődleges kulcs |
    | `nev`     | Szöveg (max. 50) | Tárgy neve                            |

12. Vigye fel a tantárgyak adatait a `tantargyak` táblába! Az adatokat a [`tantargyak.csv`](./workshop-sources/tantargyak.csv) fájl tartalmazza.

13. Hozza létre a `diak_tantargy` táblát, ami összerendezi a tanulókat és a tantárgyaikat.

    | Mező neve     | Típus      | Leírana            |
    | ------------- | ---------- | ------------------ |
    | `diak_id`     | Egész szám | Tanulo azonosítója |
    | `tantargy_id` | Egész szám | Tárgyazonosító     |

    - A két mező együttesen elsődleges kulcs.

