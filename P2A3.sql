/*
ALTER TABLE ARTIKEL
  ADD (BESTAND NUMBER(10));

CREATE TABLE LOGS (
  id number(10) not null,
  zeit TIMESTAMP(6) not null,
  text VARCHAR2(250) not null,
  CONSTRAINT LOGS_PL PRIMARY KEY (id)
);

CREATE SEQUENCE LOGS_PK
  MINVALUE 0
  MAXVALUE 100000000
  START WITH 0
  INCREMENT BY 1
  CACHE 20;

*/
CREATE TRIGGER UPDATE_BESTAND
BEFORE INSERT OR UPDATE ON BONDATEN
FOR EACH ROW
  
  DECLARE
  artikel_bestand number(10);
  bestell_text VARCHAR2(250);
  
  BEGIN
  
    SELECT BESTAND INTO artikel_bestand
    FROM ARTIKEL
    WHERE :new.ARTIKEL = ARTIKEL.ID;
    
    artikel_bestand := artikel_bestand - 1;
    
    UPDATE ARTIKEL
    SET BESTAND = artikel_bestand
    WHERE ARTIKEL.ID = :new.ARTIKEL;
  
    bestell_text := 'Bestellung für Artikel: ' + :new.ARTIKEL + ' Menge: 50';
  
    if(artikel_bestand <= 10) THEN
      UTL_MAIL.send(sender => 'florian.bauer@haw-hamburg.de',
            recipients => 'florian.bauer@posteo.de',
               subject => 'WP-DD Meldebestand ist erreicht',
               message => bestell_text,
             mime_type => 'text; charset=us-ascii');
    
      INSERT INTO LOGS
      (id,zeit,text) values (LOGS_PK.NEXTVAL, SYSDATE, bestell_text);
    END IF;
END;
/
