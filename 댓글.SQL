CREATE TABLE ORACLE.RIVIEW(
pid VARCHAR(100) ,
bnum INTEGER,
id VARCHAR(100) ,
content VARCHAR(2000) NOT NULL,
bdate TIMESTAMP(6) ,
parents VARCHAR(100) ,
depth INTEGER ,
border INTEGER 
);

drop table RIVIEW;

select * from RIVIEW;.

 SELECT NVL(MAX(bnum),0)+1 FROM RIVIEW;