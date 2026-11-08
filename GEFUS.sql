create schema Gefus;

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