# Konvolúció mátrixszorzással – MATLAB DSP-projekt

Egyetemi **Digitális jelfeldolgozás** projekt, amely véges hosszúságú diszkrét jelek lineáris konvolúcióját valósítja meg mátrixszorzással. A projekt teljes és ritka (*sparse*) konvolúciós mátrixokat készít, ellenőrzi a számítások helyességét, valamint összehasonlítja a különböző módszerek futásidejét és memóriaigényét.

## Fájlok

| Fájl | Leírás |
|---|---|
| `konvmatrix.m` | Teljes konvolúciós mátrix létrehozása a megadott jelből. |
| `matkonv.m` | Két jel konvolúciója egyetlen mátrixszorzással; a hosszabb jelből épít mátrixot. |
| `matkonv_idx.m` | Konvolúció a bemeneti és kimeneti időindexek kezelésével. |
| `konvmatrix_sparse.m` | A konvolúciós mátrix ritka tárolású, ciklus nélküli előállítása. |
| `teszt_matkonv.m` | Ismert példák, peremesetek, 1000 véletlen próba, időindexek és sparse egyezés ellenőrzése. |
| `kiserlet_futasido.m` | Négy konvolúciós módszer futásidő- és három mátrixos módszer memória-összehasonlítása. |

## Követelmények

- MATLAB (a projektet **R2026b** verzióval használtam).
- A hat `.m` fájl legyen ugyanabban a mappában vagy a MATLAB keresési útvonalán.

## Használat

Példa a Command Windowban:

```matlab
x = [1 2 -1];
h = [1 1 1 1];
y = matkonv(x, h)
% y = [1 3 2 2 1 -1]
```

Konvolúció időindexekkel:

```matlab
[y, ny] = matkonv_idx([1 2 -1], [0 1 2], [1 1 1 1], [-1 0 1 2]);
% ny = [-1 0 1 2 3 4]
```

A két önálló szkript futtatása:

```matlab
teszt_matkonv
kiserlet_futasido
```

A `teszt_matkonv` a Command Windowban írja ki a tesztek eredményét, és `stem` ábrát készít a hárompontos, nem kauzális mozgóátlagról. A `kiserlet_futasido` log-log grafikonon hasonlítja össze a módszereket, valamint kiírja a mért memóriaadatokat és futásidőket.

## A teljesítménykísérlet módszerei

1. MATLAB beépített `conv` függvénye.
2. Saját, optimalizált `matkonv` teljes mátrixszal.
3. Teljes konvolúciós mátrix a rövidebb `h` szűrőből.
4. Ritka konvolúciós mátrix a `h` szűrőből.

A szűrő hossza **31 minta**. Az 1., 2. és 4. módszer 256–65536 bemeneti mintára, a 3. módszer csak 256–4096 mintára kerül mérésre a nagy memóriaigény miatt. A mátrix létrehozási ideje beleszámít a futásidőbe. A memóriafoglalás mérése `Lx = 4096` esetén történik; a legnagyobb teljes mátrix memóriaigényét a szkript csak becsüli, nem foglalja le.

A véletlen bemenetek reprodukálhatóságát a `rng(2026)` biztosítja; a futásidők a futtatási környezettől függően változhatnak.

## Dokumentáció

A projekt módszereinek, tesztjeinek és mérési eredményeinek részletes bemutatását a külön beadandó jegyzőkönyv tartalmazza.
