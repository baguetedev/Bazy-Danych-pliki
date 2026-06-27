-- Utworzenie tabeli Czytelnicy
CREATE TABLE Czytelnicy (
    ID_Czytelnika SERIAL PRIMARY KEY,
    Imie VARCHAR(50) NOT NULL,
    Nazwisko VARCHAR(50) NOT NULL,
    Ulica VARCHAR(100),
    Kod_Pocztowy VARCHAR(6),
    Miasto VARCHAR(50),
    Data_Zapisu DATE DEFAULT CURRENT_DATE
);

-- Utworzenie tabeli Autorzy
CREATE TABLE Autorzy (
    ID_Autora SERIAL PRIMARY KEY,
    Imie VARCHAR(50) NOT NULL,
    Nazwisko VARCHAR(50) NOT NULL
);

-- Utworzenie tabeli Kategorie
CREATE TABLE Kategorie (
    ID_Kategorii SERIAL PRIMARY KEY,
    Nazwa_Kategorii VARCHAR(50) NOT NULL UNIQUE
);

-- Utworzenie tabeli Ksiazki z kluczami obcymi do Autorów i Kategorii
CREATE TABLE Ksiazki (
    ID_Ksiazki SERIAL PRIMARY KEY,
    ID_Autora INTEGER REFERENCES Autorzy(ID_Autora) ON DELETE RESTRICT,
    ID_Kategorii INTEGER REFERENCES Kategorie(ID_Kategorii) ON DELETE RESTRICT,
    Tytul VARCHAR(150) NOT NULL,
    Rok_Wydania SMALLINT
);

-- Utworzenie tabeli asocjacyjnej Wypozyczenia
CREATE TABLE Wypozyczenia (
    ID_Wypozyczenia SERIAL PRIMARY KEY,
    ID_Czytelnika INTEGER REFERENCES Czytelnicy(ID_Czytelnika) ON DELETE CASCADE,
    ID_Ksiazki INTEGER REFERENCES Ksiazki(ID_Ksiazki) ON DELETE RESTRICT,
    Data_Wypozyczenia DATE DEFAULT CURRENT_DATE,
    Data_Zwrotu DATE
);