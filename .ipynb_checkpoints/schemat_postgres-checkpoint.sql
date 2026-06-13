-- ========================================================
-- SYSTEM ZARZĄDZANIA BIBLIOTEKĄ - SKRYPT DDL (PostgreSQL)
-- ========================================================

-- 1. Tworzenie tabeli: Czytelnicy (tabela niezależna)
CREATE TABLE Czytelnicy (
    ID_Czytelnika SERIAL PRIMARY KEY,
    Imie VARCHAR(50) NOT NULL,
    Nazwisko VARCHAR(50) NOT NULL,
    Ulica VARCHAR(100),
    Kod_Pocztowy VARCHAR(6),
    Miasto VARCHAR(50),
    Data_Zapisu DATE DEFAULT CURRENT_DATE
);

-- 2. Tworzenie tabeli: Autorzy (tabela niezależna)
CREATE TABLE Autorzy (
    ID_Autora SERIAL PRIMARY KEY,
    Imie VARCHAR(50) NOT NULL,
    Nazwisko VARCHAR(50) NOT NULL
);

-- 3. Tworzenie tabeli: Kategorie (tabela niezależna)
CREATE TABLE Kategorie (
    ID_Kategorii SERIAL PRIMARY KEY,
    Nazwa_Kategorii VARCHAR(50) NOT NULL
);

-- 4. Tworzenie tabeli: Ksiazki (zależy od Autorzy i Kategorie)
CREATE TABLE Ksiazki (
    ID_Ksiazki SERIAL PRIMARY KEY,
    ID_Autora INTEGER REFERENCES Autorzy(ID_Autora) ON DELETE SET NULL,
    ID_Kategorii INTEGER REFERENCES Kategorie(ID_Kategorii) ON DELETE SET NULL,
    Tytul VARCHAR(150) NOT NULL,
    Rok_Wydania SMALLINT
);

-- 5. Tworzenie tabeli: Wypozyczenia (zależy od Czytelnicy i Ksiazki)
CREATE TABLE Wypozyczenia (
    ID_Wypozyczenia SERIAL PRIMARY KEY,
    ID_Czytelnika INTEGER REFERENCES Czytelnicy(ID_Czytelnika) ON DELETE CASCADE,
    ID_Ksiazki INTEGER REFERENCES Ksiazki(ID_Ksiazki) ON DELETE CASCADE,
    Data_Wypozyczenia DATE DEFAULT CURRENT_DATE,
    Data_Zwrotu DATE
);