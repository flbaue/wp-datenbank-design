select STADT from GESCHÄFTSPARTNER, KUNDEN, BONDATEN
where GESCHÄFTSPARTNER.ID = KUNDEN.GESCHÄFTSPARTNER_ID 
and KUNDEN.ID = BONDATEN.KUNDE
and BONDATEN.DATUM = '02.09.12';