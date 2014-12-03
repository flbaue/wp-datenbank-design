create or replace procedure migrate_geschäftspartener

IS
  cursor c_kunden is
    select * from KUNDEN;
    
  cursor c_lieferanten is
    select * from LIEFERANTEN;

  kunden_row KUNDEN%ROWTYPE;
  lieferanten_row LIEFERANTEN%ROWTYPE;

  id number(10);
  name varchar2(50 BYTE);
  straße varchar2(50 BYTE);
  plz varchar2(50 BYTE);
  stadt varchar2(50 BYTE);
  email varchar2(50 BYTE);
  
  g_id number(10);
  
BEGIN
  g_id := 0;

  open c_kunden;
  loop
    fetch c_kunden into kunden_row;
    exit when c_kunden%NOTFOUND;
  
    id := kunden_row.ID;
    name := kunden_row.NAME;
    straße := kunden_row.STRAßE;
    plz := kunden_row.PLZ;
    stadt := kunden_row.STADT;
    email := kunden_row.EMAIL;
    
    g_id := g_id + 1;
    
    insert into GESCHÄFTSPARTNER values (g_id, name, straße, plz, stadt, email);
    /*DBMS_OUTPUT.PUT_LINE('update KUNDEN set GESCHÄFTSPARTNER_ID = ' || TO_CHAR(g_id) || ' where KUNDEN.ID = ' || TO_CHAR(id));*/
    update KUNDEN set GESCHÄFTSPARTNER_ID = g_id where KUNDEN.ID = id;commit;
  end loop;
  close c_kunden;
  
  open c_lieferanten;
  loop
    fetch c_lieferanten into lieferanten_row;
    exit when c_lieferanten%NOTFOUND;
  
    id := lieferanten_row.ID;
    name := lieferanten_row.NAME;
    straße := lieferanten_row.STRAßE;
    plz := lieferanten_row.PLZ;
    stadt := lieferanten_row.STADT;
    email := lieferanten_row.EMAIL;
    
    g_id := g_id + 1;
    insert into GESCHÄFTSPARTNER values (g_id, name, straße, plz, stadt, email);
    update LIEFERANTEN set GESCHÄFTSPARTNER_ID = g_id where LIEFERANTEN.ID = id;commit;
  end loop;
  close c_lieferanten;

END;