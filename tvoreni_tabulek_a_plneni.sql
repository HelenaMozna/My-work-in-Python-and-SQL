CREATE TABLE dim_realitka_mozna
(
    id int NOT NULL,
    nazev nvarchar(100) NOT NULL
)


INSERT INTO
    dim_realitka_mozna (id, nazev)
VALUES
    (1, N'ABC'),
    (2, N'XYZ'),
    (3, N'XZY'),
    (4, N'Nuevo')


INSERT INTO
    dim_realitka_mozna (id, nazev)
VALUES
    (5, N'Novejsi')


-- Vytvoreni primarniho klice

ALTER TABLE
    dim_realitka_mozna
ADD CONSTRAINT
    PK_dim_realitka_mozna_id
PRIMARY KEY CLUSTERED
    (id)

-- v pripade nevalidnich dat, kdyz je 2x stejne id, upravim 3. radek timto zpusobem:
UPDATE 
    dim_realitka_mozna
SET
    id = 3
WHERE
    nazev = N'XZY' 


--vytvoreni tabulky typ vc urceni primarniho klice

CREATE TABLE dim_typ_mozna
(
    id int NOT NULL IDENTITY (1, 1) PRIMARY KEY CLUSTERED,
    nazev nvarchar(100) NOT NULL
)


-- vytvoreni tabulky mestska cast

CREATE TABLE dim_mestska_cast_mozna
(
    id int NOT NULL PRIMARY KEY CLUSTERED,
    nazev nvarchar(100) NOT NULL
)

--Naplaneni tabulek Typ

INSERT INTO
    dim_typ_mozna (id, nazev)
VALUES
    (1, N'dum'),
    (2, N'byt')

Naplneni tabulky mestska cast

INSERT INTO
    dim_mestska_cast_mozna (id, nazev)
VALUES
    (1, N'Brno-sever'),
    (2, N'Brno-sever'),
    (3, N'Brno-Lisen'),
    (4, N'Brno-stred'),
    (5, N'Brno-stred')

--Vytvoreni faktove tabulky

DROP TABLE fact_nemovitost_mozna

CREATE TABLE fact_nemovitost_mozna
(
    nemovitost_id int NOT NULL PRIMARY KEY CLUSTERED, -- primarni klic
    typ_id int NOT NULL,
    realitka_id int NOT NULL, -- NULL - muze byt i nevyplneno
    mestska_ctvrt_id int NOT NULL,
    rozloha NUMERIC,
    cena_kc NUMERIC,
    datum DATE
)

-- zmena z NOT NULL na NULL - povolime i nic nevyplnit

ALTER TABLE
    fact_nemovitost_mozna
ALTER COLUMN 
    realitka_id int NOT NULL


--Naplneni faktove tabulky - musi se dodrzet poradi hodnot a promennych

INSERT INTO
    fact_nemovitost_mozna
    ([nemovitost_id]
      ,[typ_id]
      ,[realitka_id]
      ,[mestska_ctvrt_id]
      ,[rozloha]
      ,[cena_kc]
      ,[datum]
    )
VALUES
    (1, 2, 1, 1, 215, 7000000, '2022-01-01'),
    (2, 2, 1, 1,  56, 2500000, '2022-05-03'),
    (3, 1, 2, 3, 120, 4700000, '2023-02-04'),
    (4, 2, 3, 2,  87, 5600000, '2023-03-05'),
    (5, 2, 4, 2, 100, 6000000, '2023-04-10')


--Cizi klic - vytvoreni

ALTER TABLE
    fact_nemovitost_mozna
ADD CONSTRAINT
    FK_fact_nemovitost_mozna__realitka_id 
FOREIGN KEY
    (realitka_id) -- sloupec z fakt.tabulky
REFERENCES
    dim_realitka_mozna (id) -- sem se chci odkazovat do dim realitka na sloupec id

--Cizi klic pro dim.typ tabulku

ALTER TABLE
    fact_nemovitost_mozna
ADD CONSTRAINT
    FK_fact_nemovitost_mozna__typ_id 
FOREIGN KEY
    (typ_id) -- sloupec z fakt.tabulky
REFERENCES
    dim_typ_mozna (id)


--cizi klic pro tabulku mestska cast

ALTER TABLE
    fact_nemovitost_mozna
ADD CONSTRAINT
    FK_fact_nemovitost_mozna__mestska_ctvrt_id 
FOREIGN KEY
    (mestska_ctvrt_id) -- sloupec z fakt.tabulky
REFERENCES
    dim_mestska_cast_mozna (id)


--Smazani dat 

DELETE FROM
    dim_typ_<jmeno>
WHERE
    id = 1

select * from fact_nemovitost_mozna

--smazani tabulek - zacit od fack tabulky a pak k dim, jinak to nepusti kvuli FK