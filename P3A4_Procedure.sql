create or replace procedure insert_lieferant
(ansprechpartner in varchar2, name in varchar2, straße in varchar2, plz in varchar2, stadt in varchar2, email in varchar2, bewertung in varchar2)

IS
  g_id number(10);
  
BEGIN

  SELECT GESCHÄFTSPARTNER_ID_SEQ.NEXTVAL INTO g_id FROM SYS.DUAL;
  insert into GESCHÄFTSPARTNER column(ID, NAME, STRAßE, PLZ, STADT, EMAIL) values(g_id, name, straße, plz, stadt, email); 
  insert into LIEFERANTEN column(ANSPRECHPARTNER, BEWERTUNG, GESCHÄFTSPARTNER_ID) values(ansprechpartner, bewertung, g_id); 

END;
/