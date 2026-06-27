-- Włączenie obsługi kluczy obcych (wymagane w SQLite, by więzy działały poprawnie)
PRAGMA foreign_keys = ON;

-- Utworzenie tabeli Czytelnicy
CREATE TABLE Czytelnicy (
    ID_Czytelnika INTEGER PRIMARY KEY AUTOINCREMENT,
    Imie TEXT NOT NULL,
    Nazwisko TEXT NOT NULL,
    Ulica TEXT,
    Kod_Pocztowy TEXT,
    Miasto TEXT,
    Data_Zapisu TEXT DEFAULT CURRENT_DATE
);

-- Utworzenie tabeli Autorzy
CREATE TABLE Autorzy (
    ID_Autora INTEGER PRIMARY KEY AUTOINCREMENT,
    Imie TEXT NOT NULL,
    Nazwisko TEXT NOT NULL
);

-- Utworzenie tabeli Kategorie
CREATE TABLE Kategorie (
    ID_Kategorii INTEGER PRIMARY KEY AUTOINCREMENT,
    Nazwa_Kategorii TEXT NOT NULL UNIQUE
);

-- Utworzenie tabeli Ksiazki z jawną deklaracją kluczy obcych na końcu
CREATE TABLE Ksiazki (
    ID_Ksiazki INTEGER PRIMARY KEY AUTOINCREMENT,
    ID_Autora INTEGER,
    ID_Kategorii INTEGER,
    Tytul TEXT NOT NULL,
    Rok_Wydania INTEGER,
    FOREIGN KEY (ID_Autora) REFERENCES Autorzy(ID_Autora) ON DELETE RESTRICT,
    FOREIGN KEY (ID_Kategorii) REFERENCES Kategorie(ID_Kategorii) ON DELETE RESTRICT
);

-- Utworzenie tabeli asocjacyjnej Wypozyczenia
CREATE TABLE Wypozyczenia (
    ID_Wypozyczenia INTEGER PRIMARY KEY AUTOINCREMENT,
    ID_Czytelnika INTEGER,
    ID_Ksiazki INTEGER,
    Data_Wypozyczenia TEXT DEFAULT CURRENT_DATE,
    Data_Zwrotu TEXT,
    FOREIGN KEY (ID_Czytelnika) REFERENCES Czytelnicy(ID_Czytelnika) ON DELETE CASCADE,
    FOREIGN KEY (ID_Ksiazki) REFERENCES Ksiazki(ID_Ksiazki) ON DELETE RESTRICT
);