alter table BONDATEN add
UMSATZ generated always as (Preis * Anzahl);

select artikel, umsatz
from bondaten;