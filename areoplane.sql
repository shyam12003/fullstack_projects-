CREATE DATABASE SkywingsDB;
USE SkywingsDB;

-- Table for Users
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for Destinations
CREATE TABLE Destinations (
    destination_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL,
    description TEXT,
    rating DECIMAL(3,2) CHECK (rating BETWEEN 0 AND 5),
    image_url VARCHAR(255)
);

-- Table for Bookings
CREATE TABLE Bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    destination_id INT,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    travel_date DATE NOT NULL,
    status ENUM('Pending', 'Confirmed', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (destination_id) REFERENCES Destinations(destination_id) ON DELETE CASCADE
);

-- Table for Packages
CREATE TABLE Packages (
    package_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    destination_id INT,
    price DECIMAL(10,2) NOT NULL,
    description TEXT,
    duration INT CHECK (duration > 0), -- in days
    FOREIGN KEY (destination_id) REFERENCES Destinations(destination_id) ON DELETE CASCADE
);

-- Table for Reviews
CREATE TABLE Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    destination_id INT,
    rating DECIMAL(3,2) CHECK (rating BETWEEN 0 AND 5),
    review_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (destination_id) REFERENCES Destinations(destination_id) ON DELETE CASCADE
);

-- Table for Contact Messages
CREATE TABLE ContactMessages (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    subject VARCHAR(255),
    message TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sample Data for Destinations
INSERT INTO Destinations (name, location, description, rating, image_url) VALUES
('New York City', 'USA', 'Tradition and Futurism', 4.7, 'assets/destination-1.jpg'),
('Paris', 'France', 'The City of Lights', 4.5, 'assets/destination-2.jpg'),
('Bali', 'Indonesia', 'Island of the Gods', 4.8, 'assets/destination-3.jpg');

-- Sample Data for Packages
INSERT INTO Packages (name, destination_id, price, description, duration) VALUES
('Luxury NYC Tour', 1, 1500.00, '5-day guided tour of NYC attractions', 5),
('Romantic Paris Getaway', 2, 2200.00, 'Couples package in Paris with guided tours', 7),
('Bali Adventure', 3, 1800.00, 'Explore Bali with island hopping and cultural experiences', 6);
