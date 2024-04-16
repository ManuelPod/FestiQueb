DROP DATABASE IF EXISTS festiqueb;
CREATE DATABASE IF NOT EXISTS festiqueb;
USE festiqueb;

CREATE DATABASE IF NOT EXISTS festiqueb;
# Table TypesBillets
# Tuples de TypesBillets inséré par script python
DROP TABLE IF EXISTS TypesBillets;
CREATE TABLE IF NOT EXISTS TypesBillets
(
    tbid          varchar(36) DEFAULT (UUID()) PRIMARY KEY,
    nom           varchar(200) NOT NULL,
    sans_limite   bool         NOT NULL,
    prix          double,
    categorie_age enum ('7-12','13-17','18-64','65+'),
    CHECK (prix >= 0)
);

# Table Utilisateurs
# (liste aléatoire générée par chatGPT)
DROP TABLE IF EXISTS Utilisateurs;
CREATE TABLE IF NOT EXISTS Utilisateurs
(
    uid            varchar(36) DEFAULT (UUID()) PRIMARY KEY,
    nom            varchar(100),
    mot_de_passe   varchar(256) NOT NULL,
    telephone      varchar(12),
    date_naissance date,
    courriel       varchar(100) NOT NULL UNIQUE,
    est_admin      bool,
    CHECK (courriel LIKE '%_@__%.__%'),
    CHECK (telephone LIKE '___-___-____')
);


# Gâchette qui vérifie la validité de la date de naissance d'un utilisateur. Si pour quelconque raison, la date
# de naissance d'un utilisation est plus grande que la date d'aujourd'hui on lance une erreur.
DROP TRIGGER IF EXISTS VerifierDateNaissance;
DELIMITER //
CREATE TRIGGER IF NOT EXISTS VerifierDateNaissance
    BEFORE INSERT
    ON Utilisateurs
    FOR EACH ROW
BEGIN
    IF (NEW.date_naissance > CURRENT_DATE) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La date de naissance doit être avant aujourd''hui.';
    END IF;
END //
DELIMITER ;


INSERT INTO Utilisateurs
VALUES (DEFAULT, 'Roxanne Maheu', '9W3gk28!$', '418-123-4567', '1993-01-20', 'roxanne.maheu@gmail.com', FALSE),
       (DEFAULT, 'Vincent Lambert', '7w1G!j3p$', '514-234-5678', '1985-03-15', 'vincent.lambert@gmail.com', FALSE),
       (DEFAULT, 'Marie Dupont', '6G3l5p7J$@', '581-345-6789', '1990-04-10', 'marie.dupont@hotmail.com', FALSE),
       (DEFAULT, 'Jean Tremblay', '9G4hT$0w2p', '450-456-7890', '1982-06-05', 'jean.tremblay@yahoo.com', FALSE),
       (DEFAULT, 'Sophie Lévesque', '1P7h6H%k$', '438-567-8901', '1978-09-25', 'sophie.levesque@outlook.com', FALSE),
       (DEFAULT, 'Martin Gagnon', '0M5nG9p$', '418-678-9012', '1995-12-30', 'martin.gagnon@live.com', FALSE),
       (DEFAULT, 'Isabelle Côté', '3M4pL7G!$', '514-789-0123', '1987-08-08', 'isabelle.cote@gmail.com', FALSE),
       (DEFAULT, 'Nicolas Morin', '2G8mR3J!$', '450-890-1234', '1980-11-12', 'nicolas.morin@yahoo.com', FALSE),
       (DEFAULT, 'Émilie Boucher', '1N9kD7M$', '418-901-2345', '1998-01-03', 'emilie.boucher@hotmail.com', FALSE),
       (DEFAULT, 'David Roy', '3R2lT5G!$', '514-012-3456', '1975-07-17', 'david.roy@outlook.com', FALSE),
       (DEFAULT, 'Julie Bergeron', '5B8wK9P%j$', '581-234-5678', '1989-02-20', 'julie.bergeron@gmail.com', FALSE),
       (DEFAULT, 'Patrick Lefebvre', '0L6pF4T$k', '450-345-6789', '1983-05-09', 'patrick.lefebvre@yahoo.com', FALSE),
       (DEFAULT, 'Anne Girard', '4G9lP6M$k', '438-456-7890', '1991-03-07', 'anne.girard@hotmail.com', FALSE),
       (DEFAULT, 'Philippe Martin', '1M9bR3P$j$', '514-567-8901', '1977-04-23', 'philippe.martin@live.com', FALSE),
       (DEFAULT, 'Nathalie Tremblay', '2T7pM8J$k', '418-678-9012', '1986-09-18', 'nathalie.tremblay@outlook.com',
        FALSE),
       (DEFAULT, 'Pierre Gauthier', '4G7wR1T!$', '450-789-0123', '1981-11-14', 'pierre.gauthier@gmail.com', FALSE),
       (DEFAULT, 'Caroline Fortin', '2F6hP9G!$', '581-890-1234', '1994-08-27', 'caroline.fortin@yahoo.com', FALSE),
       (DEFAULT, 'Marc Gagné', '0G3lM8P$k', '514-901-2345', '1979-12-04', 'marc.gagne@hotmail.com', FALSE),
       (DEFAULT, 'Isabelle Bélanger', '9B2lH8T$k', '418-012-3456', '1997-10-11', 'isabelle.belanger@outlook.com',
        FALSE),
       (DEFAULT, 'Éric Lavoie', '7L1mR4P!$', '450-123-4567', '1984-06-22', 'eric.lavoie@gmail.com', FALSE),
       (DEFAULT, 'Catherine Leblanc', '6L7wP9M!$', '581-234-5678', '1988-01-26', 'catherine.leblanc@yahoo.com', FALSE),
       (DEFAULT, 'Sylvain Bergeron', '4B7lT2P%j$', '514-345-6789', '1980-03-05', 'sylvain.bergeron@live.com', FALSE),
       (DEFAULT, 'Mélanie Gauthier', '3G8mR5J%k$', '438-456-7890', '1992-08-19', 'melanie.gauthier@hotmail.com', FALSE),
       (DEFAULT, 'Sébastien Gagné', '1G9sP4T$k', '418-567-8901', '1987-07-13', 'sebastien.gagne@outlook.com', FALSE),
       (DEFAULT, 'Josée Tremblay', '7T6hP2J!$', '450-678-9012', '1983-02-28', 'josee.tremblay@gmail.com', FALSE),
       (DEFAULT, 'Guillaume Dubois', '0D6bP3M$k', '514-789-0123', '1976-09-02', 'guillaume.dubois@yahoo.com', FALSE),
       (DEFAULT, 'Marie-Josée Lefebvre', '9L2pF4T!$', '581-890-1234', '1995-04-16', 'marie-josee.lefebvre@hotmail.com',
        FALSE),
       (DEFAULT, 'Mathieu Roy', '5R7sP1M$j$', '418-901-2345', '1989-11-21', 'mathieu.roy@live.com', FALSE),
       (DEFAULT, 'Anne-Marie Morin', '2M8rP3J$k', '514-012-3456', '1981-10-06', 'anne-marie.morin@outlook.com', FALSE),
       (DEFAULT, 'Stéphanie Pelletier', '4P9hS2M!$', '581-123-4567', '1978-12-31', 'stephanie.pelletier@yahoo.com',
        FALSE),
       (DEFAULT, 'Maxime Bouchard', '1B3cP9M!$', '450-234-5678', '1984-07-25', 'maxime.bouchard@gmail.com', FALSE),
       (DEFAULT, 'Mélanie Dubé', '9D2pS5M!$', '418-345-6789', '1990-03-09', 'melanie.dube@hotmail.com', FALSE),
       (DEFAULT, 'Nicolas Bergeron', '4B3gP6T$j%', '450-456-7890', '1977-05-28', 'nicolas.bergeron@yahoo.com', FALSE),
       (DEFAULT, 'Valérie Fortin', '7F1sM9P$k', '514-567-8901', '1982-02-13', 'valerie.fortin@live.com', FALSE),
       (DEFAULT, 'Alexandre Lavoie', '3L6mP8T$j$', '418-678-9012', '1996-01-06', 'alexandre.lavoie@outlook.com', FALSE),
       (DEFAULT, 'Marie-Eve Roy', '9R2sP3M$k', '450-789-0123', '1979-06-23', 'marie-eve.roy@gmail.com', FALSE),
       (DEFAULT, 'Jean-François Gagnon', '2G9fP6T!$', '581-890-1234', '1986-09-17', 'jean-francois.gagnon@yahoo.com',
        FALSE),
       (DEFAULT, 'Catherine Girard', '4G5tP2M%j$', '514-901-2345', '1991-04-01', 'catherine.girard@hotmail.com', FALSE),
       (DEFAULT, 'Sylvie Tremblay', '8T1jP4S$k', '418-012-3456', '1975-01-29', 'sylvie.tremblay@yahoo.com', FALSE),
       (DEFAULT, 'Marc-Antoine Bélanger', '1B8rM5P!$', '450-123-4567', '1988-05-14',
        'marc-antoine.belanger@hotmail.com', FALSE),
       (DEFAULT, 'Stéphanie Bergeron', '5B6tS7M$j$', '514-234-5678', '1993-10-04', 'stephanie.bergeron@live.com',
        FALSE),
       (DEFAULT, 'Charles Gauthier', '7G1hP6T$k', '581-345-6789', '1984-08-30', 'charles.gauthier@outlook.com', FALSE),
       (DEFAULT, 'Annie Lavoie', '2L7wP8T$k', '418-456-7890', '1990-12-25', 'annie.lavoie@gmail.com', FALSE),
       (DEFAULT, 'Nathalie Gagnon', '5G1fP4T$j%', '450-567-8901', '1982-11-09', 'nathalie.gagnon@yahoo.com', FALSE),
       (DEFAULT, 'Mathieu Dubois', '8D4tP2M$j%', '514-678-9012', '1976-10-03', 'mathieu.dubois@hotmail.com', FALSE),
       (DEFAULT, 'Isabelle Bouchard', '4B7mP3T$k', '581-789-0123', '1981-03-18', 'isabelle.bouchard@live.com', FALSE),
       (DEFAULT, 'Éric Roy', '1R5tP9M%k$', '418-890-1234', '1997-02-08', 'eric.roy@outlook.com', FALSE),
       (DEFAULT, 'Mélanie Leblanc', '6L7pT4M$k', '450-901-2345', '1989-05-03', 'melanie.leblanc@gmail.com', FALSE),
       (DEFAULT, 'Sébastien Fortin', '8F1pT7M!$', '514-012-3456', '1978-04-28', 'sebastien.fortin@yahoo.com', FALSE),
       (DEFAULT, 'Valérie Gagnon', '3G8fP2T%k$', '581-123-4567', '1985-01-13', 'valerie.gagnon@hotmail.com', FALSE),
       (DEFAULT, 'Guillaume Lefebvre', '5L7mP3T$j%', '450-234-5678', '1991-08-19', 'guillaume.lefebvre@live.com',
        FALSE),
       (DEFAULT, 'Anne-Sophie Morin', '9M2sP6T!$', '514-345-6789', '1977-07-04', 'anne-sophie.morin@outlook.com',
        FALSE),
       (DEFAULT, 'Marc-André Bergeron', '2B9rM7T!$', '418-456-7890', '1983-10-28', 'marc-andre.bergeron@gmail.com',
        FALSE),
       (DEFAULT, 'Marie-Pierre Gauthier', '1G4mP3T$k', '450-567-8901', '1996-05-22', 'marie-pierre.gauthier@yahoo.com',
        FALSE),
       (DEFAULT, 'Jean-François Tremblay', '5T8sP6M$j%', '514-678-9012', '1980-04-14',
        'jean-francois.tremblay@hotmail.com', FALSE),
       (DEFAULT, 'Marie-Claude Bélanger', '7B4hP1T$k', '581-789-0123', '1993-09-10', 'marie-claude.belanger@live.com',
        FALSE),
       (DEFAULT, 'Nicolas Roy', '2R8tP5M!$', '418-890-1234', '1979-12-05', 'nicolas.roy@outlook.com', FALSE),
       (DEFAULT, 'Valérie Dubois', '9D1jP7M$k', '450-901-2345', '1988-03-21', 'valerie.dubois@gmail.com', FALSE),
       (DEFAULT, 'Alexandre Bergeron', '6B4sP8T$k', '514-012-3456', '1994-06-14', 'alexandre.bergeron@yahoo.com',
        FALSE),
       (DEFAULT, 'Catherine Lavoie', '3L7pT4M$j%', '581-123-4567', '1976-07-19', 'catherine.lavoie@hotmail.com', FALSE),
       (DEFAULT, 'Émilie Fortin', '1F5gP9T$k', '418-234-5678', '1992-11-27', 'emilie.fortin@yahoo.com', FALSE),
       (DEFAULT, 'Sébastien Gagné', '7G1fP6T$k', '450-345-6789', '1975-10-10', 'sebastien.gagne@hotmail.com', FALSE),
       (DEFAULT, 'Julie Tremblay', '2T5pM8J$k', '514-456-7890', '1989-08-03', 'julie.tremblay@outlook.com', FALSE),
       (DEFAULT, 'Philippe Lefebvre', '9L1mP7T!$', '581-567-8901', '1984-01-26', 'philippe.lefebvre@gmail.com', FALSE),
       (DEFAULT, 'Nathalie Dubé', '4D7fP2T$j%', '418-678-9012', '1977-06-12', 'nathalie.dube@yahoo.com', FALSE),
       (DEFAULT, 'Stéphane Roy', '8R1mP3T$k', '450-789-0123', '1991-03-29', 'stephane.roy@hotmail.com', FALSE),
       (DEFAULT, 'Isabelle Gagnon', '1G4jP7T$k', '514-890-1234', '1983-05-14', 'isabelle.gagnon@gmail.com', FALSE),
       (DEFAULT, 'Sylvie Bergeron', '5B3tP6M$j%', '581-901-2345', '1976-08-07', 'sylvie.bergeron@outlook.com', FALSE),
       (DEFAULT, 'Alexandre Morin', '9M1sP5T!$', '418-012-3456', '1995-07-23', 'alexandre.morin@hotmail.com', FALSE),
       (DEFAULT, 'Éric Leblanc', '3L7fP9T$k', '450-123-4567', '1979-12-16', 'eric.leblanc@yahoo.com', FALSE),
       (DEFAULT, 'Karine Dubois', '6D3pS7T$k', '514-234-5678', '1987-10-09', 'karine.dubois@outlook.com', FALSE),
       (DEFAULT, 'Jonathan Gagnon', '1G7tP4T$j%', '581-345-6789', '1982-09-02', 'jonathan.gagnon@gmail.com', FALSE),
       (DEFAULT, 'Marie-Hélène Bouchard', '7B5tP2M!$', '418-456-7890', '1990-02-24', 'marie-helene.bouchard@yahoo.com',
        FALSE),
       (DEFAULT, 'Maxime Roy', '4R8gP5T$k', '450-567-8901', '1978-05-17', 'maxime.roy@hotmail.com', FALSE),
       (DEFAULT, 'Stéphanie Lavoie', '9L1sP3M$k', '514-678-9012', '1985-08-11', 'stephanie.lavoie@gmail.com', FALSE),
       (DEFAULT, 'Patrick Dubé', '2D5hP7T!$', '581-789-0123', '1992-11-03', 'patrick.dube@yahoo.com', FALSE),
       (DEFAULT, 'Catherine Bergeron', '6B7gP1T$j%', '418-890-1234', '1977-10-28', 'catherine.bergeron@hotmail.com',
        FALSE),
       (DEFAULT, 'Mathieu Gagnon', '1G4tP9T$k', '450-901-2345', '1996-02-19', 'mathieu.gagnon@outlook.com', FALSE),
       (DEFAULT, 'Isabelle Fortin', '7F3sP8T$k', '514-012-3456', '1981-01-14', 'isabelle.fortin@gmail.com', FALSE),
       (DEFAULT, 'Julie Bouchard', '5B9hP2M$j$', '581-123-4567', '1975-04-06', 'julie.bouchard@yahoo.com', FALSE),
       (DEFAULT, 'Sébastien Lefebvre', '3L4fP9T$k', '418-234-5678', '1989-09-30', 'sebastien.lefebvre@hotmail.com',
        FALSE),
       (DEFAULT, 'Valérie Dubé', '8D2hP6T$j%', '450-345-6789', '1984-12-23', 'valerie.dube@outlook.com', FALSE),
       (DEFAULT, 'Martin Bélanger', '2B7kP5M!$', '514-456-7890', '1979-07-18', 'martin.belanger@gmail.com', FALSE),
       (DEFAULT, 'Karine Gagnon', '6G9fP1T$k', '581-567-8901', '1993-06-11', 'karine.gagnon@yahoo.com', FALSE),
       (DEFAULT, 'Éric Bergeron', '9B2tP7M$j%', '418-678-9012', '1976-05-02', 'eric.bergeron@hotmail.com', FALSE),
       (DEFAULT, 'Marie-Pier Dubois', '3D8sP2M$k', '450-789-0123', '1991-08-27', 'marie-pier.dubois@yahoo.com', FALSE),
       (DEFAULT, 'François Roy', '1R4gP5T$k', '514-890-1234', '1983-11-20', 'francois.roy@outlook.com', FALSE),
       (DEFAULT, 'Marie-Ève Bouchard', '8B2sP7M$j%', '581-901-2345', '1977-03-15', 'marie-eve.bouchard@gmail.com',
        FALSE),
       (DEFAULT, 'Jean-François Dubois', '5D9jP4T$k', '418-012-3456', '1994-02-09', 'jean-francois.dubois@yahoo.com',
        FALSE),
       (DEFAULT, 'Sylvie Lavoie', '2L4gP6T$j%', '450-123-4567', '1978-01-04', 'sylvie.lavoie@hotmail.com', FALSE),
       (DEFAULT, 'Marc Gagnon', '7G1kP9M!$', '514-234-5678', '1982-08-29', 'marc.gagnon@yahoo.com', FALSE),
       (DEFAULT, 'Anne-Marie Bergeron', '3B5sP6M$k', '581-345-6789', '1990-05-24', 'anne-marie.bergeron@outlook.com',
        FALSE),
       (DEFAULT, 'Mathieu Tremblay', '9T2rP5M$j%', '418-456-7890', '1975-04-19', 'mathieu.tremblay@hotmail.com', FALSE),
       (DEFAULT, 'Geneviève Roy', '5R8fP1M$k', '450-567-8901', '1980-01-15', 'genevieve.roy@yahoo.com', FALSE),
       (DEFAULT, 'Julie Fortin', '2F5gP8T$j%', '514-678-9012', '1986-11-08', 'julie.fortin@hotmail.com', FALSE),
       (DEFAULT, 'Éric Gagnon', '6G2tP4T$k', '581-789-0123', '1992-12-03', 'eric.gagnon@gmail.com', FALSE),
       (DEFAULT, 'Sylvie Dubois', '1D9sP6T$j%', '418-890-1234', '1976-03-28', 'sylvie.dubois@outlook.com', FALSE),
       (DEFAULT, 'François Lefebvre', '7L3kP9T$k', '450-901-2345', '1981-06-12', 'francois.lefebvre@gmail.com', FALSE),
       (DEFAULT, 'Nathalie Bergeron', '4B6gP2M$j$', '514-012-3456', '1997-09-06', 'nathalie.bergeron@yahoo.com', FALSE),
       (DEFAULT, 'David Dubé', '9D4tP7M$k', '581-123-4567', '1978-02-01', 'david.dube@hotmail.com', FALSE),
       (DEFAULT, 'Marie-Claude Gagnon', '8G3tP6M$j%', '418-234-5678', '1985-05-26', 'marie-claude.gagnon@outlook.com',
        FALSE);

        

# Table Commandes
# (liste aléatoire générée par chatGPT)
# Relation Creer intégrée dans Commandes (champ creer)
# Note: La colonne montant devra être calculée à partir de Billets et Types_billets?
DROP TABLE IF EXISTS Commandes;
CREATE TABLE IF NOT EXISTS Commandes
(
    cid        varchar(36) DEFAULT (UUID()) PRIMARY KEY,
    montant    double,
    date_achat date,
    uid        varchar(36) REFERENCES Utilisateurs (uid),
    CHECK ( montant >= 0 )
);

# Gâchette qui vérifie la validité de la date d'achat d'une commande. Si celle-ci a, pour quelconque raison une date
# d'achat après la date d'aujourd'hui on lance une erreur.
DROP TRIGGER IF EXISTS VerifierDateAchat;
DELIMITER //
CREATE TRIGGER IF NOT EXISTS VerifierDateAchat
    BEFORE INSERT
    ON Commandes
    FOR EACH ROW
BEGIN
    IF (NEW.date_achat > CURRENT_DATE) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La date d''achat doit être avant aujourd''hui.';
    END IF;
END //
DELIMITER ;

DROP TABLE IF EXISTS Billets;
CREATE TABLE IF NOT EXISTS Billets
(
    bid         varchar(36) DEFAULT (UUID()) PRIMARY KEY,
    participant varchar(200) NOT NULL,
    tbid        varchar(36) REFERENCES TypesBillets (tbid),
    cid         varchar(36) REFERENCES Commandes (cid)
);

INSERT INTO Commandes
VALUES (DEFAULT, 50.75, '2024-04-01', 15),
       (DEFAULT, 102.49, '2024-04-02', 15),
       (DEFAULT, 75.20, '2024-04-03', 21),
       (DEFAULT, 30.00, '2024-04-04', 32),
       (DEFAULT, 99.99, '2024-04-05', 17),
       (DEFAULT, 45.60, '2024-04-06', 25),
       (DEFAULT, 65.30, '2024-04-07', 6),
       (DEFAULT, 80.00, '2024-04-08', 9),
       (DEFAULT, 120.75, '2024-04-07', 13),
       (DEFAULT, 55.20, '2024-04-01', 1),
       (DEFAULT, 130.49, '2024-04-01', 20),
       (DEFAULT, 70.00, '2024-04-02', 28),
       (DEFAULT, 90.99, '2024-04-03', 37),
       (DEFAULT, 88.60, '2024-04-04', 2),
       (DEFAULT, 33.30, '2024-04-05', 4),
       (DEFAULT, 75.00, '2024-04-06', 101),
       (DEFAULT, 22.75, '2024-04-07', 36),
       (DEFAULT, 43.49, '2024-03-08', 19),
       (DEFAULT, 55.20, '2024-04-05', 8),
       (DEFAULT, 100.30, '2024-04-01', 16),
       (DEFAULT, 80.00, '2024-04-01', 23),
       (DEFAULT, 99.99, '2024-04-02', 30),
       (DEFAULT, 66.60, '2024-04-03', 10),
       (DEFAULT, 120.75, '2024-04-04', 31),
       (DEFAULT, 90.49, '2024-04-05', 12);


# Table Lieux
# (liste aléatoire générée par chatGPT)
DROP TABLE IF EXISTS Lieux;
CREATE TABLE IF NOT EXISTS Lieux
(
    endroit      varchar(100) PRIMARY KEY,
    nom_scene    varchar(100),
    telephone    varchar(12),
    capacite     int,
    vente_alcool bool NOT NULL,
    CHECK ( capacite >= 0 ),
    CHECK ( telephone LIKE '___-___-____' )
);

INSERT INTO Lieux
VALUES ('123 Rue du Bonheur, Montréal', 'Le Paradis Perdu', '514-123-4567', 15000, 1),
       ('456 Avenue des Rêves, Québec', 'La Licorne Enchantée', '418-555-1234', 2500, 1),
       ('789 Boulevard de la Fantaisie, Montréal', 'La Tanière des Caribous', '514-987-6543', 7000, 0),
       ('101 Rue de l''Humour, Montréal', 'Le Théâtre des Fous Rires', '514-555-7890', 900, 1),
       ('222 Chemin de l''Émerveillement, Trois-Rivières', 'La Cabane à Sucre Magique', '819-321-7654', 3000, 1),
       ('333 Route de l''Épouvante, Québec', 'Le Château des Frissons', '418-456-7890', 8000, 0),
       ('444 Rue de la Rigolade, Sherbrooke', 'Le Théâtre des Marmottes Farceuses', '819-654-3210', 1200, 1),
       ('555 Avenue de la Joie, Montréal', 'Le Jardin des Délices', '514-333-4444', 18000, 1),
       ('666 Rue de la Gourmandise, Québec', 'Le Palais des Patates Frites', '418-222-3333', 500, 1),
       ('777 Boulevard du Givre, Chicoutimi', 'La Salle de Bal des Pingouins', '418-777-8888', 2000, 0);

# Table Artistes
# (liste aléatoire générée par chatGPT)
DROP TABLE IF EXISTS Artistes;
CREATE TABLE IF NOT EXISTS Artistes
(
    aid        varchar(36) DEFAULT (UUID()) PRIMARY KEY,
    nom        varchar(100) NOT NULL,
    telephone  varchar(12)  NOT NULL,
    courriel   varchar(100) NOT NULL,
    popularite int,
    image      varchar(200),
    CHECK ( telephone LIKE '___-___-____' ),
    CHECK ( courriel LIKE '%_@__%.__%' ),
    CHECK ( popularite >= 0 AND popularite <= 10 )
);

INSERT INTO Artistes
VALUES (DEFAULT, 'Céline Dion', '514-123-4567', 'celine.dion@example.com', 3,
        'audience.jpg'),
       (DEFAULT, 'Garou', '418-555-1234', 'garou@example.com', 7,
        'audience.jpg'),
       (DEFAULT, 'Marc Dupré', '514-987-6543', 'marc.dupre@example.com', 4,
        'audience.jpg'),
       (DEFAULT, 'Isabelle Boulay', '514-555-7890', 'isabelle.boulay@example.com', 6,
        'audience.jpg'),
       (DEFAULT, 'Patrick Norman', '819-321-7654', 'patrick.norman@example.com', 9,
        'audience.jpg'),
       (DEFAULT, 'Marie-Mai', '418-456-7890', 'mariemai@example.com', 2,
        'audience.jpg'),
       (DEFAULT, 'Jean-Pierre Ferland', '819-654-3210', 'jeanpierre.ferland@example.com', 8,
        'audience.jpg'),
       (DEFAULT, 'Renée Martel', '514-333-4444', 'renee.martel@example.com', 5,
        'audience.jpg'),
       (DEFAULT, 'Robert Charlebois', '418-222-3333', 'robert.charlebois@example.com', 1,
        'audience.jpg'),
       (DEFAULT, 'Ginette Reno', '418-777-8888', 'ginette.reno@example.com', 10,
        'audience.jpg'),
       (DEFAULT, 'Louis-Jean Cormier', '514-111-2222', 'louisjean.cormier@example.com', 3,
        'audience.jpg'),
       (DEFAULT, 'Marie Denise Pelletier', '418-999-8888', 'mariedenise.pelletier@example.com', 6,
        'audience.jpg'),
       (DEFAULT, 'Daniel Bélanger', '418-333-4444', 'daniel.belanger@example.com', 7,
        'audience.jpg'),
       (DEFAULT, 'Les Cowboys Fringants', '514-777-6666', 'lescowboysfringants@example.com', 9,
        'audience.jpg'),
       (DEFAULT, 'Richard Desjardins', '819-888-7777', 'richard.desjardins@example.com', 4,
        'audience.jpg'),
       (DEFAULT, 'Beau Dommage', '514-222-3333', 'beaudommage@example.com', 8,
        'audience.jpg'),
       (DEFAULT, 'Ariane Moffatt', '418-444-5555', 'ariane.moffatt@example.com', 5,
        'audience.jpg'),
       (DEFAULT, 'Les Colocs', '819-666-7777', 'lescolocs@example.com', 2,
        'audience.jpg'),
       (DEFAULT, 'Jean Leloup', '514-999-8888', 'jean.leloup@example.com', 6,
        'audience.jpg'),
       (DEFAULT, 'Pierre Lapointe', '418-111-2222', 'pierre.lapointe@example.com', 9,
        'audience.jpg'),
       (DEFAULT, 'Gab Bouchard', '819-555-6666', 'gab.bouchard@example.com', 10,
        'audience.jpg'),
       (DEFAULT, 'Marjo', '514-888-9999', 'marjo@example.com', 8,
        'audience.jpg'),
       (DEFAULT, 'Fred Pellerin', '418-777-9999', 'fred.pellerin@example.com', 0,
        'audience.jpg'),
       (DEFAULT, 'Louis-Jean Cormier', '819-444-8888', 'louisjean.cormier@example.com', 10,
        'audience.jpg'),
       (DEFAULT, 'Karkwa', '514-333-9999', 'karkwa@example.com', 7,
        'audience.jpg'),
       (DEFAULT, 'Les Trois Accords', '418-666-9999', 'lestroisaccords@example.com', 1,
        'audience.jpg'),
       (DEFAULT, 'Les Soeurs Boulay', '819-777-8888', 'lessoeursboulay@example.com', 5,
        'audience.jpg'),
       (DEFAULT, 'Alex Nevsky', '514-555-3333', 'alex.nevsky@example.com', 10,
        'audience.jpg'),
       (DEFAULT, 'Les Respectables', '418-888-7777', 'lesrespectables@example.com', 4,
        'audience.jpg'),
       (DEFAULT, 'Ariane Brunet', '819-999-8888', 'ariane.brunet@example.com', 6,
        'audience.jpg');

# Table PlagesHoraires
# (liste aléatoire générée par chatGPT)
DROP TABLE IF EXISTS PlagesHoraires;
CREATE TABLE IF NOT EXISTS PlagesHoraires
(
    phid       varchar(36) DEFAULT (UUID()) PRIMARY KEY,
    date       date NOT NULL,
    heureDebut time NOT NULL,
    heureFin   time NOT NULL
);

# Cette gâchette s'assure lors de la création d'une plage horaire qu'un plage horaire similaire n'existe pas déjà.
# Il serait redondant d'avoir plusieurs plages horaires avec une même date heure de début et heure de fin.
DROP TRIGGER IF EXISTS PlageHoraireNonDoublon;
DELIMITER //
CREATE TRIGGER IF NOT EXISTS PlageHoraireNonDoublon
    BEFORE INSERT
    ON PlagesHoraires
    FOR EACH ROW
BEGIN
    IF (EXISTS(SELECT phid
               FROM PlagesHoraires PH
               WHERE NEW.date = PH.date
                 AND NEW.heureDebut = PH.heureDebut
                 AND NEW.heureFin = PH.heureFin)) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Cette plage horaire existe déjà.';
    END IF;
END //
DELIMITER ;

# Cette gâchette s'assure que pour un plage horaire créé la date de début est avant la date de
# fin pour éviter des erreur potentielles.
DROP TRIGGER IF EXISTS HeureDebutAvantFin;
DELIMITER //
CREATE TRIGGER IF NOT EXISTS HeureDebutAvantFin
    BEFORE INSERT
    ON PlagesHoraires
    FOR EACH ROW
BEGIN
    IF (NEW.heureDebut > NEW.heureFin) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'L''heure de début de la plage horaire ne peut être après l''heure de fin.';
    END IF;
END //
DELIMITER ;

INSERT INTO PlagesHoraires
VALUES (DEFAULT, '2024-08-01', '17:00:00', '19:00:00'),
       (DEFAULT, '2024-08-01', '19:00:00', '22:00:00'),
       (DEFAULT, '2024-08-01', '22:00:00', '23:30:00'),
       (DEFAULT, '2024-08-02', '16:00:00', '18:00:00'),
       (DEFAULT, '2024-08-02', '18:00:00', '21:00:00'),
       (DEFAULT, '2024-08-02', '21:00:00', '23:15:00'),
       (DEFAULT, '2024-08-03', '15:00:00', '16:30:00'),
       (DEFAULT, '2024-08-03', '16:30:00', '20:00:00'),
       (DEFAULT, '2024-08-03', '20:00:00', '23:50:00');


# Table Spectacles
# (liste aléatoire générée par chatGPT)
# Relations Performer, Réserver et Accueillir intégrées dans Spectacle (champs aid, phid et endroit)
DROP TABLE IF EXISTS Spectacles;
CREATE TABLE IF NOT EXISTS Spectacles
(
    sid         varchar(36) DEFAULT (UUID()) PRIMARY KEY,
    description varchar(500),
    aid         varchar(36) REFERENCES Artistes (aid),
    phid        varchar(36) REFERENCES PlagesHoraires (phid),
    endroit     varchar(100) REFERENCES Lieux (endroit)
);

# Gâchette qui s'occupe de valider qu'un spectacle créer n'entre pas en conflit avec un
# autre spectacle. C'est à dire qu'il est unique, donc qu'un seul artiste performe à un endroit donnée
# à une heure et date donné.
DROP TRIGGER IF EXISTS ValiderSpectacle;
DELIMITER //
CREATE TRIGGER IF NOT EXISTS ValiderSpectacle
    BEFORE INSERT
    ON Spectacles
    FOR EACH ROW
BEGIN
    IF EXISTS(SELECT aid FROM Spectacles WHERE aid = NEW.aid) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Un spectacle avec cet artiste existe déjà.';
    ELSEIF EXISTS(SELECT phid, endroit FROM Spectacles WHERE phid = NEW.phid AND endroit = NEW.endroit) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Il y a déjà un spectacle à cet endroit et cette heure.';
    END IF;
END //
DELIMITER ;

# Procédure qui s'occupe de faire l'Assignation des spectacles, c'est à dire, faire une combinaison d'artiste
# de lieu et de plage horaire. Elle crée la meilleure combinaison pour qu'un artiste qui est très populaire
# performe à une scène qui a une grande capacité et plu tard dans la soiré comme dans beaucoup de festival.
# Cela fait en sorte qu'il y a assez de place pour tous les spectateurs qui veulent voir un artiste populaire.
DROP PROCEDURE IF EXISTS AlgorithmeAssignationSpectacles;
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS AlgorithmeAssignationSpectacles()
BEGIN
    DECLARE endroit VARCHAR(100);
    DECLARE phid VARCHAR(36);
    DECLARE aid VARCHAR(36);
    DECLARE lecture_complete BOOL DEFAULT FALSE;

    DECLARE curseur_horaires CURSOR FOR
        SELECT PH.phid, L.endroit
        FROM festiqueb.PlagesHoraires PH,
             festiqueb.Lieux L
        ORDER BY PH.heureDebut DESC, L.capacite DESC;

    DECLARE curseur_artistes CURSOR FOR SELECT A.aid FROM Artistes A ORDER BY popularite DESC;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET lecture_complete = TRUE;

    OPEN curseur_horaires;
    OPEN curseur_artistes;

    boucle:
    LOOP
        FETCH curseur_horaires INTO phid, endroit;
        FETCH curseur_artistes INTO aid;

        IF lecture_complete THEN
            LEAVE boucle;
        END IF;

        INSERT INTO Spectacles VALUES (DEFAULT, NULL, aid, phid, endroit);
    END LOOP boucle;

    CLOSE curseur_horaires;
    CLOSE curseur_artistes;
END//
DELIMITER ;

#Table Accès
# Cette table contient les accès disponibles. Chaque billet créé contiendra 1 ou plusieurs accès liés à un spectacle.
# Il sera ainsi possible de valider qu'un billet ne soit pas utilisé deux fois pour entre dans un spectacle.
DROP TABLE IF EXISTS Acces;
CREATE TABLE IF NOT EXISTS Acces
(
    bid        varchar(36) REFERENCES Billets (bid) ON DELETE CASCADE,
    sid        varchar(36) REFERENCES Spectacles (sid),
    disponible bool
);


DROP PROCEDURE IF EXISTS CommanderBillets;
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS CommanderBillets(json_items varchar(1000), id_utilisateur varchar(36),
                                                OUT id_commande varchar(36))
BEGIN
    DECLARE id_type_billet varchar(36);
    DECLARE id_spectacle varchar(36);
    DECLARE prix_type_billet double;
    DECLARE quantité_billets int;
    DECLARE compteur int DEFAULT 0;
    DECLARE nouvel_id_billet varchar(36);
    DECLARE total_commande double;
    DECLARE type_billet_sans_limite boolean;

    DECLARE lecture_complete bool DEFAULT FALSE;
    DECLARE curseur CURSOR FOR SELECT tbid, sid, prix, quantité, sans_limite
                               FROM (SELECT *
                                     FROM JSON_TABLE(json_items, '$[*]'
                                                     COLUMNS (tbid varchar(36) PATH '$.typeBilletId', sid varchar(36) PATH '$.spectacleId', quantité int PATH '$.quantite' )) AS Item) as Items
                                        NATURAL JOIN TypesBillets TB;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET lecture_complete = TRUE;
    SET id_commande = (UUID());
    INSERT INTO Commandes VALUE (id_commande, 0.0, CURRENT_DATE(), id_utilisateur);
    OPEN curseur;

    boucle :
    LOOP
        FETCH curseur INTO id_type_billet, id_spectacle, prix_type_billet, quantité_billets, type_billet_sans_limite;
        IF lecture_complete THEN
            LEAVE boucle;
        END IF;

        SET compteur := 0;
        boucle_quantité:
        LOOP
            IF compteur < quantité_billets THEN
                SELECT montant INTO total_commande FROM Commandes WHERE cid = id_commande;
                SET nouvel_id_billet := (UUID());
                INSERT INTO Billets VALUE (nouvel_id_billet,
                                           (SELECT nom FROM Utilisateurs U WHERE uid = id_utilisateur),
                                           id_type_billet, id_commande);
                IF type_billet_sans_limite THEN
                    INSERT INTO Acces
                    SELECT tbid, sid, TRUE
                    FROM TypesBillets TB,
                         Spectacles S
                    WHERE TB.tbid = id_type_billet;
                ELSE
                    INSERT INTO Acces VALUE (nouvel_id_billet, id_spectacle, TRUE);
                END IF;
                UPDATE Commandes SET montant = total_commande + prix_type_billet WHERE cid = id_commande;

                SET compteur := compteur + 1;
            ELSE
                LEAVE boucle_quantité;
            END IF;
        END LOOP;
    END LOOP;

    CLOSE curseur;
END//
DELIMITER ;


# Utilisateurs (uid: varchar(36), nom: varchar(100),
# 			  mot_de_passe: char(64), telephone: varchar(12),
# 			  date_naissance: date,  courriel: varchar(100))
#
# TypesBillets (tbid: varchar(36), nom: varchar(200),
#               sans_limite: bool, prix: double,
#               categorie_age: enum('7-12','13-17','18-64','65+'))
#
# Commandes (cid: varchar(36), montant: double,
#            date_achat: date, uid: varchar(36))
#
# Billets (bid: varchar(36), participant: varchar(200),
#          tbid: varchar(36), cid: varchar(36))
#
# Lieux (endroit: varchar(100), nom_scene: varchar(100),
#        telephone: varchar(12), capacite: int, vente_alcool: bool)
#
# Artistes (aid: varchar(36), nom: varchar(100),
#     telephone: varchar(12), courriel: varchar(100),
#     popularite: int, image: varchar(200))
#
# PlagesHoraires (phid: varchar(36),date: date,
#                 heureDebut: time, heureFin: time)
#
# Spectacles (sid: varchar(36), descriptio: varchar(500),
#             aid: varchar(36), phid: varchar(36),
#             endroit: varchar(100))
#
# Accès (bid: varchar(36), sid: varchar(36), disponible: bool)

