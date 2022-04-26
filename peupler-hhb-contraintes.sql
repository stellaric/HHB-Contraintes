
-- -----------------------------------------------------------------------------
--       TABLE : AGENCE
-- -----------------------------------------------------------------------------

INSERT INTO agence (num_agence, nom_agence, adresse_agence, tel_agence) VALUES (1, 'CAEN Centre', '13 Rue St Pierre, 14000 CAEN', '0233456789');
INSERT INTO agence (num_agence, nom_agence, adresse_agence, tel_agence) VALUES (3, 'Lannion', '2 bis Rue de Brelevenez, 22300 LANNION', '0232564345');
INSERT INTO agence (num_agence, nom_agence, adresse_agence, tel_agence) VALUES (2, 'Nogent sur Marne', '12 Bd de Strasbourg, 94230 Nogent sur Marne', '0145232356');
-- -----------------------------------------------------------------------------
--       TABLE : CLIENT
-- -----------------------------------------------------------------------------


INSERT INTO client (num_client, nom_client, prenom_client, adresse_client, identifiant_internet, mdp_internet) VALUES (1, 'DUPONT', 'Pierre', '5 Rue du Port, 22300 LANNION', 'Pdupont', 'Pdupont');
INSERT INTO client (num_client, nom_client, prenom_client, adresse_client, identifiant_internet, mdp_internet) VALUES (2, 'DUPONT', 'Annie', '5 Rue du Port, 22300 LANNION', 'Adupont', 'Adupont');
INSERT INTO client (num_client, nom_client, prenom_client, adresse_client, identifiant_internet, mdp_internet) VALUES (3, 'DELAVAL', 'Jean', '12 Bd de l''Orne, 14234 OUISTREHAM', 'Jdelaval', 'Jdelaval');
INSERT INTO client (num_client, nom_client, prenom_client, adresse_client, identifiant_internet, mdp_internet) VALUES (4, 'HANOT', 'Eric', '13 Avenue de Neuilly, 94230 NOGENT SUR MARNE', 'Ehanot', 'Ehanot');
INSERT INTO client (num_client, nom_client, prenom_client, adresse_client, identifiant_internet, mdp_internet) VALUES (5, 'LEVY', 'Sarah', '1 Rue Neuve, 14110 CONDE SUR NOIREAU', 'Slevy', 'Slevy');


-- -----------------------------------------------------------------------------
--       TABLE : DATE
-- -----------------------------------------------------------------------------


INSERT INTO date (date) VALUES ('2012-10-27');
INSERT INTO date (date) VALUES ('2012-11-01');
INSERT INTO date (date) VALUES ('2012-11-02');
INSERT INTO date (date) VALUES ('2012-11-03');
INSERT INTO date (date) VALUES ('2012-01-01');
INSERT INTO date (date) VALUES ('2012-12-31');

-- -----------------------------------------------------------------------------
--       TABLE : DEPENDRE
-- -----------------------------------------------------------------------------


INSERT INTO dependre (num_client, date, num_agence) VALUES (1, '2012-10-27', 3);
INSERT INTO dependre (num_client, date, num_agence) VALUES (3, '2012-11-01', 1);
INSERT INTO dependre (num_client, date, num_agence) VALUES (3, '2012-11-03', 2);
INSERT INTO dependre (num_client, date, num_agence) VALUES (2, '2012-11-02', 3);
INSERT INTO dependre (num_client, date, num_agence) VALUES (4, '2012-11-01', 2);
INSERT INTO dependre (num_client, date, num_agence) VALUES (5, '2012-11-02',1);





-- -----------------------------------------------------------------------------
--       TABLE : TYPE_COMPTE
-- -----------------------------------------------------------------------------

INSERT INTO type_compte (id_type, designation) VALUES (1, 'Compte Courant');
INSERT INTO type_compte (id_type, designation) VALUES (2, 'Livret A');


-- -----------------------------------------------------------------------------
--       TABLE : REMUNERER
-- -----------------------------------------------------------------------------


INSERT INTO remunerer (date_a, date_de, id_type, taux_interet) VALUES ('2012-11-01', '2012-01-01', 2, 2);
INSERT INTO remunerer (date_a, date_de, id_type, taux_interet) VALUES ('2012-12-31', '2012-11-02', 2, 4);

-- -----------------------------------------------------------------------------
--       TABLE : COMPTE
-- -----------------------------------------------------------------------------

INSERT INTO compte (id_type, num_compte, date_fermer, date_ouvrir, solde) VALUES (1, 1, NULL, '2012-10-27', 1000);
INSERT INTO compte (id_type, num_compte, date_fermer, date_ouvrir, solde) VALUES (2, 2, NULL, '2012-11-01', 2000);
INSERT INTO compte (id_type, num_compte, date_fermer, date_ouvrir, solde) VALUES (1, 3, NULL, '2012-11-02', 3400);
INSERT INTO compte (id_type, num_compte, date_fermer, date_ouvrir, solde) VALUES (1, 4, NULL, '2012-11-01', 4000);
INSERT INTO compte (id_type, num_compte, date_fermer, date_ouvrir, solde) VALUES (1, 5, NULL, '2012-10-27', -1200);

-- -----------------------------------------------------------------------------
--       TABLE : POSSEDER
-- -----------------------------------------------------------------------------

INSERT INTO posseder (num_client, num_compte) VALUES (1, 1);
INSERT INTO posseder (num_client,num_compte) VALUES (2,1);
INSERT INTO posseder (num_client,num_compte) VALUES (3,3);
INSERT INTO posseder (num_client, num_compte) VALUES (4,4);
INSERT INTO posseder (num_client, num_compte) VALUES (5,5);



-- -----------------------------------------------------------------------------
--       TABLE : CARTE BANCAIRE
-- -----------------------------------------------------------------------------

INSERT INTO carte_bancaire (num_cb,num_client,num_compte,code_securite,date_delivrance,organisme,activation) 
VALUES (1,1,1,'123','2012-02-23','Crédit Agricole',true);

INSERT INTO carte_bancaire (num_cb,num_client,num_compte,code_securite,date_delivrance,organisme,activation) 
VALUES (2,2,2,'972','2011-04-18','Banque Postale',false);

-- -----------------------------------------------------------------------------
--       TABLE : CHEQUIER
-- -----------------------------------------------------------------------------
INSERT INTO chequier(num_chequier,num_compte,date_delivrance,num_premier_cheque,num_dernier_cheque,activation,ordre,ordre_motif) 
VALUES (1,3,'2012-04-12',1,120,true,false,null);

------------------------------------------------------------------------------
--       TABLE : CHEQUE
-- -----------------------------------------------------------------------------
INSERT INTO cheque(num_cheque,num_chequier,date_emission) 
VALUES (1,1,'2012-04-24');


-- -----------------------------------------------------------------------------
--       TABLE : OPERATION
-- -----------------------------------------------------------------------------
INSERT INTO operation (id_operation, num_compte, date, num_compte_vers,num_cb, designation, type_operation, montant) 
VALUES (1, 1, '2012-10-27', 1,1 ,'Ouverture compte', 'CREDIT', 100);

