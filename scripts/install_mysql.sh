#!/bin/bash

apt update
apt install -y mysql-server

sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

mysql -e "CREATE DATABASE IF NOT EXISTS events_management;"

mysql -D events_management <<EOF
	CREATE TABLE events (
		event_id INT PRIMARY KEY,
		event_name VARCHAR(100),
		event_date DATE,
		location VARCHAR(100),
		capacity INT,
		description TEXT
	);

	INSERT INTO events (event_id, event_name, event_date, location, capacity, description)
	VALUES
		(1, 'Conferenza Tecnologica 2024', '2024-05-15', 'Centro Congressi, Centro Città', 500, 'Un incontro di appassionati e professionisti della tecnologia.'),
		(2, 'Festival d’Arte e Musica', '2024-06-20', 'Parco della Città', 1000, 'Una celebrazione dell\'arte e della musica locale.'),
		(3, 'Expo Salute e Benessere', '2024-07-10', 'Centro Comunitario', 300, 'Scopri prodotti e servizi per la salute e il benessere.');

	CREATE TABLE attendees (
		attendee_id INT PRIMARY KEY,
		name VARCHAR(50),
		email VARCHAR(100),
		phone VARCHAR(15)
	);

	INSERT INTO attendees (attendee_id, name, email, phone)
	VALUES
		(1, 'Alice Rossi', 'alice@example.com', '555-1234'),
		(2, 'Marco Bianchi', 'marco@example.com', '555-5678'),
		(3, 'Chiara Verdi', 'chiara@example.com', '555-8765');

	CREATE TABLE registrations (
		registration_id INT PRIMARY KEY,
		event_id INT,
		attendee_id INT,
		registration_date DATE,
		FOREIGN KEY (event_id) REFERENCES events(event_id),
		FOREIGN KEY (attendee_id) REFERENCES attendees(attendee_id)
	);

	INSERT INTO registrations (registration_id, event_id, attendee_id, registration_date)
	VALUES
		(1, 1, 1, '2024-04-01'),
		(2, 1, 2, '2024-04-02'),
		(3, 2, 3, '2024-05-01'),
		(4, 3, 1, '2024-06-01');

	
	CREATE USER 'alex' IDENTIFIED BY 'alex';
	GRANT ALL PRIVILEGES ON *.* TO 'alex' WITH GRANT OPTION;
	
EOF

systemctl restart mysql
echo "Tabelle create"