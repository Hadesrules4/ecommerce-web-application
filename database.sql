CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('user','admin') NOT NULL DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    category VARCHAR(100),
    image VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status ENUM('Pending','Processing','Shipped','Delivered','Cancelled')
           NOT NULL DEFAULT 'Pending',
    shipping_address TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE RESTRICT
);

INSERT INTO products (name, description, price, stock, category)
SELECT 'Wireless Headphones', 'Comfortable Bluetooth headphones with clear sound.', 1499.00, 25, 'Electronics'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name='Wireless Headphones');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Smart Watch', 'Fitness tracking smart watch with notifications.', 2499.00, 15, 'Electronics'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name='Smart Watch');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Cotton T-Shirt', 'Comfortable everyday cotton T-shirt.', 599.00, 40, 'Clothing'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name='Cotton T-Shirt');