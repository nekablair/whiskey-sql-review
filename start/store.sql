-- CREATE DATABASE whiskey_gamestore; --DON'T FORGET TO ADD INDEX FOR FREQUENTLY USED ITEMS IN A TABLE

-- \c whiskey_gamestore

-- Drop the table if it exists
DROP TABLE IF EXISTS game CASCADE;
-- 1,The Witcher 3: Wild Hunt,30,39.99
-- Create Game Table
-- game_id,engine_id,game_title,quantity,price
CREATE TABLE game (
    game_id INT PRIMARY KEY,
    gaming_engine_id INT NOT NULL, 
    game_title VARCHAR(255) UNIQUE NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(5, 2) NOT NULL
    -- FOREIGN KEY (gaming_engine_id) REFERENCES gaming_engine (gaming_engine_id)
);
-- CREATE INDEX idx_driver_name ON driver(name);
-- '^[A-Z][A-Za-z/d'']*(?:(?: |:))*$' --for game_title regex, still failing The Witcher 3 I believe
-- Insert Sample Data into Game Table
-- '^[A-Z][A-Za-z0-9 _\-:''\\]+$'

ALTER TABLE game ADD CONSTRAINT game_title_format_checker CHECK (game_title ~ '^[A-Z][A-Za-z0-9 _\-:''\\]+$');
ALTER TABLE game ADD CONSTRAINT game_quantity CHECK (quantity > 0 AND quantity < 51);
ALTER TABLE game ADD CONSTRAINT game_price_check CHECK (price > 10 AND price < 60);

\COPY game FROM './data/game.csv' WITH CSV HEADER;


DROP TABLE IF EXISTS action_figure;

-- Create Game Table
CREATE TABLE action_figure (
    action_figure_id SERIAL PRIMARY KEY,
    action_figure_title VARCHAR(30) UNIQUE CHECK (action_figure_title ~ '^[A-Z][a-z]*(?:(?: |-)[A-Z\d][a-z]*)*$'),
    quantity INT NOT NULL CHECK (quantity > 0 AND quantity < 31),
    price DECIMAL(4, 2) CHECK (price BETWEEN 10 AND 30)
);
-- ^[A-Z][a-z]*(?:(?: |-)[A-Z\d][a-z]*)*$
-- Insert Sample Data into Game Table






DROP TABLE IF EXISTS employee CASCADE;

-- Create Game Table
CREATE TABLE employee (
    employee_id SERIAL PRIMARY KEY,
    employee_name VARCHAR(30) NOT NULL CHECK (employee_name ~ '^[A-Za-z ]+$'),
    position VARCHAR(50) CHECK (position IN (
        'Sales Associate', 
        'Store Manager', 
        'Inventory Clerk', 
        'Customer Service Representative', 
        'IT Specialist', 
        'Marketing Coordinator', 
        'Assistant Manager', 
        'Finance Analyst', 
        'Security Officer', 
        'HR Coordinator'
        )
    ),
    salary DECIMAL(7,2) NOT NULL CHECK (salary BETWEEN 31987.20 AND 65000 )
);
CREATE INDEX idx_employee_name ON employee(employee_name);--we will be querying this very often, that's why we are placing an index on it, to make the query faster(the more data you have, the more you want to use the index)
-- Insert Sample Data into Game Table




DROP TABLE IF EXISTS poster;

-- Create Game Table
CREATE TABLE poster (
    poster_id SERIAL PRIMARY KEY,
    poster_title VARCHAR(30) NOT NULL UNIQUE CHECK (poster_title ~ '^[A-Za-z0-9]+(?:[-\s][A-Za-z0-9]+)*$'), --still not working fully erroring out poster title check
    quantity INT CHECK (quantity > 1),
    price DECIMAL(4,2)
);
-- '^[A-Za-z0-9 _-]+$'
-- '^[A-Za-z0-9]+(?:[-\s][A-Za-z0-9]+)*$'
-- '^[A-Z][A-Za-z\-]*([A-Z0-9][a-z]*)*$'

-- Insert Sample Data into Game Table




DROP TABLE IF EXISTS genre CASCADE;

CREATE TABLE genre (
    genre_id BIGINT PRIMARY KEY,
    genre_name VARCHAR(50)
);





DROP TABLE IF EXISTS genre_game CASCADE;

CREATE TABLE genre_game (
    genre_game_id BIGINT PRIMARY KEY,
    game_id INT,
    genre_id INT,
    FOREIGN KEY (game_id) REFERENCES game (game_id),
    FOREIGN KEY (genre_id) REFERENCES genre (genre_id)--for many to one relationship place the foreign key on the many side so it referes back to the one side which is one table
);





DROP TABLE IF EXISTS gaming_engine CASCADE;

CREATE TABLE gaming_engine (
    gaming_engine_id SERIAL PRIMARY KEY,
    engine_name VARCHAR(50)
);




DROP TABLE IF EXISTS social_security CASCADE;

CREATE TABLE social_security (
    social_security_id BIGINT PRIMARY KEY,
    employee_id INT,
    ssn VARCHAR(11),
    FOREIGN KEY (employee_id) REFERENCES employee (employee_id)
);






DROP TABLE IF EXISTS shifts CASCADE;

CREATE TABLE shifts (
    shifts_id BIGINT PRIMARY KEY,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    employee_id INT,
    FOREIGN KEY (employee_id) REFERENCES employee (employee_id)
);

-- \COPY game FROM './data/game.csv' WITH CSV HEADER;
\COPY action_figure FROM './data/action_figure.csv' WITH CSV HEADER;
\COPY employee FROM './data/employee.csv' WITH CSV HEADER;
\COPY poster FROM './data/poster.csv' WITH CSV HEADER;
\COPY genre FROM './data/genre.csv' WITH CSV HEADER;
\COPY genre_game FROM './data/genre_game.csv' WITH CSV HEADER;
\COPY gaming_engine FROM './data/gaming_engine.csv' WITH CSV HEADER;
\COPY social_security FROM './data/social_security.csv' WITH CSV HEADER;
\COPY shifts FROM './data/shifts.csv' WITH CSV HEADER;

ALTER TABLE game ADD CONSTRAINT fk_engine FOREIGN KEY (gaming_engine_id) REFERENCES gaming_engine(gaming_engine_id);
-- FOREIGN KEY (gaming_engine_id) REFERENCES gaming_engine (gaming_engine_id)
