USE festiqueb;

DROP TABLE IF EXISTS TypesBillets;
CREATE TABLE IF NOT EXISTS TypesBillets
(
    tbid           int PRIMARY KEY,
    nom            varchar(200) NOT NULL,
    sans_limite    bool         NOT NULL,
    prix           double,
    categories_age enum ('7-12','13-17','18-64','65+'),
    CHECK (prix >= 0)
);

INSERT INTO TypesBillets VALUE (1, 'Passe de festival', true, 49.99, '13-17');
SELECT *
FROM TypesBillets;

# Table Utilisateurs
# (liste aléatoire générée par chatGPT)
DROP TABLE IF EXISTS Utilisateurs;
CREATE TABLE IF NOT EXISTS Utilisateurs
(
    uid            int PRIMARY KEY,
    nom            varchar(100),
    mot_de_passe   varchar(50), #crypté
    telephone      varchar(14),
    date_naissance date,
    courriel       varchar(100)
);

INSERT INTO Utilisateurs
VALUES (1, 'Roxanne Maheu', '9W3gk28!$', '418-123-4567', '1993-01-20', 'roxanne.maheu@gmail.com'),
       (2, 'Vincent Lambert', '7w1G!j3p$', '514-234-5678', '1985-03-15', 'vincent.lambert@gmail.com'),
       (3, 'Marie Dupont', '6G3l5p7J$@', '581-345-6789', '1990-04-10', 'marie.dupont@hotmail.com'),
       (4, 'Jean Tremblay', '9G4hT$0w2p', '450-456-7890', '1982-06-05', 'jean.tremblay@yahoo.com'),
       (5, 'Sophie Lévesque', '1P7h6H%k$', '438-567-8901', '1978-09-25', 'sophie.levesque@outlook.com'),
       (6, 'Martin Gagnon', '0M5nG9p$', '418-678-9012', '1995-12-30', 'martin.gagnon@live.com'),
       (7, 'Isabelle Côté', '3M4pL7G!$', '514-789-0123', '1987-08-08', 'isabelle.cote@gmail.com'),
       (8, 'Nicolas Morin', '2G8mR3J!$', '450-890-1234', '1980-11-12', 'nicolas.morin@yahoo.com'),
       (9, 'Émilie Boucher', '1N9kD7M$', '418-901-2345', '1998-01-03', 'emilie.boucher@hotmail.com'),
       (10, 'David Roy', '3R2lT5G!$', '514-012-3456', '1975-07-17', 'david.roy@outlook.com'),
       (11, 'Julie Bergeron', '5B8wK9P%j$', '581-234-5678', '1989-02-20', 'julie.bergeron@gmail.com'),
       (12, 'Patrick Lefebvre', '0L6pF4T$k', '450-345-6789', '1983-05-09', 'patrick.lefebvre@yahoo.com'),
       (13, 'Anne Girard', '4G9lP6M$k', '438-456-7890', '1991-03-07', 'anne.girard@hotmail.com'),
       (14, 'Philippe Martin', '1M9bR3P$j$', '514-567-8901', '1977-04-23', 'philippe.martin@live.com'),
       (15, 'Nathalie Tremblay', '2T7pM8J$k', '418-678-9012', '1986-09-18', 'nathalie.tremblay@outlook.com'),
       (16, 'Pierre Gauthier', '4G7wR1T!$', '450-789-0123', '1981-11-14', 'pierre.gauthier@gmail.com'),
       (17, 'Caroline Fortin', '2F6hP9G!$', '581-890-1234', '1994-08-27', 'caroline.fortin@yahoo.com'),
       (18, 'Marc Gagné', '0G3lM8P$k', '514-901-2345', '1979-12-04', 'marc.gagne@hotmail.com'),
       (19, 'Isabelle Bélanger', '9B2lH8T$k', '418-012-3456', '1997-10-11', 'isabelle.belanger@outlook.com'),
       (20, 'Éric Lavoie', '7L1mR4P!$', '450-123-4567', '1984-06-22', 'eric.lavoie@gmail.com'),
       (21, 'Catherine Leblanc', '6L7wP9M!$', '581-234-5678', '1988-01-26', 'catherine.leblanc@yahoo.com'),
       (22, 'Sylvain Bergeron', '4B7lT2P%j$', '514-345-6789', '1980-03-05', 'sylvain.bergeron@live.com'),
       (23, 'Mélanie Gauthier', '3G8mR5J%k$', '438-456-7890', '1992-08-19', 'melanie.gauthier@hotmail.com'),
       (24, 'Sébastien Gagné', '1G9sP4T$k', '418-567-8901', '1987-07-13', 'sebastien.gagne@outlook.com'),
       (25, 'Josée Tremblay', '7T6hP2J!$', '450-678-9012', '1983-02-28', 'josee.tremblay@gmail.com'),
       (26, 'Guillaume Dubois', '0D6bP3M$k', '514-789-0123', '1976-09-02', 'guillaume.dubois@yahoo.com'),
       (27, 'Marie-Josée Lefebvre', '9L2pF4T!$', '581-890-1234', '1995-04-16', 'marie-josee.lefebvre@hotmail.com'),
       (28, 'Mathieu Roy', '5R7sP1M$j$', '418-901-2345', '1989-11-21', 'mathieu.roy@live.com'),
       (29, 'Anne-Marie Morin', '2M8rP3J$k', '514-012-3456', '1981-10-06', 'anne-marie.morin@outlook.com'),
       (30, 'Stéphanie Pelletier', '4P9hS2M!$', '581-123-4567', '1978-12-31', 'stephanie.pelletier@yahoo.com'),
       (31, 'Maxime Bouchard', '1B3cP9M!$', '450-234-5678', '1984-07-25', 'maxime.bouchard@gmail.com'),
       (32, 'Mélanie Dubé', '9D2pS5M!$', '418-345-6789', '1990-03-09', 'melanie.dube@hotmail.com'),
       (33, 'Nicolas Bergeron', '4B3gP6T$j%', '450-456-7890', '1977-05-28', 'nicolas.bergeron@yahoo.com'),
       (34, 'Valérie Fortin', '7F1sM9P$k', '514-567-8901', '1982-02-13', 'valerie.fortin@live.com'),
       (35, 'Alexandre Lavoie', '3L6mP8T$j$', '418-678-9012', '1996-01-06', 'alexandre.lavoie@outlook.com'),
       (36, 'Marie-Eve Roy', '9R2sP3M$k', '450-789-0123', '1979-06-23', 'marie-eve.roy@gmail.com'),
       (37, 'Jean-François Gagnon', '2G9fP6T!$', '581-890-1234', '1986-09-17', 'jean-francois.gagnon@yahoo.com'),
       (38, 'Catherine Girard', '4G5tP2M%j$', '514-901-2345', '1991-04-01', 'catherine.girard@hotmail.com'),
       (39, 'Sylvie Tremblay', '8T1jP4S$k', '418-012-3456', '1975-01-29', 'sylvie.tremblay@yahoo.com'),
       (40, 'Marc-Antoine Bélanger', '1B8rM5P!$', '450-123-4567', '1988-05-14', 'marc-antoine.belanger@hotmail.com'),
       (41, 'Stéphanie Bergeron', '5B6tS7M$j$', '514-234-5678', '1993-10-04', 'stephanie.bergeron@live.com'),
       (42, 'Charles Gauthier', '7G1hP6T$k', '581-345-6789', '1984-08-30', 'charles.gauthier@outlook.com'),
       (43, 'Annie Lavoie', '2L7wP8T$k', '418-456-7890', '1990-12-25', 'annie.lavoie@gmail.com'),
       (44, 'Nathalie Gagnon', '5G1fP4T$j%', '450-567-8901', '1982-11-09', 'nathalie.gagnon@yahoo.com'),
       (45, 'Mathieu Dubois', '8D4tP2M$j%', '514-678-9012', '1976-10-03', 'mathieu.dubois@hotmail.com'),
       (46, 'Isabelle Bouchard', '4B7mP3T$k', '581-789-0123', '1981-03-18', 'isabelle.bouchard@live.com'),
       (47, 'Éric Roy', '1R5tP9M%k$', '418-890-1234', '1997-02-08', 'eric.roy@outlook.com'),
       (48, 'Mélanie Leblanc', '6L7pT4M$k', '450-901-2345', '1989-05-03', 'melanie.leblanc@gmail.com'),
       (49, 'Sébastien Fortin', '8F1pT7M!$', '514-012-3456', '1978-04-28', 'sebastien.fortin@yahoo.com'),
       (50, 'Valérie Gagnon', '3G8fP2T%k$', '581-123-4567', '1985-01-13', 'valerie.gagnon@hotmail.com'),
       (51, 'Guillaume Lefebvre', '5L7mP3T$j%', '450-234-5678', '1991-08-19', 'guillaume.lefebvre@live.com'),
       (52, 'Anne-Sophie Morin', '9M2sP6T!$', '514-345-6789', '1977-07-04', 'anne-sophie.morin@outlook.com'),
       (53, 'Marc-André Bergeron', '2B9rM7T!$', '418-456-7890', '1983-10-28', 'marc-andre.bergeron@gmail.com'),
       (54, 'Marie-Pierre Gauthier', '1G4mP3T$k', '450-567-8901', '1996-05-22', 'marie-pierre.gauthier@yahoo.com'),
       (55, 'Jean-François Tremblay', '5T8sP6M$j%', '514-678-9012', '1980-04-14', 'jean-francois.tremblay@hotmail.com'),
       (56, 'Marie-Claude Bélanger', '7B4hP1T$k', '581-789-0123', '1993-09-10', 'marie-claude.belanger@live.com'),
       (57, 'Nicolas Roy', '2R8tP5M!$', '418-890-1234', '1979-12-05', 'nicolas.roy@outlook.com'),
       (58, 'Valérie Dubois', '9D1jP7M$k', '450-901-2345', '1988-03-21', 'valerie.dubois@gmail.com'),
       (59, 'Alexandre Bergeron', '6B4sP8T$k', '514-012-3456', '1994-06-14', 'alexandre.bergeron@yahoo.com'),
       (60, 'Catherine Lavoie', '3L7pT4M$j%', '581-123-4567', '1976-07-19', 'catherine.lavoie@hotmail.com'),
       (61, 'Émilie Fortin', '1F5gP9T$k', '418-234-5678', '1992-11-27', 'emilie.fortin@yahoo.com'),
       (62, 'Sébastien Gagné', '7G1fP6T$k', '450-345-6789', '1975-10-10', 'sebastien.gagne@hotmail.com'),
       (63, 'Julie Tremblay', '2T5pM8J$k', '514-456-7890', '1989-08-03', 'julie.tremblay@outlook.com'),
       (64, 'Philippe Lefebvre', '9L1mP7T!$', '581-567-8901', '1984-01-26', 'philippe.lefebvre@gmail.com'),
       (65, 'Nathalie Dubé', '4D7fP2T$j%', '418-678-9012', '1977-06-12', 'nathalie.dube@yahoo.com'),
       (66, 'Stéphane Roy', '8R1mP3T$k', '450-789-0123', '1991-03-29', 'stephane.roy@hotmail.com'),
       (67, 'Isabelle Gagnon', '1G4jP7T$k', '514-890-1234', '1983-05-14', 'isabelle.gagnon@gmail.com'),
       (68, 'Sylvie Bergeron', '5B3tP6M$j%', '581-901-2345', '1976-08-07', 'sylvie.bergeron@outlook.com'),
       (69, 'Alexandre Morin', '9M1sP5T!$', '418-012-3456', '1995-07-23', 'alexandre.morin@hotmail.com'),
       (70, 'Éric Leblanc', '3L7fP9T$k', '450-123-4567', '1979-12-16', 'eric.leblanc@yahoo.com'),
       (71, 'Karine Dubois', '6D3pS7T$k', '514-234-5678', '1987-10-09', 'karine.dubois@outlook.com'),
       (72, 'Jonathan Gagnon', '1G7tP4T$j%', '581-345-6789', '1982-09-02', 'jonathan.gagnon@gmail.com'),
       (73, 'Marie-Hélène Bouchard', '7B5tP2M!$', '418-456-7890', '1990-02-24', 'marie-helene.bouchard@yahoo.com'),
       (74, 'Maxime Roy', '4R8gP5T$k', '450-567-8901', '1978-05-17', 'maxime.roy@hotmail.com'),
       (75, 'Stéphanie Lavoie', '9L1sP3M$k', '514-678-9012', '1985-08-11', 'stephanie.lavoie@gmail.com'),
       (76, 'Patrick Dubé', '2D5hP7T!$', '581-789-0123', '1992-11-03', 'patrick.dube@yahoo.com'),
       (77, 'Catherine Bergeron', '6B7gP1T$j%', '418-890-1234', '1977-10-28', 'catherine.bergeron@hotmail.com'),
       (78, 'Mathieu Gagnon', '1G4tP9T$k', '450-901-2345', '1996-02-19', 'mathieu.gagnon@outlook.com'),
       (79, 'Isabelle Fortin', '7F3sP8T$k', '514-012-3456', '1981-01-14', 'isabelle.fortin@gmail.com'),
       (80, 'Julie Bouchard', '5B9hP2M$j$', '581-123-4567', '1975-04-06', 'julie.bouchard@yahoo.com'),
       (81, 'Sébastien Lefebvre', '3L4fP9T$k', '418-234-5678', '1989-09-30', 'sebastien.lefebvre@hotmail.com'),
       (82, 'Valérie Dubé', '8D2hP6T$j%', '450-345-6789', '1984-12-23', 'valerie.dube@outlook.com'),
       (83, 'Martin Bélanger', '2B7kP5M!$', '514-456-7890', '1979-07-18', 'martin.belanger@gmail.com'),
       (84, 'Karine Gagnon', '6G9fP1T$k', '581-567-8901', '1993-06-11', 'karine.gagnon@yahoo.com'),
       (85, 'Éric Bergeron', '9B2tP7M$j%', '418-678-9012', '1976-05-02', 'eric.bergeron@hotmail.com'),
       (86, 'Marie-Pier Dubois', '3D8sP2M$k', '450-789-0123', '1991-08-27', 'marie-pier.dubois@yahoo.com'),
       (87, 'François Roy', '1R4gP5T$k', '514-890-1234', '1983-11-20', 'francois.roy@outlook.com'),
       (88, 'Marie-Ève Bouchard', '8B2sP7M$j%', '581-901-2345', '1977-03-15', 'marie-eve.bouchard@gmail.com'),
       (89, 'Jean-François Dubois', '5D9jP4T$k', '418-012-3456', '1994-02-09', 'jean-francois.dubois@yahoo.com'),
       (90, 'Sylvie Lavoie', '2L4gP6T$j%', '450-123-4567', '1978-01-04', 'sylvie.lavoie@hotmail.com'),
       (91, 'Marc Gagnon', '7G1kP9M!$', '514-234-5678', '1982-08-29', 'marc.gagnon@yahoo.com'),
       (92, 'Anne-Marie Bergeron', '3B5sP6M$k', '581-345-6789', '1990-05-24', 'anne-marie.bergeron@outlook.com'),
       (93, 'Mathieu Tremblay', '9T2rP5M$j%', '418-456-7890', '1975-04-19', 'mathieu.tremblay@hotmail.com'),
       (94, 'Geneviève Roy', '5R8fP1M$k', '450-567-8901', '1980-01-15', 'genevieve.roy@yahoo.com'),
       (95, 'Julie Fortin', '2F5gP8T$j%', '514-678-9012', '1986-11-08', 'julie.fortin@hotmail.com'),
       (96, 'Éric Gagnon', '6G2tP4T$k', '581-789-0123', '1992-12-03', 'eric.gagnon@gmail.com'),
       (97, 'Sylvie Dubois', '1D9sP6T$j%', '418-890-1234', '1976-03-28', 'sylvie.dubois@outlook.com'),
       (98, 'François Lefebvre', '7L3kP9T$k', '450-901-2345', '1981-06-12', 'francois.lefebvre@gmail.com'),
       (99, 'Nathalie Bergeron', '4B6gP2M$j$', '514-012-3456', '1997-09-06', 'nathalie.bergeron@yahoo.com'),
       (100, 'David Dubé', '9D4tP7M$k', '581-123-4567', '1978-02-01', 'david.dube@hotmail.com'),
       (101, 'Marie-Claude Gagnon', '8G3tP6M$j%', '418-234-5678', '1985-05-26', 'marie-claude.gagnon@outlook.com');

# Table Commandes
# (liste aléatoire générée par chatGPT)
# Relation Creer intégrée dans Commandes (champ creer)
# Note: La colonne montant devra être calculée à partir de Billets et Types_billets?
DROP TABLE IF EXISTS Commandes;
CREATE TABLE IF NOT EXISTS
    Commandes
(
    cid        int PRIMARY KEY,
    montant    double,
    date_achat date,
    creer      int,
    FOREIGN KEY (creer) REFERENCES Utilisateurs (uid)
);

DROP TABLE IF EXISTS Billets;
CREATE TABLE IF NOT EXISTS Billets
(
    bid         int PRIMARY KEY,
    participant varchar(200),
    tbid        char(10) REFERENCES TypesBillets,
    cid         int REFERENCES Commandes
);

INSERT INTO Commandes
VALUES (1, 50.75, '2024-04-01', 15),
       (2, 102.49, '2024-04-02', 15),
       (3, 75.20, '2024-04-03', 21),
       (4, 30.00, '2024-04-04', 32),
       (5, 99.99, '2024-04-05', 17),
       (6, 45.60, '2024-04-06', 25),
       (7, 65.30, '2024-04-07', 6),
       (8, 80.00, '2024-04-08', 9),
       (9, 120.75, '2024-04-09', 13),
       (10, 55.20, '2024-04-10', 1),
       (11, 130.49, '2024-04-11', 20),
       (12, 70.00, '2024-04-12', 28),
       (13, 90.99, '2024-04-13', 37),
       (14, 88.60, '2024-04-14', 2),
       (15, 33.30, '2024-04-15', 4),
       (16, 75.00, '2024-04-16', 101),
       (17, 22.75, '2024-04-17', 36),
       (18, 43.49, '2024-04-18', 19),
       (19, 55.20, '2024-04-19', 8),
       (20, 100.30, '2024-04-20', 16),
       (21, 80.00, '2024-04-21', 23),
       (22, 99.99, '2024-04-22', 30),
       (23, 66.60, '2024-04-23', 10),
       (24, 120.75, '2024-04-24', 31),
       (25, 90.49, '2024-04-25', 12);


# Table Lieux
# (liste aléatoire générée par chatGPT)
DROP TABLE IF EXISTS Lieux;
CREATE TABLE IF NOT EXISTS Lieux
(
    endroit      varchar(100) PRIMARY KEY,
    Nom_scene    varchar(100),
    telephone    varchar(14),
    capacite     int,
    vente_alcool tinyint
);

INSERT INTO Lieux
VALUES ('Le Paradis Perdu', '(514) 123-4567', '123 Rue du Bonheur, Montréal', 15000, 1),
       ('La Licorne Enchantée', '(418) 555-1234', '456 Avenue des Rêves, Québec', 2500, 1),
       ('La Tanière des Caribous', '(514) 987-6543', '789 Boulevard de la Fantaisie, Montréal', 7000, 0),
       ('Le Théâtre des Fous Rires', '(514) 555-7890', '101 Rue de l''Humour, Montréal', 900, 1),
       ('La Cabane à Sucre Magique', '(819) 321-7654', '222 Chemin de l''Émerveillement, Trois-Rivières', 3000, 1),
       ('Le Château des Frissons', '(418) 456-7890', '333 Route de l''Épouvante, Québec', 8000, 0),
       ('Le Théâtre des Marmottes Farceuses', '(819) 654-3210', '444 Rue de la Rigolade, Sherbrooke', 1200, 1),
       ('Le Jardin des Délices', '(514) 333-4444', '555 Avenue de la Joie, Montréal', 18000, 1),
       ('Le Palais des Patates Frites', '(418) 222-3333', '666 Rue de la Gourmandise, Québec', 500, 1),
       ('La Salle de Bal des Pingouins', '(418) 777-8888', '777 Boulevard du Givre, Chicoutimi', 2000, 0);

# Table Artistes
# (liste aléatoire générée par chatGPT)
DROP TABLE IF EXISTS Artistes;
CREATE TABLE IF NOT EXISTS Artistes
(
    aid        int PRIMARY KEY,
    nom        varchar(100),
    telephone  varchar(14),
    courriel   varchar(100),
    popularite int,
    image      varchar(200)
);

INSERT INTO Artistes
VALUES (1, 'Jean Tremblay', '(514) 123-4567', 'jean.tremblay@example.com', 750,
        'https://example.com/artistes/jean_tremblay.jpg'),
       (2, 'Marie Gagnon', '(418) 555-1234', 'marie.gagnon@example.com', 820,
        'https://example.com/artistes/marie_gagnon.jpg'),
       (3, 'Pierre Dubois', '(514) 987-6543', 'pierre.dubois@example.com', 680,
        'https://example.com/artistes/pierre_dubois.jpg'),
       (4, 'Sophie Lavoie', '(514) 555-7890', 'sophie.lavoie@example.com', 900,
        'https://example.com/artistes/sophie_lavoie.jpg'),
       (5, 'Michel Bouchard', '(819) 321-7654', 'michel.bouchard@example.com', 600,
        'https://example.com/artistes/michel_bouchard.jpg'),
       (6, 'Isabelle Martin', '(418) 456-7890', 'isabelle.martin@example.com', 780,
        'https://example.com/artistes/isabelle_martin.jpg'),
       (7, 'Simon Fortin', '(819) 654-3210', 'simon.fortin@example.com', 720,
        'https://example.com/artistes/simon_fortin.jpg'),
       (8, 'Nathalie Roy', '(514) 333-4444', 'nathalie.roy@example.com', 850,
        'https://example.com/artistes/nathalie_roy.jpg'),
       (9, 'Luc Deschênes', '(418) 222-3333', 'luc.deschenes@example.com', 690,
        'https://example.com/artistes/luc_deschenes.jpg'),
       (10, 'Caroline Bergeron', '(418) 777-8888', 'caroline.bergeron@example.com', 780,
        'https://example.com/artistes/caroline_bergeron.jpg'),
       (11, 'Marc Gauthier', '(514) 111-2222', 'marc.gauthier@example.com', 720,
        'https://example.com/artistes/marc_gauthier.jpg'),
       (12, 'Catherine Leblanc', '(418) 999-8888', 'catherine.leblanc@example.com', 820,
        'https://example.com/artistes/catherine_leblanc.jpg'),
       (13, 'François Tremblay', '(418) 333-4444', 'francois.tremblay@example.com', 760,
        'https://example.com/artistes/francois_tremblay.jpg'),
       (14, 'Martine Roy', '(514) 777-6666', 'martine.roy@example.com', 900,
        'https://example.com/artistes/martine_roy.jpg'),
       (15, 'Sylvain Gagné', '(819) 888-7777', 'sylvain.gagne@example.com', 640,
        'https://example.com/artistes/sylvain_gagne.jpg'),
       (16, 'Julie Bergeron', '(514) 222-3333', 'julie.bergeron@example.com', 880,
        'https://example.com/artistes/julie_bergeron.jpg'),
       (17, 'Éric Dubé', '(418) 444-5555', 'eric.dube@example.com', 740, 'https://example.com/artistes/eric_dube.jpg'),
       (18, 'Caroline Fortier', '(819) 666-7777', 'caroline.fortier@example.com', 700,
        'https://example.com/artistes/caroline_fortier.jpg'),
       (19, 'Patrick Tremblay', '(514) 999-8888', 'patrick.tremblay@example.com', 800,
        'https://example.com/artistes/patrick_tremblay.jpg'),
       (20, 'Geneviève Lévesque', '(418) 111-2222', 'genevieve.levesque@example.com', 730,
        'https://example.com/artistes/genevieve_levesque.jpg'),
       (21, 'Stéphane Bélanger', '(819) 555-6666', 'stephane.belanger@example.com', 890,
        'https://example.com/artistes/stephane_belanger.jpg'),
       (22, 'Annie Girard', '(514) 888-9999', 'annie.girard@example.com', 780,
        'https://example.com/artistes/annie_girard.jpg'),
       (23, 'Louis Tremblay', '(418) 777-9999', 'louis.tremblay@example.com', 690,
        'https://example.com/artistes/louis_tremblay.jpg'),
       (24, 'Sylvie Gagnon', '(819) 444-8888', 'sylvie.gagnon@example.com', 850,
        'https://example.com/artistes/sylvie_gagnon.jpg'),
       (25, 'Alexandre Dubois', '(514) 333-9999', 'alexandre.dubois@example.com', 720,
        'https://example.com/artistes/alexandre_dubois.jpg'),
       (26, 'Valérie Lachance', '(418) 666-9999', 'valerie.lachance@example.com', 920,
        'https://example.com/artistes/valerie_lachance.jpg'),
       (27, 'Martin Fortin', '(819) 777-8888', 'martin.fortin@example.com', 680,
        'https://example.com/artistes/martin_fortin.jpg'),
       (28, 'Nancy Tremblay', '(514) 555-3333', 'nancy.tremblay@example.com', 760,
        'https://example.com/artistes/nancy_tremblay.jpg'),
       (29, 'Yves Gagné', '(418) 888-7777', 'yves.gagne@example.com', 770,
        'https://example.com/artistes/yves_gagne.jpg'),
       (30, 'Isabelle Bélanger', '(819) 999-8888', 'isabelle.belanger@example.com', 840,
        'https://example.com/artistes/isabelle_belanger.jpg');


# Table PlagesHoraires
# (liste aléatoire générée par chatGPT)
DROP TABLE IF EXISTS PlagesHoraires;
CREATE TABLE IF NOT EXISTS PlagesHoraires
(
    phid       int PRIMARY KEY,
    date       date,
    heureDebut time,
    heureFin   time
);

DROP TRIGGER IF EXISTS HeureDebutAvantFin;
DELIMITER //
CREATE TRIGGER IF NOT EXISTS HeureDebutAvantFin
    BEFORE INSERT
    ON PlagesHoraires
    FOR EACH ROW
BEGIN
    IF (NEW.heureDebut > NEW.heureFin) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'L\'heure de début de la plage horaire ne peut être après l\'heure de fin.';
    END IF;
END //
DELIMITER ;

INSERT INTO PlagesHoraires
VALUES (1, '2025-08-01', '17:00:00', '19:00:00'),
       (2, '2025-08-01', '20:00:00', '22:00:00'),
       (3, '2025-08-02', '20:00:00', '23:00:00'),
       (4, '2025-08-03', '16:00:00', '18:00:00'),
       (5, '2025-08-03', '21:00:00', '23:00:00'),
       (6, '2025-08-04', '16:00:00', '17:00:00'),
       (7, '2025-08-04', '18:00:00', '22:00:00'),
       (8, '2025-08-05', '11:00:00', '13:00:00');


# Table Spectacle
# (liste aléatoire générée par chatGPT)
# Relations Performer, Réserver et Accueillir intégrées dans Spectacle (champs aid, phid et endroit)
DROP TABLE IF EXISTS Spectacle;
CREATE TABLE IF NOT EXISTS Spectacle
(
    sid         int PRIMARY KEY,
    description varchar(500),
    aid         int,
    phid        int,
    endroit     varchar(100),
    FOREIGN KEY (aid) REFERENCES Artistes (aid),
    FOREIGN KEY (phid) REFERENCES PlagesHoraires (phid),
    FOREIGN KEY (endroit) REFERENCES Lieux (endroit)
);

INSERT INTO Spectacle (sid, description, aid, phid, endroit)
VALUES (1, 'Concert de jazz envoûtant', 5, 1, '222 Chemin de l''Émerveillement, Trois-Rivières'),
       (2, 'Spectacle de rock énergique', 8, 3, '789 Boulevard de la Fantaisie, Montréal'),
       (3, 'Concert de musique classique', 6, 1, '333 Route de l''Épouvante, Québec'),
       (4, 'Spectacle de folk acoustique', 14, 8, '444 Rue de la Rigolade, Sherbrooke'),
       (5, 'Spectacle de gypsy punk dynamique', 3, 6, '123 Rue du Bonheur, Montréal'),
       (6, 'Concert de pop entraînante', 20, 4, '555 Avenue de la Joie, Montréal'),
       (7, 'Spectacle de country festif', 4, 7, '456 Avenue des Rêves, Québec'),
       (8, 'Concert de blues passionnant', 2, 5, '123 Rue du Bonheur, Montréal'),
       (9, 'Spectacle de reggae relaxant', 10, 2, '777 Boulevard du Givre, Chicoutimi'),
       (10, 'Concert de métal explosif', 17, 4, '101 Rue de l''Humour, Montréal'),
       (11, 'Spectacle de rap engagé', 11, 5, '333 Route de l''Épouvante, Québec'),
       (12, 'Concert de musique électronique', 12, 2, '555 Avenue de la Joie, Montréal'),
       (13, 'Spectacle de ska festif', 13, 8, '222 Chemin de l''Émerveillement, Trois-Rivières'),
       (14, 'Concert de funk groovy', 29, 1, '777 Boulevard du Givre, Chicoutimi'),
       (15, 'Spectacle de musique du monde', 25, 3, '666 Rue de la Gourmandise, Québec');