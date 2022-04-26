
-- -----------------------------------------------------------------------------
--             G�n�ration d'une base de donn�es pour
--                           PostgreSQL
--                        
-- -----------------------------------------------------------------------------
--      Nom de la base : hhbdirect
--      Projet : HHB-DIRECT
--      Auteur : Stella
--      Version:1
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
--       CREATION DE LA BASE 
-- -----------------------------------------------------------------------------

CREATE DATABASE hhbdirect;

-- -----------------------------------------------------------------------------
--       TABLE : TYPE_COMPTE
-- -----------------------------------------------------------------------------

CREATE TABLE TYPE_COMPTE
   (
    ID_TYPE smallint NOT NULL  ,
    DESIGNATION character varying(50) NULL  
,   CONSTRAINT PK_TYPE_COMPTE PRIMARY KEY (ID_TYPE)
   );

-- -----------------------------------------------------------------------------
--       TABLE : CARTE_BANCAIRE
-- -----------------------------------------------------------------------------

CREATE TABLE CARTE_BANCAIRE
   (
    NUM_CB bigint NOT NULL  ,
    NUM_CLIENT integer NOT NULL  ,
    NUM_COMPTE integer NOT NULL  ,
    CODE_SECURITE character varying(3) NULL  ,
    DATE_DELIVRANCE date NULL  ,
    ORGANISME character varying(80) NULL  ,
    ACTIVATION BOOLEAN NULL  
,   CONSTRAINT PK_CARTE_BANCAIRE PRIMARY KEY (NUM_CB)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE CARTE_BANCAIRE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_CARTE_BANCAIRE_CLIENT
     ON CARTE_BANCAIRE (NUM_CLIENT)
    ;

CREATE  INDEX I_FK_CARTE_BANCAIRE_COMPTE
     ON CARTE_BANCAIRE (NUM_COMPTE)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : OPERATION - modification de la table operation  (ex2 : contraintes sur les opérations)
-- -----------------------------------------------------------------------------

CREATE TABLE OPERATION
   (
    ID_OPERATION bigint NOT NULL  ,
    NUM_COMPTE integer NOT NULL  ,
    DATE date NOT NULL  ,
    NUM_COMPTE_VERS integer NULL  ,
    NUM_CB integer NULL  ,
    NUM_CHEQUIER integer NULL,
    DESIGNATION character varying(50) NULL  ,
    TYPE_OPERATION character varying(20) NULL  ,
    MONTANT integer NULL  
,   CONSTRAINT PK_OPERATION PRIMARY KEY (ID_OPERATION),
     CONSTRAINT CK_PARTITION CHECK ( NUM_CB is NULL and NUM_CHEQUIER is NOT NULL OR NUM_CB is NOT NULL and NUM_CHEQUIER is NULL )
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE OPERATION
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_OPERATION_COMPTE
     ON OPERATION (NUM_COMPTE)
    ;

CREATE  INDEX I_FK_OPERATION_DATE
     ON OPERATION (DATE)
    ;

CREATE  INDEX I_FK_OPERATION_COMPTE1
     ON OPERATION (NUM_COMPTE_VERS)
    ;

CREATE  INDEX I_FK_OPERATION_CARTE_BANCAIRE
     ON OPERATION (NUM_CB)
    ;
CREATE  INDEX I_FK_OPERATION_CHEQUIER
     ON OPERATION (NUM_CHEQUIER)
    ;


-- -----------------------------------------------------------------------------
--       TABLE : DATE  
-- -----------------------------------------------------------------------------

CREATE TABLE DATE
   (
    DATE date NOT NULL  
,   CONSTRAINT PK_DATE PRIMARY KEY (DATE)
   );

-- -----------------------------------------------------------------------------
--       TABLE : CLIENT
-- -----------------------------------------------------------------------------

CREATE TABLE CLIENT
   (
    NUM_CLIENT integer NOT NULL  ,
    NOM_CLIENT character varying(30) NULL  ,
    PRENOM_CLIENT character varying(30) NULL  ,
    ADRESSE_CLIENT character varying(192) NULL  ,
    IDENTIFIANT_INTERNET character varying(30) NULL  ,
    MDP_INTERNET character varying(30) NULL  
,   CONSTRAINT PK_CLIENT PRIMARY KEY (NUM_CLIENT)
   );

-- -----------------------------------------------------------------------------
--       TABLE : CHEQUIER
-- -----------------------------------------------------------------------------

CREATE TABLE CHEQUIER
   (
    NUM_CHEQUIER integer NOT NULL  ,
    NUM_COMPTE integer NOT NULL  ,

    DATE_DELIVRANCE date NULL  ,
    NUM_PREMIER_CHEQUE integer NULL  ,
    NUM_DERNIER_CHEQUE integer NULL  ,
    ACTIVATION BOOLEAN NULL  ,
    ORDRE BOOLEAN NULL  ,
    ORDRE_MOTIF character varying(30) NULL  
,   CONSTRAINT PK_CHEQUIER PRIMARY KEY (NUM_CHEQUIER)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE CHEQUIER
-- -----------------------------------------------------------------------------


CREATE  INDEX I_FK_CHEQUIER_COMPTE
     ON CHEQUIER (NUM_COMPTE)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : COMPTE ex3: contrainte exlusivité
-- -----------------------------------------------------------------------------

CREATE TABLE COMPTE
   (
    NUM_COMPTE integer NOT NULL  ,
    DATE_FERMER date NULL  ,
    ID_TYPE smallint NOT NULL  ,
    DATE_OUVRIR date NOT NULL  ,
    SOLDE char(32) NULL  ,  
     CONSTRAINT PK_COMPTE PRIMARY KEY (NUM_COMPTE),
     CONSTRAINT CK_EXCLUSIVITE CHECK (
                                        (DATE_FERMER is NULL and DATE_OUVRIR is NOT NULL)
                                   OR   (DATE_FERMER is NOT NULL and DATE_OUVRIR is NULL)
                                   OR   (DATE_FERMER is NULL and DATE_OUVRIR is NULL)
     )
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE COMPTE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_COMPTE_DATE
     ON COMPTE (DATE_FERMER)
    ;

CREATE  INDEX I_FK_COMPTE_TYPE_COMPTE
     ON COMPTE (ID_TYPE)
    ;

CREATE  INDEX I_FK_COMPTE_DATE1
     ON COMPTE (DATE_OUVRIR)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : AGENCE
-- -----------------------------------------------------------------------------

CREATE TABLE AGENCE
   (
    NUM_AGENCE integer NOT NULL  ,
    NOM_AGENCE character varying(50) NULL  ,
    ADRESSE_AGENCE character varying(192) NULL  ,
    TEL_AGENCE character varying(10) NULL  
,   CONSTRAINT PK_AGENCE PRIMARY KEY (NUM_AGENCE)
   );

-- -----------------------------------------------------------------------------
--       TABLE : CHEQUE
-- -----------------------------------------------------------------------------

CREATE TABLE CHEQUE
   (
    NUM_CHEQUE integer NOT NULL  ,
    NUM_CHEQUIER integer NOT NULL  ,
    DATE_EMISSION date NULL  
,   CONSTRAINT PK_CHEQUE PRIMARY KEY (NUM_CHEQUE)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE CHEQUE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_CHEQUE_CHEQUIER
     ON CHEQUE (NUM_CHEQUIER)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : DEPENDRE
-- -----------------------------------------------------------------------------

CREATE TABLE DEPENDRE
   (
    NUM_AGENCE integer NOT NULL  ,
    NUM_CLIENT integer NOT NULL  ,
    DATE date NOT NULL  
,   CONSTRAINT PK_DEPENDRE PRIMARY KEY (NUM_AGENCE, NUM_CLIENT, DATE)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE DEPENDRE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_DEPENDRE_AGENCE
     ON DEPENDRE (NUM_AGENCE)
    ;

CREATE  INDEX I_FK_DEPENDRE_CLIENT
     ON DEPENDRE (NUM_CLIENT)
    ;

CREATE  INDEX I_FK_DEPENDRE_DATE
     ON DEPENDRE (DATE)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : REMUNERER
-- -----------------------------------------------------------------------------

CREATE TABLE REMUNERER
   (
    ID_TYPE smallint NOT NULL  ,
    DATE_DE date NOT NULL  ,
    DATE_A date NOT NULL  ,
    TAUX_INTERET integer NULL  
,   CONSTRAINT PK_REMUNERER PRIMARY KEY (ID_TYPE, DATE_DE, DATE_A)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE REMUNERER
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_REMUNERER_TYPE_COMPTE
     ON REMUNERER (ID_TYPE)
    ;

CREATE  INDEX I_FK_REMUNERER_DATE
     ON REMUNERER (DATE_DE)
    ;

CREATE  INDEX I_FK_REMUNERER_DATE1
     ON REMUNERER (DATE_A)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : POSSEDER
-- -----------------------------------------------------------------------------

CREATE TABLE POSSEDER
   (
    NUM_CLIENT integer NOT NULL  ,
    NUM_COMPTE integer NOT NULL  
,   CONSTRAINT PK_POSSEDER PRIMARY KEY (NUM_CLIENT, NUM_COMPTE)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE POSSEDER
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_POSSEDER_CLIENT
     ON POSSEDER (NUM_CLIENT)
    ;

CREATE  INDEX I_FK_POSSEDER_COMPTE
     ON POSSEDER (NUM_COMPTE)
    ;


-- -----------------------------------------------------------------------------
--       CREATION DES REFERENCES DE TABLE 20
-- -----------------------------------------------------------------------------


ALTER TABLE CARTE_BANCAIRE ADD 
     CONSTRAINT FK_CARTE_BANCAIRE_CLIENT
          FOREIGN KEY (NUM_CLIENT)
               REFERENCES CLIENT (NUM_CLIENT);

ALTER TABLE CARTE_BANCAIRE ADD 
     CONSTRAINT FK_CARTE_BANCAIRE_COMPTE
          FOREIGN KEY (NUM_COMPTE)
               REFERENCES COMPTE (NUM_COMPTE);
 -- -----------------------------------------------------------------------------              

ALTER TABLE OPERATION ADD 
     CONSTRAINT FK_OPERATION_COMPTE
          FOREIGN KEY (NUM_COMPTE)
               REFERENCES COMPTE (NUM_COMPTE);

ALTER TABLE OPERATION ADD 
     CONSTRAINT FK_OPERATION_DATE
          FOREIGN KEY (DATE)
               REFERENCES DATE (DATE);

ALTER TABLE OPERATION ADD 
     CONSTRAINT FK_OPERATION_COMPTE1
          FOREIGN KEY (NUM_COMPTE_VERS)
               REFERENCES COMPTE (NUM_COMPTE);

ALTER TABLE OPERATION ADD 
     CONSTRAINT FK_OPERATION_CARTE_BANCAIRE
          FOREIGN KEY (NUM_CB)

               REFERENCES CARTE_BANCAIRE (NUM_CB);

-- -----------------------------------------------------------------------------
--       ex 2: ajout reference operation
-- -----------------------------------------------------------------------------
ALTER TABLE OPERATION ADD 
     CONSTRAINT FK_OPERATION_CHEQUIER
          FOREIGN KEY (NUM_CHEQUIER)

               REFERENCES CHEQUIER (NUM_CHEQUIER);
-----------------------------------------------------------------------------   

ALTER TABLE CHEQUIER ADD 
     CONSTRAINT FK_CHEQUIER_COMPTE
          FOREIGN KEY (NUM_COMPTE)
               REFERENCES COMPTE (NUM_COMPTE);
 -- -----------------------------------------------------------------------------              

ALTER TABLE COMPTE ADD 
     CONSTRAINT FK_COMPTE_DATE
          FOREIGN KEY (DATE_FERMER)
               REFERENCES DATE (DATE);

ALTER TABLE COMPTE ADD 
     CONSTRAINT FK_COMPTE_TYPE_COMPTE
          FOREIGN KEY (ID_TYPE)
               REFERENCES TYPE_COMPTE (ID_TYPE);

ALTER TABLE COMPTE ADD 
     CONSTRAINT FK_COMPTE_DATE1
          FOREIGN KEY (DATE_OUVRIR)
               REFERENCES DATE (DATE);
-- -----------------------------------------------------------------------------
ALTER TABLE CHEQUE ADD 
     CONSTRAINT FK_CHEQUE_CHEQUIER
          FOREIGN KEY (NUM_CHEQUIER)
               REFERENCES CHEQUIER (NUM_CHEQUIER);
-- -----------------------------------------------------------------------------
ALTER TABLE DEPENDRE ADD 
     CONSTRAINT FK_DEPENDRE_AGENCE
          FOREIGN KEY (NUM_AGENCE)
               REFERENCES AGENCE (NUM_AGENCE);

ALTER TABLE DEPENDRE ADD 
     CONSTRAINT FK_DEPENDRE_CLIENT
          FOREIGN KEY (NUM_CLIENT)
               REFERENCES CLIENT (NUM_CLIENT);

ALTER TABLE DEPENDRE ADD 
     CONSTRAINT FK_DEPENDRE_DATE
          FOREIGN KEY (DATE)
               REFERENCES DATE (DATE);
-- -----------------------------------------------------------------------------
ALTER TABLE REMUNERER ADD 
     CONSTRAINT FK_REMUNERER_TYPE_COMPTE
          FOREIGN KEY (ID_TYPE)
               REFERENCES TYPE_COMPTE (ID_TYPE);

ALTER TABLE REMUNERER ADD 
     CONSTRAINT FK_REMUNERER_DATE
          FOREIGN KEY (DATE_DE)
               REFERENCES DATE (DATE);

ALTER TABLE REMUNERER ADD 
     CONSTRAINT FK_REMUNERER_DATE1
          FOREIGN KEY (DATE_A)
               REFERENCES DATE (DATE);
-- -----------------------------------------------------------------------------
ALTER TABLE POSSEDER ADD 
     CONSTRAINT FK_POSSEDER_CLIENT
          FOREIGN KEY (NUM_CLIENT)
               REFERENCES CLIENT (NUM_CLIENT);

ALTER TABLE POSSEDER ADD 
     CONSTRAINT FK_POSSEDER_COMPTE
          FOREIGN KEY (NUM_COMPTE)
               REFERENCES COMPTE (NUM_COMPTE);


-- -----------------------------------------------------------------------------
--                FIN DE GENERATION
-- -----------------------------------------------------------------------------