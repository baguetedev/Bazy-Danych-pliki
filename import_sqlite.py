{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "66952d73-0701-44ce-a0f1-703835441b2e",
   "metadata": {},
   "outputs": [],
   "source": [
    "import sqlite3\n",
    "import csv\n",
    "import os\n",
    "\n",
    "# Funkcja wczytująca dane z pliku CSV\n",
    "def wczytaj_dane_csv(sciezka_pliku):\n",
    "    dane = []\n",
    "    with open(sciezka_pliku, mode='r', encoding='utf-8') as plik:\n",
    "        csv_reader = csv.reader(plik)\n",
    "        next(csv_reader)  # Pominięcie wiersza nagłówka\n",
    "        for wiersz in csv_reader:\n",
    "            dane.append(tuple(wiersz))\n",
    "    return dane\n",
    "\n",
    "# Funkcja wsadowego importu do SQLite\n",
    "def importuj_do_sqlite(kategorie_do_importu, sciezka_bazy):\n",
    "    try:\n",
    "        # Nawiązanie połączenia z plikiem bazy danych (.db)\n",
    "        with sqlite3.connect(sciezka_bazy) as conn:\n",
    "            cursor = conn.cursor()\n",
    "            \n",
    "            # Sparametryzowane zapytanie (? dla SQLite)\n",
    "            zapytanie_sql = \"INSERT INTO Kategorie (Nazwa_Kategorii) VALUES (?)\"\n",
    "            \n",
    "            # Wykonanie wsadowe\n",
    "            cursor.executemany(zapytanie_sql, kategorie_do_importu)\n",
    "            \n",
    "            # Konieczne zatwierdzenie transakcji\n",
    "            conn.commit()\n",
    "            \n",
    "            print(f\"Pomyślnie zaimportowano {len(kategorie_do_importu)} rekordów do SQLite.\")\n",
    "    except sqlite3.Error as e:\n",
    "        print(f\"Wystąpił błąd bazy SQLite: {e}\")\n",
    "\n",
    "if __name__ == \"__main__\":\n",
    "    plik_bazy = 'biblioteka.db'\n",
    "    plik_csv = 'kategorie.csv'\n",
    "    \n",
    "    # Sprawdzenie czy plik CSV istnieje przed importem\n",
    "    if os.path.exists(plik_csv):\n",
    "        dane_z_pliku = wczytaj_dane_csv(plik_csv)\n",
    "        importuj_do_sqlite(dane_z_pliku, plik_bazy)\n",
    "    else:\n",
    "        print(f\"Brak pliku {plik_csv}. Upewnij się, że znajduje się w tym samym folderze.\")"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "DBMS Python3.14",
   "language": "python",
   "name": "dbms"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.14.3"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
