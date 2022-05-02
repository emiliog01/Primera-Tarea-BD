create table superhero (
superhero_name varchar (50) not null,
superhero_email varchar (100) not null
);

INSERT INTO emails.superhero
(superhero_name, superhero_email)
values
('Wanda Maximoff','wanda.maximoff@avengers.org'),
('Pietro Maximoff','pietro@mail.sokovia.ru'),
('Erik Lensherr','fuck_you_charles@brotherhood.of.evil.mutants.space'),
('Charles Xavier','i.am.secretely.filled.with.hubris@xavier-school-4-gifted-youngste.'),
('Anthony Edward Stark','iamironman@avengers.gov'),
('Steve Rogers','americas_ass@anti_avengers'),
('The Vision','vis@westview.sword.gov'),
('Clint Barton','bul@lse.ye'),
('Natasja Romanov','blackwidow@kgb.ru'),
('Thor','god_of_thunder-^_^@royalty.asgard.gov'),
('Logan','wolverine@cyclops_is_a_jerk.com'),
('Ororo Monroe','ororo@weather.co'),
('Scott Summers','o@x'),
('Nathan Summers','cable@xfact.or'),
('Groot','iamgroot@asgardiansofthegalaxyledbythor.quillsux'),
('Nebula','idonthaveelektras@complex.thanos'),
('Gamora','thefiercestwomaninthegalaxy@thanos.'),
('Rocket','shhhhhhhh@darknet.ru')
;

--contruir UN query que regrese emails inválidos

select * from superhero s where 
s.superhero_email like '%.' 
or s.superhero_email like 'a%' 
or s.superhero_email like 'g%' 
or s.superhero_email like'o%x';

--query para emails generales
select * from superhero s where 
s.superhero_email not like '%_@__%.__%'
and (s.superhero_email like '%.'or s.superhero_email like '%@'or s.superhero_email like '@%' 
or s.superhero_email like '%_@%_%' or s.superhero_email like '%_!^!_!^_%' escape '!');






