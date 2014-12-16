
/*create or replace TYPE verkaufer_typ  AS object (
    name varchar2(50),
    geburtstag date,
    wohnort varchar2(50)
);

create or replace TYPE verkaufer_table_typ  AS table of verkaufer_typ;
*/
alter table GESCHÄFTE add (
verkaufer_nt verkaufer_table_typ)
nested table verkaufer_nt store as verkaufer_table;

update geschäfte 
set verkaufer_nt = cast(multiset(select Name, geburtstag, wohnort from verkäufer where filiale = 'A') as verkaufer_table_typ)
where id = 'A';

update geschäfte 
set verkaufer_nt = cast(multiset(select Name, geburtstag, wohnort from verkäufer where filiale = 'B') as verkaufer_table_typ)
where id = 'B';

select nt.name, nt.geburtstag, nt.wohnort
from geschäfte t, table(t.verkaufer_nt) nt
where t.id = 'B';

select t.id
from geschäfte t, table(t.verkaufer_nt) nt
where nt.name = 'Felix';



