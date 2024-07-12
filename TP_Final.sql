CREATE TABLE IF NOT EXISTS user(
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	user_name VARCHAR(50) NOT NULL,
	email VARCHAR(50) UNIQUE,
	phone_number VARCHAR(30),
	password VARCHAR(150) NOT NULL,
	avatar VARCHAR(200),
	bio TEXT
	CHECK (email IS NOT NULL OR phone_number IS NOT NULL)
);

CREATE TABLE IF NOT EXISTS photos(
	id SERIAL PRIMARY KEY,
	url VARCHAR (255),
	latitude DECIMAL(10,10),
	longitude DECIMAL(10,10),
	records TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	recors_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS follower(
	id SERIAL PRIMARY KEY,
	follower_id
	use_name UNIQUE REFERENCES user(id)
);


