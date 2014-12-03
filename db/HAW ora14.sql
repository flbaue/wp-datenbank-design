insert into kunden values(10,'Klaus','Mustermann','Berliner Tor 7',20099,'Hamburg');
insert into kunden values(11,'Anke','Kraft','Berliner Tor 5',20099,'Hamburg');
insert into kunden values(12,'Olaf','Meier','Bremer Landstrasse',21680,'Stade');
insert into kunden values(13,'Jakob','Schmidt','Berner Heerweg 13',20098,'Hamburg');
insert into kunden values(14,'Elke','Bremer','Berliner Tor 21',20099,'Hamburg');
insert into kunden values(15,'Klaus','Kunstmann','Berliner Tor 11',20099,'Hamburg');
insert into kunden values(16,'Julia','J?rgens','Stadtbr?cke 7',21680,'Stade');
insert into kunden values(17,'Andreas','Schmitt','Berstrasse 7a',21680,'Stade');
insert into kunden values(18,'Andreas','Bremer','Holtenauer Allee 4',24123,'Kiel');
insert into kunden values(19,'Klaus','Abraham','Schloss 56',24123,'Kiel');
insert into kunden values(20,'Katharina','Klein','Laboer Landweg 145',24123,'Kiel');


CREATE TABLE Verk?ufer (
  Name varchar(50) not null,
  Filiale varchar(3) not null,
  Geburtstag date not null,
  Wohnort varchar(50) not null,
  CONSTRAINT Verk?ufer_Name_PK PRIMARY KEY (Name)
  );
  
  CREATE TABLE BonDaten (
  id number(10) not null,
  Filiale varchar2(3) not null,
  Datum DATE not null,
  Uhrzeit TIMESTAMP not null,
  Artikel number(10),
  Anzahl number(4),
  Preis decimal(10,2),
  Verk?ufer varchar2(50) not null,
  Kunde number(10),
  CONSTRAINT BonDaten_Filiale_FK FOREIGN KEY (Filiale) REFERENCES Gesch?ft(Id),
  CONSTRAINT BonDaten_Artikel_FK FOREIGN KEY (Artikel) REFERENCES Artikel(Id),
  CONSTRAINT BonDaten_Verk?ufer_FK FOREIGN KEY (Verk?ufer) REFERENCES Verk?ufer(Name),
  CONSTRAINT BonDaten_Kunde_FK FOREIGN KEY (Kunde) REFERENCES Kunden(Id),
  CONSTRAINT BonDaten_PK PRIMARY KEY (id)
);

CREATE TRIGGER bondaten_before_insert_update
BEFORE INSERT
   ON BONDATEN
   FOR EACH ROW

DECLARE

BEGIN
   if :new.Kunde = 0 then :new.Kunde := null; end if;
   if :new.Kunde = 1 then :new.Kunde := null; end if;
   
END;