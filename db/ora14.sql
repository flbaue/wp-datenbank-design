CREATE TABLE Kunden (
  Id number(10) not null,
  Vorname varchar2(50) not null,
  Nachname varchar2(50) not null,
  Straﬂe varchar2(50) not null,
  PLZ varchar2(15) not null,
  Stadt varchar2(50) not null,
  CONSTRAINT Kunden_PK PRIMARY KEY (Id)
);

CREATE TABLE Verk‰ufer (
  Name varchar2(50) not null,
  Filiale varchar2(3) not null,
  Geburtstag varchar2(50) not null,
  Wohnort varchar2(50) not null,
  CONSTRAINT Verk‰ufer_PK PRIMARY KEY (Name)
);

 CREATE TABLE Gesch‰ft (
  Id varchar2(3) not null,
  Straﬂe varchar2(50) not null,
  PLZ varchar2(15) not null,
  Stadt varchar2(50) not null,
  CONSTRAINT Gesch‰ft_PK PRIMARY KEY (Id)  
);

CREATE TABLE ArtikelGruppe (
  Id varchar2(3) not null,
  Name varchar2(50) not null,
  CONSTRAINT ArtikelGruppe_PK PRIMARY KEY (Id)
);

CREATE TABLE Artikel (
  Id number(10) not null,
  Name varchar2(50) not null,
  ArtikelGruppe varchar2(3),
  CONSTRAINT Artikel_PK PRIMARY KEY (Id),
  CONSTRAINT Artikel_FK FOREIGN KEY (ArtikelGruppe) REFERENCES ArtikelGruppe(Id)
);

CREATE TABLE BonDaten (
  id number(10) not null,
  Filiale varchar2(3) not null,
  Datum DATE not null,
  Uhrzeit TIMESTAMP not null,
  Artikel number(10),
  Anzahl number(4),
  Preis number(10,2),
  Verk‰ufer varchar2(50) not null,
  Kunde number(10),
  CONSTRAINT BonDaten_Filiale_FK FOREIGN KEY (Filiale) REFERENCES Gesch‰ft(Id),
  CONSTRAINT BonDaten_Artikel_FK FOREIGN KEY (Artikel) REFERENCES Artikel(Id),
  CONSTRAINT BonDaten_Verk‰ufer_FK FOREIGN KEY (Verk‰ufer) REFERENCES Verk‰ufer(Id),
  CONSTRAINT BonDaten_Kunde_FK FOREIGN KEY (Kunde) REFERENCES Kunden(Id)
  CONSTRAINT BonDaten_PK PRIMARY KEY (id)
);