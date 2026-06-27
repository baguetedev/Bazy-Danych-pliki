import csv
import psycopg

# Funkcja wczytująca dane z pliku CSV
def wczytaj_dane_csv(sciezka_pliku):
    dane = []
    with open(sciezka_pliku, mode='r', encoding='utf-8') as plik:
        csv_reader = csv.reader(plik)
        next(csv_reader)  # Pominięcie wiersza nagłówka
        for wiersz in csv_reader:
            dane.append(tuple(wiersz))
    return dane

# Funkcja wsadowego importu do PostgreSQL
def importuj_do_postgres(kategorie_do_importu, db_config):
    try:
        # Nawiązanie połączenia z bazą (wartości w db_config należy dostosować do swojego serwera)
        with psycopg.connect(**db_config) as conn:
            with conn.cursor() as cursor:
                # Sparametryzowane zapytanie (%s dla PostgreSQL)
                zapytanie_sql = "INSERT INTO Kategorie (Nazwa_Kategorii) VALUES (%s)"
                
                # Wykonanie wsadowe
                cursor.executemany(zapytanie_sql, kategorie_do_importu)
                
                print(f"Pomyślnie zaimportowano {len(kategorie_do_importu)} rekordów do PostgreSQL.")
    except Exception as e:
        print(f"Wystąpił błąd operacji wsadowej (PostgreSQL): {e}")

if __name__ == "__main__":
    # Dane logowania do bazy (do uzupełnienia rzeczywistymi danymi z laboratorium)
    konfiguracja_bazy = {
        "dbname": "student15db4",
        "user": "student15",
        "password": "fwbmfhgxqdZNP",
        "host": "localhost", 
        "port": "5432"
    }
    # Uruchomienie procesu
    dane_z_pliku = wczytaj_dane_csv('kategorie.csv')
    if dane_z_pliku:
        importuj_do_postgres(dane_z_pliku, konfiguracja_bazy)