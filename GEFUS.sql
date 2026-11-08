--criando o banco de dados
create database GEFUS;

--criando do schema
create schema Gefus;

--criando as tabelas
create table Gefus.orgao_gestor (
    Idgestor int primary key,
    Nome_Gestor varchar (150) not null,
    sigla varchar(20),
    Esfera varchar(50),
    Status varchar(20)
);

create table Gefus.fundo (
	Idfundo int primary key,
	Nome_Fundo varchar (150) not null,
	Tipo_Fundo varchar (100),
	Idgestor int not null,
	Status varchar(20),
constraint fundo_gestor
	foreign key (Idgestor)
	references Gefus.orgao_gestor(Idgestor)
);

create table gefus.programa (
    Idprograma int primary key,
	Nome_Programa varchar(200) not null,
	Objetivo varchar(500),
    Publico_Alvo varchar(200),
    Status varchar(20)
);

create table gefus.modalidade (
    Idmodalidade int primary key,
    Nome_Modalidade varchar (100),
    Categoria varchar (100)
);

create table gefus.fonte_recurso (
    Idfonterecurso int primary key,
    Nome_Fonte varchar (100),
    Origem varchar (100),
    Tipo_Recurso varchar (50)
);

create table gefus.municipio (
    Idmunicipio int primary key,
    Municipio varchar (100),
    UF varchar (2),
    Regiao varchar (30)
);

create table gefus.status (
    Idstatus int primary key,
    Descricao_Status varchar (50)
);

create table gefus.tempo (
    Iddata int primary key,
    Data_Calendario date not null,
    Dia int,
    Mes int,
    Ano int,
    Trimestre int,
    Semestre int
);

create table gefus.movimentacao_financeira (
    Idmovimentacao bigint primary key,
    Iddata int not null,
    Idfundo int not null,
    Idfonterecurso int not null,
    Receita decimal (18,2),
    Aporte decimal (18,2),
    Pagamento decimal (18,2),
    Saldo decimal (18,2),
constraint fk_mov_data
    foreign key (Iddata)
    references gefus.tempo (Iddata),
constraint fk_mov_fundo
    foreign key (Idfundo)
    references gefus.fundo (Idfundo),
constraint fk_mov_fonte
    foreign key (Idfonterecurso)
    references gefus.fonte_recurso (Idfonterecurso)
);

create table gefus.contrato (
    Idcontrato bigint primary key,
    Iddata int not null,
	Idfundo int not null,
    Idprograma int not null,
    Idmodalidade int not null,
    Idmunicipio int not null,
    Idstatus int not null,
    Valor_Contrato decimal (18,2),
    Valor_Execucao decimal (18,2),
constraint fk_contr_fundo
     foreign key (Idfundo)
     references gefus.fundo (Idfundo),
constraint fk_contr_tempo
	foreign key (Iddata)
	references gefus.tempo (Iddata),
constraint fk_contr_programa
     foreign key (Idprograma)
     references gefus.programa (Idprograma),
constraint fk_contr_modalidade
     foreign key (Idmodalidade)
     references gefus.modalidade (Idmodalidade),
constraint fk_contr_municipio
     foreign key (Idmunicipio)
     references gefus.municipio (Idmunicipio),
constraint fk_contr_status
     foreign key (Idstatus)
     references gefus.status (Idstatus)
);

create table gefus.prestacao_contas (
    Idprestacao bigint primary key,
	Iddata int not null,
    Idfundo int not null,
    Idprograma int not null,
    Idstatus int not null,
    Valor_prestacao decimal (18,2),
constraint fk_prest_data
     foreign key (Iddata)
     references gefus.tempo (Iddata),
constraint fk_prest_fundo
     foreign key (Idfundo)
     references gefus.fundo (Idfundo),
constraint fk_prest_programa
     foreign key (Idprograma)
     references gefus.programa (Idprograma),
constraint fk_prest_status
     foreign key (Idstatus)
     references gefus.status (Idstatus)
);

create table gefus.conciliacao (
    Idconciliacao bigint primary key,
    Idfundo int not null,
    Iddata int not null,
    Valor_Conciliacao decimal (18,2),
    Quantidade_Lancamentos int,
    Quantidade_Divergencias int,
 CONSTRAINT fk_conc_fundo
     foreign key (Idfundo)
     references gefus.fundo (Idfundo),
constraint fk_conc_data
     foreign key (Iddata)
     references gefus.tempo (Iddata)
);

--inserindo dados nas tabelas
insert into gefus.orgao_gestor (Idgestor, Nome_Gestor, Sigla, Esfera, Status)
values
(1,'Ministério das Cidades','MCID','Federal','Ativo'),
(2,'Ministério da Educação','MEC','Federal','Ativo'),
(3,'Ministério da Fazenda','MF','Federal','Ativo'),
(4,'Ministério dos Transportes','MT','Federal','Ativo'),
(5,'Ministério do Desenvolvimento Regional','MDR','Federal','Ativo');

insert into gefus.fundo (Idfundo, Nome_Fundo, Tipo_Fundo, Idgestor, Status)
values
(1,'FAR','Habitação',1,'Ativo'),
(2,'FDS','Habitação',1,'Ativo'),
(3,'FNHIS','Habitação',5,'Ativo'),
(4,'FUNCAFÉ','Desenvolvimento',3,'Ativo'),
(5,'FNDE Educação','Educação',2,'Ativo');

insert into gefus.programa (Idprograma, Nome_Programa, Objetivo, Publico_Alvo, Status)
values
(1,'Minha Casa Minha Vida','Produção habitacional','Famílias baixa renda','Ativo'),
(2,'Urbanização de Favelas','Infraestrutura urbana','Municípios','Ativo'),
(3,'Mobilidade Urbana','Melhoria do transporte','População urbana','Ativo'),
(4,'Construção de Creches','Expansão educacional','Estados e Municípios','Ativo'),
(5,'Modernização Agrícola','Fomento produtivo','Produtores rurais','Ativo');

insert into gefus.modalidade (Idmodalidade, Nome_Modalidade, Categoria)
values
(1,'Habitação Urbana','Habitação'),
(2,'Habitação Rural','Habitação'),
(3,'Infraestrutura Urbana','Infraestrutura'),
(4,'Educação Básica','Educação'),
(5,'Crédito Agrícola','Desenvolvimento');

insert into gefus.fonte_recurso (Idfonterecurso, Nome_Fonte, Origem, Tipo_Recurso)
values
(1,'FGTS','FGTS','Fundo'),
(2,'Tesouro Nacional','União','Orçamentário'),
(3,'FAT','Governo Federal','Fundo'),
(4,'Recursos Próprios','CAIXA','Próprio'),
(5,'BID','Internacional','Financiamento');

insert into gefus.municipio (Idmunicipio, Municipio, UF, Regiao)
values
(1,'Campinas','SP','Sudeste'),
(2,'Goiânia','GO','Centro-Oeste'),
(3,'Salvador','BA','Nordeste'),
(4,'Curitiba','PR','Sul'),
(5,'Manaus','AM','Norte');

insert into gefus.status (Idstatus, Descricao_Status)
values
(1,'Em Execução'),
(2,'Concluído'),
(3,'Atrasado'),
(4,'Pendente'),
(5,'Aprovado');

insert into gefus.tempo (Iddata, Data_Calendario, Dia, Mes, Ano, Trimestre, Semestre)
values
(20260101,'2026-01-01',1,1,2026,1,1),
(20260201,'2026-02-01',1,2,2026,1,1),
(20260301,'2026-03-01',1,3,2026,1,1),
(20260401,'2026-04-01',1,4,2026,2,1),

insert into gefus.movimentacao_financeira (Idmovimentacao, Iddata, Idfundo, Idfonterecurso,
 Receita, Aporte, Pagamento, Saldo)
values
(1,20260101,1,1,23000000,40000000,37000000,321000000),
(2,20260201,2,2,8500000,15000000,12000000,118000000),
(3,20260301,3,2,4200000,7000000,6500000,56000000),
(4,20260401,4,3,12000000,18000000,15000000,89000000),
(5,20260501,5,4,9600000,14000000,12500000,68000000);

insert into gefus.contrato (Idcontrato, Iddata, Idfundo, Idprograma,
 Idmodalidade, Idmunicipio, Idstatus, Valor_Contrato, Valor_Execucao)
values
(1001,20260101,1,1,1,1,1,2500000,1800000),
(1002,20260201,2,2,1,2,3,1700000,800000),
(1003,20260301,3,1,2,3,1,3200000,2300000),
(1004,20260401,4,5,5,4,2,5400000,5400000),
(1005,20260501,5,4,4,5,1,2100000,1200000);

insert into gefus.prestacao_contas (Idprestacao, Iddata, Idfundo, Idprograma,
 Idstatus, Valor_prestacao)
values
(2001,20260101,1,1,5,25000000),
(2002,20260201,2,2,4,12000000),
(2003,20260301,3,1,5,7000000),
(2004,20260401,4,5,1,15000000),
(2005,20260501,5,4,4,8500000);

insert into gefus.conciliacao (Idconciliacao, Idfundo, Iddata,
 Valor_Conciliacao, Quantidade_Lancamentos, Quantidade_Divergencias)
values
(3001,1,20260101,38000000,1200,2),
(3002,2,20260201,14000000,820,1),
(3003,3,20260301,6900000,540,3),
(3004,4,20260401,17000000,750,0),
(3005,5,20260501,12800000,680,2);