# Задание 2. Теория баз данных

## 1. Установка PostgreSQL через Docker

> Я использую macOS и Docker для работы с базой данных.

```bash
# Скачивание и запуск контейнера PostgreSQL
docker run --name pg-academy -e POSTGRES_PASSWORD=postgres -p 5432:5432 -d postgres
```
<img src="screenshots/docker_run.png" alt="Скачивание и запуск контейнера PostgreSQL" width="700"/>

```bash
# Проверка, что контейнер работает
docker ps
```
<img src="screenshots/docker_ps.png" alt="Проверка, что контейнер работает" width="700"/>

```bash
# Подключение к PostgreSQL
docker exec -it pg-academy psql -U postgres
```
<img src="screenshots/docker_exec.png" alt="Подключение к PostgreSQL" width="300"/>

## 2. Создание базы данных `academy`

```sql
-- Создание базы
CREATE DATABASE academy;
```
<img src="screenshots/create_database.png" alt="Создание базы" width="200"/>

## 3. Создание таблиц (по схеме)

```sql
-- Подключение к базе
\c academy
```
<img src="screenshots/connect_database.png" alt="Подключение к базе данных" width="500"/>

```sql
-- Таблица студентов
CREATE TABLE Students (s_id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL, start_year INT CHECK (start_year >= 1900 AND start_year <= EXTRACT(YEAR FROM CURRENT_DATE)));
```
<img src="screenshots/create_table.png" alt="Создание таблицы студентов" width="700"/>

```sql
-- Таблица курсов
CREATE TABLE Courses (c_no SERIAL PRIMARY KEY, title VARCHAR(100) NOT NULL, hours INT CHECK (hours > 0));
```
<img src="screenshots/create_table_courses.png" alt="Создание таблицы курсов" width="700"/>

```sql
-- Таблица экзаменов
CREATE TABLE Exams (s_id INT REFERENCES Students(s_id), c_no INT REFERENCES Courses(c_no), score INT CHECK (score >= 0 AND score <= 100), PRIMARY KEY (s_id, c_no));
```
<img src="screenshots/create_table_exams.png" alt="Создание таблицы курсов" width="700"/>

> Я пробовала добавить `UNIQUE` на имя студента, но потом поняла, что имена могут повторяться, и убрала. Также пыталась задать `DEFAULT` значение для года, но не получилось.

## 4. Вставка тестовых данных

> Добавляю начальные записи в таблицы, чтобы можно было выполнять SQL-запросы и проверять работу базы данных.

```sql
-- Вставка студентов:
INSERT INTO Students (name, start_year) VALUES ('Alice', 2020), ('Bob', 2021), ('Charlie', 2022);

-- Вставка курсов:
INSERT INTO Courses (title, hours) VALUES ('Mathematics', 100), ('History', 80);

-- Вставка экзаменов:
INSERT INTO Exams (s_id, c_no, score) VALUES (1, 1, 85), (1, 2, 90), (2, 1, 75); -- Вывод для экзаменов:
```
<img src="screenshots/create_insert.png" alt="Добавление сутеднтов, курсов, экзаменов" width="700"/>

## 5. Запрос: студенты без экзаменов

> Решила использовать подзапрос с `NOT IN`, так как он короче, чем `LEFT JOIN ... WHERE IS NULL`, и тоже работает.

```sql
SELECT * FROM Students WHERE s_id NOT IN (SELECT s_id FROM Exams);
```
<img src="screenshots/select_students_without_exams.png" alt="Запрос: студенты без экзаменов" width="500"/>

## 6. Запрос: студенты и количество сданных экзаменов

```sql
SELECT name, COUNT(c_no) AS exam_count FROM Students s JOIN Exams e ON s.s_id = e.s_id GROUP BY name HAVING COUNT(c_no) > 0;
```
<img src="screenshots/select_students_with_exams.png" alt="Запрос: студенты и количество сданных экзаменов" width="700"/>


## 7. Запрос: курсы и средний балл, по убыванию

```sql
SELECT title, AVG(score) AS avg_score FROM Courses c JOIN Exams e ON c.c_no = e.c_no GROUP BY title ORDER BY avg_score DESC;
```
<img src="screenshots/select_title_courses.png" alt="Запрос: курсы и средний балл, по убыванию" width="700"/>

## 8*. Генерация данных вручную (псевдослучайно)

> Здесь я вручную сгенерировала уникальные комбинации `s_id` и `c_no`, чтобы избежать конфликтов с PRIMARY KEY.

```sql
-- Вставка студентов:
INSERT INTO Students (name, start_year) VALUES 
('Alice', 2020), 
('Bob', 2021), 
('Charlie', 2022), 
('Diana', 2023), 
('Eve', 2021);

-- Вставка курсов:
INSERT INTO Courses (title, hours) VALUES 
('Mathematics', 100), 
('History', 80), 
('Biology', 60);

-- Вставка экзаменов:
INSERT INTO Exams (s_id, c_no, score) VALUES 
(1, 1, 85), 
(1, 2, 90), 
(2, 1, 75), 
(3, 3, 88), 
(4, 2, 79);
```
<img src="screenshots/insert_into_students_courses_exams.png" alt="Генерация данных" width="500"/>

## Дамп базы данных

[Скачать academy_dump.sql](./db_dumps/academy_dump.sql)

Для восстановления:

```bash
pg_restore -U postgres -d academy_dump.sql
```
