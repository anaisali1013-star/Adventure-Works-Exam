-- create table for API data upload

CREATE TABLE holidays_global (
    date DATE,
    local_name VARCHAR(200),
    name VARCHAR(200),
    country_code CHAR(2),
    fixed BOOLEAN,
    global BOOLEAN,
    counties TEXT
);


