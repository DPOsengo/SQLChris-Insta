--TIMESTAMP pour la date de création et de modification en donnant des valeurs par défaut
--user (last_name, first_name, username, email / phone_number, password, avatar, bio)
CREATE TABLE IF NOT EXISTS utilisateur (
	id SERIAL PRIMARY KEY,
	last_name VARCHAR(50) NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	username VARCHAR(50) UNIQUE NOT NULL,
	email VARCHAR(50) UNIQUE,
	phone_number VARCHAR(20) UNIQUE,
	password VARCHAR(40) NOT NULL,
	avatar VARCHAR(250),
	bio TEXT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	CHECK(phone_number IS NOT NULL OR email IS NOT NULL)
);

--posts(photos/videos) (url, legende(text), latitude([-90,90]) ou null, longiture([-180,-180]) ou null)
CREATE TABLE IF NOT EXISTS post(
	id SERIAL PRIMARY KEY,
	url VARCHAR(500) NOT NULL,
	legende TEXT,
	latitude DOUBLE PRECISION CHECK(latitude IS NULL OR (latitude >= -90 AND latitude <= 90)),
    longitude DOUBLE PRECISION CHECK(longitude IS NULL OR (longitude >= -180 AND longitude <= 180)),
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	utilisateur_id INTEGER REFERENCES utilisateur(id) ON DELETE RESTRICT
);
--comments 
CREATE TABLE IF NOT EXISTS comment(
	id SERIAL PRIMARY KEY,
	comments TEXT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	utilisateur_id INTEGER REFERENCES utilisateur(id) ON DELETE RESTRICT,
	post_id INTEGER REFERENCES post(id) ON DELETE CASCADE
);
--like pour les posts et les comments
CREATE TABLE IF NOT EXISTS likes(
	id SERIAL PRIMARY KEY,
	utilisateur_id INTEGER REFERENCES utilisateur(id) ON DELETE RESTRICT,
	post_id INTEGER REFERENCES post(id) ON DELETE CASCADE,
	comment_id INTEGER REFERENCES comment(id) ON DELETE RESTRICT
);
--following d'autres users(UNIQUE)
CREATE TABLE IF NOT EXISTS follower(
	id SERIAL PRIMARY KEY,
	utilisateur_id INTEGER REFERENCES utilisateur(id) ON DELETE RESTRICT,
	follower_id INTEGER REFERENCES utilisateur(id) ON DELETE RESTRICT,
    UNIQUE (utilisateur_id, follower_id)
);