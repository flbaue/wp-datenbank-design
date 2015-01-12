drop table geschäftspartner_object;
drop table kunden_object;

create or replace type geschäftspartner_typ as object
(
  id number(10),
  name varchar2(50),
  straße varchar2(50),
  plz varchar(15),
  stadt varchar(50),
  email varchar(50)
);
/

create or replace type kunde_typ as object
(
  id number(10),
  vorname varchar2(50),
  geschäftspartner_ref ref geschäftspartner_typ
);
/

create table geschäftspartner_object of geschäftspartner_typ;
create table kunden_object of kunde_typ;

insert into geschäftspartner_object
select id, name, straße, plz, stadt, email from geschäftspartnerv;

insert into kunden_object
select k.id, k.vorname, ref(g) from kunden k, geschäftspartner_object g where g.id = k.geschäftspartner_id;

drop view kunden_view;
CREATE VIEW kunden_view AS SELECT k.id kunden_id, k.vorname, k.GESCHÄFTSPARTNER_REF.name name,  
k.GESCHÄFTSPARTNER_REF.straße straße, k.GESCHÄFTSPARTNER_REF.plz plz, k.GESCHÄFTSPARTNER_REF.stadt stadt, 
k.GESCHÄFTSPARTNER_REF.email email
FROM kunden_object k;






