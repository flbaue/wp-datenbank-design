create cluster geschäftspartner
(
  g_id number(10)
)
tablespace users;

create index geschäftspartner_cluster
on cluster geschäftspartner
tablespace users;

create table geschäftspartner_cluster(
  ID NUMBER(10) NOT NULL CONSTRAINT PK_GESCHÄFTSPARTNER_C PRIMARY KEY,
  NAME VARCHAR2(50 BYTE),
  STRAßE VARCHAR2(50 BYTE),
  PLZ VARCHAR2(15 BYTE),
  STADT VARCHAR2(50 BYTE),
  EMAIL VARCHAR2(50 BYTE))
cluster geschäftspartner(ID);

create table kunden_cluster(
  ID NUMBER(10) NOT NULL CONSTRAINT PK_KUNDEN_C PRIMARY KEY,
  VORNAME VARCHAR2(50 BYTE),
  GESCHÄFTSPARTNER_ID number(10) NOT NULL CONSTRAINT FK_KUNDEN_GESCHÄFTSPARTNER_C REFERENCES geschäftspartner_cluster)
cluster geschäftspartner(ID);

create table lieferanten_cluster(
  ID NUMBER(10) NOT NULL CONSTRAINT PK_LIEFERANTEN_C PRIMARY KEY,
  ANSPRECHPARTNER VARCHAR2(50 BYTE),
  BEWERTUNG VARCHAR2(50 BYTE),
  GESCHÄFTSPARTNER_ID number(10) NOT NULL CONSTRAINT FK_LIEFERANTEN_GESCHÄFTS_C REFERENCES geschäftspartner_cluster)
cluster geschäftspartner(ID);


insert into geschäftspartner_cluster (select * from geschäftspartner);
insert into kunden_cluster (select * from kunden);
insert into lieferanten_cluster (select * from lieferanten);












