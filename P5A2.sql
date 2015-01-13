alter table kunden
add(geo sdo_Geometry); 

alter table geschäfte
add(geo sdo_Geometry);

select * from MDSYS.user_sdo_geom_metadata;

insert into MDSYS.user_sdo_geom_metadata
values('kunden', 'geo', SDO_DIM_ARRAY(SDO_DIM_ELEMENT('länge', -180, 180, 0.005), SDO_DIM_ELEMENT('breite', -90, 90, 0.005)), 1N);

insert into MDSYS.user_sdo_geom_metadata
values('geschäfte', 'geo', SDO_DIM_ARRAY(SDO_DIM_ELEMENT('länge', -180, 180, 0.005), SDO_DIM_ELEMENT('breite', -90, 90, 0.005)), 1N);

update MDSYS.user_sdo_geom_metadata
set SRID = 8307
where column_name = 'GEO';

update kunden k
set k.geo.sdo_srid = 8307;

select t.geo.sdo_srid from kunden t; 
select t.lokation.sdo_srid from world_sample.kunden t; 
select srid from user_sdo_geom_metadata where table_name='KUNDEN' and column_name='GEO' ;

CREATE INDEX KUNDEN_GEO_INDEX ON KUNDEN (GEO)
INDEXTYPE IS MDSYS.SPATIAL_INDEX;

CREATE INDEX GESCHÄFTE_GEO_INDEX ON GESCHÄFTE (GEO)
INDEXTYPE IS MDSYS.SPATIAL_INDEX;

select lokation from world_sample.kunden where id = 1;

update kunden k1
set geo = (select lokation from world_sample.kunden k2 where k1.id = k2.id);

update geschäfte k1
set geo = (select lokation from world_sample.kunden k2 where k2.id = 1)
where k1.id = 'A';

SELECT k.id kunde, g.id geschäft, SDO_GEOM.SDO_DISTANCE(k.geo, g.geo, 0.005) distanz
FROM kunden k, geschäfte g
order by k.id;

SELECT k.id kunde, min(SDO_GEOM.SDO_DISTANCE(k.geo, g.geo, 0.005)) distanz
FROM kunden k, geschäfte g
group by k.id
order by k.id;


WITH
   min_distanc AS 
      ( SELECT k.id kunde_m, min(SDO_GEOM.SDO_DISTANCE(k.geo, g.geo, 0.005)) distanz_m
        FROM kunden k, geschäfte g
        group by k.id order by k.id ),
   distances AS 
      ( SELECT k.id kunde_d, g.id geschäft, SDO_GEOM.SDO_DISTANCE(k.geo, g.geo, 0.005) distanz_d
        FROM kunden k, geschäfte g
        order by k.id )
SELECT
   kunde_m kunde, distanz_m distanz, geschäft
FROM
   min_distanc,
   distances
where
   distanz_m = distanz_d;
