CREATE TABLE person (
    person_id integer IDENTITY,
    first_name varchar(50) NOT NULL,
    last_name varchar(50) NOT NULL,
    email_address varchar(50) NOT NULL,
    street_address varchar(50) NOT NULL,
    city varchar(50) NOT NULL,
    state varchar(2) NOT NULL,
    zip_code varchar(5) NOT NULL,
	client_id integer

--    CONSTRAINT CLIENT_FK FOREIGN KEY (client_id)
--      REFERENCES client (client_id)
--      ON DELETE SET NULL
);

CREATE TABLE client (
    client_id integer IDENTITY,
    name varchar(50) NOT NULL,
    web varchar(50) NOT NULL,
    addr varchar(50) NOT NULL,
    city varchar(50) NOT NULL,
    state varchar(2) NOT NULL,
    zip_code varchar(5) NOT NULL
);
