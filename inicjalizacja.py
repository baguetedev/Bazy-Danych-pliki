import psycopg
import sqlite3
import os

# Konfiguracja dla lokalnego PostgreSQL
# Uzupełnij poniższe dane zgodnie ze swoją lokalną instancją bazy
pg_config = {
    "dbname": "postgres",
    "user": "postgres",
    "password": "password",
    "host": "localhost",
    "port": "5432"
}

ddl_postgres = """
DROP TABLE IF EXISTS Wypozyczenia CASCADE;
DROP TABLE IF EXISTS Ksiazki CASCADE;
DROP TABLE IF EXISTS Kategorie CASCADE;
DROP TABLE IF EXISTS Autorzy CASCADE;
DROP TABLE IF EXISTS Czytelnicy CASCADE;

CREATE TABLE Czytelnicy (
    ID_Czytelnika SERIAL PRIMARY KEY,
    Imie VARCHAR(50), Nazwisko VARCHAR(50), Ulica VARCHAR(100),
    Kod_Pocztowy VARCHAR(6), Miasto VARCHAR(50), Data_Zapisu DATE DEFAULT CURRENT_DATE
);
CREATE TABLE Autorzy (
    ID_Autora SERIAL PRIMARY KEY,
    Imie VARCHAR(50), Nazwisko VARCHAR(50)
);
CREATE TABLE Kategorie (
    ID_Kategorii SERIAL PRIMARY KEY,
    Nazwa_Kategorii VARCHAR(50)
);
CREATE TABLE Ksiazki (
    ID_Ksiazki SERIAL PRIMARY KEY,
    ID_Autora INTEGER REFERENCES Autorzy(ID_Autora),
    ID_Kategorii INTEGER REFERENCES Kategorie(ID_Kategorii),
    Tytul VARCHAR(150) NOT NULL, Rok_Wydania SMALLINT
);
CREATE TABLE Wypozyczenia (
    ID_Wypozyczenia SERIAL PRIMARY KEY,
    ID_Czytelnika INTEGER REFERENCES Czytelnicy(ID_Czytelnika),
    ID_Ksiazki INTEGER REFERENCES Ksiazki(ID_Ksiazki),
    Data_Wypozyczenia DATE DEFAULT CURRENT_DATE, Data_Zwrotu DATE
);
"""

ddl_sqlite = """
DROP TABLE IF EXISTS Wypozyczenia;
DROP TABLE IF EXISTS Ksiazki;
DROP TABLE IF EXISTS Kategorie;
DROP TABLE IF EXISTS Autorzy;
DROP TABLE IF EXISTS Czytelnicy;

CREATE TABLE Czytelnicy (
    ID_Czytelnika INTEGER PRIMARY KEY AUTOINCREMENT,
    Imie TEXT, Nazwisko TEXT, Ulica TEXT, Kod_Pocztowy TEXT, Miasto TEXT, Data_Zapisu TEXT
);
CREATE TABLE Autorzy (
    ID_Autora INTEGER PRIMARY KEY AUTOINCREMENT, Imie TEXT, Nazwisko TEXT
);
CREATE TABLE Kategorie (
    ID_Kategorii INTEGER PRIMARY KEY AUTOINCREMENT, Nazwa_Kategorii TEXT
);
CREATE TABLE Ksiazki (
    ID_Ksiazki INTEGER PRIMARY KEY AUTOINCREMENT,
    ID_Autora INTEGER, ID_Kategorii INTEGER,
    Tytul TEXT, Rok_Wydania INTEGER,
    FOREIGN KEY(ID_Autora) REFERENCES Autorzy(ID_Autora),
    FOREIGN KEY(ID_Kategorii) REFERENCES Kategorie(ID_Kategorii)
);
CREATE TABLE Wypozyczenia (
    ID_Wypozyczenia INTEGER PRIMARY KEY AUTOINCREMENT,
    ID_Czytelnika INTEGER, ID_Ksiazki INTEGER,
    Data_Wypozyczenia TEXT, Data_Zwrotu TEXT,
    FOREIGN KEY(ID_Czytelnika) REFERENCES Czytelnicy(ID_Czytelnika),
    FOREIGN KEY(ID_Ksiazki) REFERENCES Ksiazki(ID_Ksiazki)
);
"""

# Znormalizowane dane dokładnie odwzorowujące pliki CSV i JSON ze sprawozdania.
dml_dane = """
-- Dane czytelników
INSERT INTO Czytelnicy (Imie, Nazwisko, Ulica, Kod_Pocztowy, Miasto, Data_Zapisu) VALUES 
('Jan', 'Kowalski', 'Kwiatowa 1', '00-001', 'Warszawa', '2024-01-15'),
('Anna', 'Nowak', 'Polna 2', '31-444', 'Kraków', '2023-11-05');

-- Dane autorów
INSERT INTO Autorzy (Imie, Nazwisko) VALUES 
('Andrzej', 'Sapkowski'),
('Adam', 'Mickiewicz'),
('Stephen', 'King');

-- Dane kategorii
INSERT INTO Kategorie (Nazwa_Kategorii) VALUES 
('Fantastyka'),
('Kryminał'),
('Literatura faktu'),
('Poezja'),
('Horror');

-- Dane książek
INSERT INTO Ksiazki (ID_Autora, ID_Kategorii, Tytul, Rok_Wydania) VALUES 
(1, 1, 'Wiedźmin', 1993),
(2, 4, 'Pan Tadeusz', 1834),
(3, 5, 'Lśnienie', 1977);

-- Historia wypożyczeń i zwrotów
INSERT INTO Wypozyczenia (ID_Czytelnika, ID_Ksiazki, Data_Wypozyczenia, Data_Zwrotu) VALUES 
(1, 1, '2024-03-01', '2024-03-15'),
(1, 2, '2024-03-10', NULL),
(2, 3, '2024-02-20', '2024-03-05');
"""

try:
    with psycopg.connect(**pg_config) as pg_conn:
        with pg_conn.cursor() as cur:
            cur.execute(ddl_postgres)
            cur.execute(dml_dane)
        pg_conn.commit()
    print("Baza PostgreSQL zostala pomyslnie utworzona i zasilona docelowymi danymi z raportu.")
except Exception as e:
    print(f"Blad PostgreSQL: {e}")

db_file = 'biblioteka.db'
if os.path.exists(db_file):
    os.remove(db_file) 

try:
    with sqlite3.connect(db_file) as sq_conn:
        cur = sq_conn.cursor()
        cur.executescript(ddl_sqlite)
        cur.executescript(dml_dane)
        sq_conn.commit()
    print("Plik biblioteka.db (SQLite) zostal pomyslnie utworzony i zasilony docelowymi danymi z raportu.")
except Exception as e:
    print(f"Blad SQLite: {e}")
