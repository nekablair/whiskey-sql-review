-- CREATE DATABASE whiskey_gamestore;

-- \c whiskey_gamestore

-- Drop the table if it exists
-- DROP TABLE IF EXISTS game;

-- -- Create Game Table
-- CREATE TABLE game (
--     game_id INT PRIMARY KEY,
--     game_title VARCHAR(255),
--     quantity INT,
--     price DECIMAL(5, 2)
-- );
-- -- Insert Sample Data into Game Table
-- \COPY game FROM './data/game.csv' WITH CSV HEADER;



DROP TABLE IF EXISTS action_figure;

-- Create Game Table
CREATE TABLE action_figure (
    id SERIAL PRIMARY KEY,
    action_figure_title VARCHAR(30) UNIQUE CHECK (action_figure_title ~ '^[A-Z] [A-Za-z0-9:\-]+$'),
    quantity INT NOT NULL CHECK (quantity > 0 AND quantity < 31),
    price DECIMAL(4, 2) CHECK (price BETWEEN 10 AND 30)
);
-- ^[A-Z][a-z]*(?:(?: |-)[A-Z\d][a-z]*)*$
-- Insert Sample Data into Game Table
\COPY action_figure FROM './data/action_figure.csv' WITH CSV HEADER;



-- DROP TABLE IF EXISTS employee;

-- -- Create Game Table
-- CREATE TABLE employee (
--     id SERIAL PRIMARY KEY,
--     employee_name VARCHAR(30) NOT NULL CHECK ('^[A-Z] [A-Za-z0-9:\-]+$'),
--     position VARCHAR(50) CHECK ('^[A-Z] [A-Za-z0-9:\-]+$'),
--     salary DECIMAL(7,2)
-- );
-- -- Insert Sample Data into Game Table
-- \COPY employee FROM './data/employee.csv' WITH CSV HEADER;



-- DROP TABLE IF EXISTS poster;

-- -- Create Game Table
-- CREATE TABLE poster (
--     id SERIAL PRIMARY KEY,
--     poster_title VARCHAR(30) NOT NULL UNIQUE CHECK ('^[A-Z] [A-Za-z0-9:\-]+$'),
--     quantity INT CHECK (quantity > 1),
--     price DECIMAL(4,2)
-- );


-- -- Insert Sample Data into Game Table
-- \COPY poster FROM './data/poster.csv' WITH CSV HEADER;