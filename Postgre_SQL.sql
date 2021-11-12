-- aliasy, odniesienie do aliasu itp

SELECT 
	  c.first_name AS "Imie" -- musza byc cydzyslowia!
	, c.last_name AS "Nazwisko" -- latwe do zakomentowania
	, c.email AS "adres_email" -- mozna pominac as i dziala
FROM customer AS c;
---------------------------------------------------------------
SELECT * FROM customer_list -- tabela w zakladce view
ORDER BY country ASC, city ASC
LIMIT 10 OFFSET 50; -- sortowanie ze wzgledu na dwie kolumny
-- po przecinku mozna wpisac gwiazdke, wtedy mamy dostep do szybkiego podgladu tabeli
-- nazwy kolumn ze SPACJA wpisujemy w cudzyslowiu
-- ORDER BY 2,3,4 -> sortowanie po wymienionych kolumnach
-- LIMIT 10 OFFSET 50 -> pokaz 10 ale pomin 50 pierwszych rekordow
---------------------------------------------------------------
SELECT * FROM film_list
WHERE LENGTH BETWEEN 100 AND 110 -- setka i 110 sie zawiera, mozna dodac NOT BETWEEN
ORDER BY LENGTH;
---------------------------------------------------------------
SELECT * FROM rental
WHERE return_date IS NULL -- mozna dodac NOTa!
ORDER BY rental_date DESC;

SELECT 
	COUNT(return_date)
FROM rental
WHERE return_date IS NULL; -- mamy zero bo funkcja count zlicza tylko rekordy gdzie nie wystepuje NULL
--------------------------------------------------------------
CREATE TEMPORARY TABLE numbers
(number INTEGER NULL);

INSERT INTO numbers VALUES (10),(20),(30), (NULL);
SELECT * FROM numbers;

SELECT COUNT(*) FROM numbers; -- wynik to 4 bo COUNT(*) zlicza wszystko
SELECT count(number) FROM numbers; -- wynik to 3 bo COUNT dla poszczegolnych kolumn nie bierze pod uwage NULL
SELECT SUM(number) FROM numbers;
SELECT AVG(number) FROM numbers; -- NULL w tej funkcji został pominiety
DROP TABLE numbers;

SELECT COUNT(DISTINCT customer_id) FROM rental;	-- 599 unikalnych klientow, bez powtorzen
----------------------------------------------------------------
-- TIMESTAMP UWZGLEDNIA STREFY CZASOWE!
SELECT NOW()::DATE; -- daj date
SELECT NOW()::TIME; -- daj czas
SELECT CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP;

SELECT 
		  r.rental_date::DATE
		, r.return_date
		, DATE_TRUNC('year', r.rental_date) -- obetnij do dnia, miesiaca, roku
		, DATE_PART('month', r.rental_date) -- wyciagniecie samego miesiaca z daty
		, DATE_PART('dow', r.rental_date) -- wyciagnij dzien tygodnia
		, EXTRACT('dow' FROM r.rental_date) AS extract
		, (r.rental_date + INTERVAL '3 days')::DATE AS "termin zwrotu" -- mozemy skorzystac z metody daj date poniewaz zwrot ma byc do godziny 23:59 danego dnia i tyle
		, EXTRACT('day' FROM AGE(r.return_date, r.rental_date)) AS okres -- bez extracta ta fukcja zwraca precyzyjna ilosc czasu do zwrotu
FROM rental r; -- alias r

SELECT
		  DATE '2030-01-01' -- lepiej dodac date by dla postgresa bylo to jasne
		, TIMESTAMP '2030-01-01' -- moze byc tez timestamp
FROM rental r;
----------------------------------------------------------------
SELECT * INTO my_actor FROM actor; -- select tworzy nowa tabele, bez pozostalych constraintow np, szybka kopia tabeli do niebezpiecznej pracy
DROP TABLE my_actor;
SELECT * FROM my_actor;

SELECT 
	a.first_name, a.last_name, COUNT(*)
	INTO TEMPORARY temp_actor -- zaladuj dane do tabeli tymczasowej
FROM actor a
LEFT JOIN film_actor fa ON fa.actor_id = a.actor_id
GROUP BY a.first_name, a.last_name;

SELECT * FROM temp_actor;

SELECT * INTO TEMP temp_actor_2 FROM actor WHERE 1 = 0; -- kopia pustej tabeli z zachowana struktura
SELECT * FROM temp_actor_2;













