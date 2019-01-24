create table contactos(
  id_u number(20),
  contacto number(20),
constraint contactos_pk primary key (id_u,contacto)
);

create table ser_visible(
  id_u number(20),
  contacto number(20),
  pid number(20),
  constraint ser_visible_pk primary key (id_u,contacto,pid)
);

create table usuarios(
  id_u number(20)
    constraint usuarios_pk primary key,
  usuario varchar2(30)
    constraint usuarios_uk1 unique
    constraint usuarios_nn1 not null,
  e_mail varchar2(60)
    constraint usuarios_uk2 unique
    constraint usuarios_nn2 not null,
  nombre  varchar2(30)
    constraint usuarios_nn3 not null ,
  apellido1 varchar2(30)
    constraint usuarios_nn4 not null ,
  apellido2 varchar2(30),
  passw varchar2(100)
    constraint  usuarios_nn5 not null
 );

create table post(
  id_u number(20)
    constraint post_nn2 not null,
  pid number(20)
    constraint post_pk primary key ,
  texto varchar2(1000)
   constraint  post_nn1 not null ,
  pid_rel number(20)
    constraint post_fk2 references  post,
  publicacion date
  constraint  post_nn3 not null,
  duración interval day to  second
   constraint post_nn4 not null
);



alter table ser_visible add constraint ser_vsible_fk2 foreign key  (pid) references post;
alter table ser_visible add constraint ser_visible_fk1 foreign key  (id_u,contacto) references contactos  ;
alter table contactos add constraint contactos_fk1 foreign key (id_u) references usuarios ;
alter table contactos add constraint contactos_fk2 foreign key (contacto) references usuarios on delete cascade;
alter table post add constraint post_fk1 foreign key (id_u) references usuarios on delete cascade;

alter table contactos add constraint contactos_ck1 check (id_u!=contacto);
alter table post add constraint post_ck check  (publicacion>=to_date('02/02/2017','dd/mm/yyyy'));

alter table post add constraint post_ck2 check (duración>interval '30' minute );

rename ser_visible to compartir;

alter table usuarios  rename constraint usuarios_pk to  SUPERCLAVE;
alter table post modify publicacion default SYSDATE;

alter table usuarios drop constraint usuarios_nn5;
alter table post add visible char(2) default 'SI';
 alter table post add constraint post_ck3 check (visible='SI' and visible='NO');

insert into usuarios (id_u,nombre,apellido1,apellido2,usuario,e_mail)
values ('1','Ramon', 'Garcia', 'Ortigal','ramongar', 'ramon@hotmail.com');

insert into usuarios (id_u,nombre,apellido1,usuario,e_mail)
values ('2','Lourdes', 'Atienza','lurdita', 'lurdita@bbc.co.uk');

insert into usuarios (id_u,nombre,apellido1,apellido2,usuario,e_mail)
values ('3','Marisol','jimenez', 'del Oso','marioso', 'marioso19@yahoo.com');

insert into usuarios (id_u,nombre,apellido1, apellido2,usuario,e_mail)
values ('4','francisco','serrano','calvo','sercal','sercal1980@gmail.com');

commit;

update usuarios set passw=12345;

update usuarios set e_mail='superlourdes@gmail.com' where 'lurdita@bbc.co.uk';

delete from usuarios where nombre='Ramon';