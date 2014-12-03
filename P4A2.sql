/*
create or replace TYPE telefon_typ  AS object (
    typ varchar(25),
    tnummer varchar(25)
);
*/

/*
CREATE OR REPLACE TYPE telefon_liste  AS VARRAY(3) OF TELEFON_TYP;
*/

ALTER TABLE GESCHÄFTSPARTNERV add (
TELEFON_NUMMER telefon_liste);

update GESCHÄFTSPARTNERV set
TELEFON_NUMMER = telefon_liste(telefon_typ('Zentrale','040429750'),telefon_typ('Mobil','0170123456'))
where ID = 12;

update GESCHÄFTSPARTNERV set
TELEFON_NUMMER = telefon_liste(telefon_typ('Zentrale','040429750'),telefon_typ('Außenstelle','01701234564'))
where ID = 13;

update GESCHÄFTSPARTNERV set
TELEFON_NUMMER = telefon_liste(telefon_typ('Zentrale','040429751'),telefon_typ('Mobil','0170123457'),telefon_typ('Büro','01701234578'))
where ID = 14;

select name, typ, tnummer from (select id, name, tp.* from GESCHÄFTSPARTNERV, table(TELEFON_NUMMER) tp) where id = 14;
select name, typ, tnummer from (select name, tp.* from GESCHÄFTSPARTNERV, table(TELEFON_NUMMER) tp) where typ = 'Zentrale';
