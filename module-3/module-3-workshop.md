# 3. modul - Workshop

Az előző workshop végére elért adatbázist a [`start-3.sql`](./workshop-sources/start-3.sql) tartalmazza.


1. Jelenítse meg, hogy melyik osztályba ki jár. Az eredményben jelenjen meg a tanuló neve, születési ideje.

2. Jelenítse meg, hogy melyik osztályba ki jár. Az eredményben jelenjen meg a tanuló neve, születési ideje, továbbá az osztályfőnök neve is.

3. Jelenítse meg a diákok jegyeit. A lekérdezésben jelenjen meg a diák neve, születési ideje, az osztályzat értéke és súlya, illetve a tantárgy neve is.
    - Azok a diákok is jelenjenek meg, akik még nem kaptak jegyet.

4. Jelenítse meg a tanárok és a vezetőjük teljes nevét.

    <details>
    <summary>Tipp</summary>

    A `tanarok` táblát kell összekapcsolni a `tanarok` táblával. Mivel a két tábla neve megegyezik, így el kell nevezni legalább az egyik táblát.

    </details>

5. Hogy hívják azt a tanárt, aki még nem írt be jegyet?

    <details>
    <summary>Tipp</summary>

    Külső összekapcsolás esetén, amennyiben egyetlen jegybeírás sem található adott tanárnál, ott a `jegyek` tábla `id` mezője `NULL` értéket eredményez.

    </details>

6. Hogy hívják azokat a diákokat, akik magasabbak, mint az osztályuk átlaga?

    <details>
    <summary>Tipp</summary>

    Itt érdemes lehet első lépésben meghatározni, hogy melyik osztályban átlagosan milyen magasak a diákok.

    Ezt a részeredményt allekérdezésként felhasználva összeköthetjük a diákok táblával.

    </details>

7. Hogy hívják **"Mészáros Bálint"** osztálytársait

    <details>
    <summary>Tipp</summary>

    Elsőként célszerű emgvizsgálni, hogy hova jár az adott tanuló, majd kilistázni az adott osztályba járó összes diákot.

    </details>

8. Hogy hívják a jeles tanulókat?


    <details>
    <summary>Tipp</summary>

    Vegyük azokat a diákoknak az azonosítóját, akik kaptak 5-ös jegynél gyengébb értékelést.

    Mindenki, aki nincs ebben a listában, de kapott már jegyet, az csak kitűnő diák lehet.

    </details>


9. Szúrjon be egy új jegyet (5),  ami 100%-ot ér *"balogh.adam@freemail.hu"* e-mail címmel rendelkező diáknak, *"Matematika"* tantárgyból, amit a legutolsónak felvitt, Matematikát tartó tanár adott.

    <details>
    <summary>Tipp</summary>

    INSERT-ben ishasználhatunk allekérdezéseket

    Elegendő kikeresni a diák azonosítóját az e-amil cím szerint.

    A tantárgy azonosítóját kikereshetjük a neve alapján. (Ha több Matematika is szerepelne, akkor ez így nem megoldható)

    Meg kell keresni, hogy mi a legutóbb felvitt matematikát (is) tanító tanár azonosítója. Ha új tanárt szúrnánk be, akkor már más lenne a végeredmény.

    </details>

10. Hogy hívják azokat a tanárokat, akik adtak már valakinek 5-öst?

