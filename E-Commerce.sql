CREATE DATABASE ECommercedb;

-- Table for storing brand information

USE ECommercedb;

CREATE TABLE brand (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL,
    brand_logo_url VARCHAR(255)
);


-- Table for organizing products into categories

USE ECommercedb;
CREATE TABLE product_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

-- Table to store product details
USE ECommercedb;
CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    brand_id INT,
    base_price DECIMAL(10,2) NOT NULL,
    category_id INT,
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
    FOREIGN KEY (category_id) REFERENCES product_category(category_id)
);

-- Table to store image URLs for each product
USE ECommercedb;
CREATE TABLE product_image (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    image_type VARCHAR(50),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);


-- Table for storing available color options
USE ECommercedb;
CREATE TABLE color (
    color_id INT AUTO_INCREMENT PRIMARY KEY,
    color_name VARCHAR(50) NOT NULL,
    color_hex CHAR(7)
);

-- Table to categorize sizes
USE ECommercedb;
CREATE TABLE size_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);


-- Table for specific size values
USE ECommercedb;
CREATE TABLE size_option (
    size_option_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT,
    size_value VARCHAR(20),
    FOREIGN KEY (category_id) REFERENCES size_category(category_id)
);


-- Table for individual sellable items 
USE ECommercedb;
CREATE TABLE product_item (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    size_option_id INT,
    color_id INT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (size_option_id) REFERENCES size_option(size_option_id),
    FOREIGN KEY (color_id) REFERENCES color(color_id)
);


-- Table to map a product to its various purchasable versions
USE ECommercedb;
CREATE TABLE product_variation (
    variation_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    variation_type VARCHAR(50),
    variation_value VARCHAR(50),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);


-- Table to group attributes into categories
USE ECommercedb;
CREATE TABLE attribute_category (
    attribute_category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);


-- Table to define attribute types like text, number, or boolean
USE ECommercedb;
CREATE TABLE attribute_type (
    attribute_type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL
);


-- Table to store detailed attributes for each product 
USE ECommercedb;
CREATE TABLE product_attribute (
    attribute_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    attribute_name VARCHAR(100),
    attribute_value VARCHAR(255),
    attribute_category_id INT,
    attribute_type_id INT,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(attribute_category_id),
    FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(attribute_type_id)
);


-- Insert sample brands
INSERT INTO brand (brand_name) VALUES
('Nike'),
('Apple'),
('Samsung'),
('Adidas'),
('Sony'),
('Puma');


-- Insert product categories
INSERT INTO product_category (category_name) VALUES
('Clothing'),
('Electronics'),
('Footwear'),
('Accessories'),
('Home Appliances'),
('Gaming');


-- Insert sample products
INSERT INTO product (product_name, brand_id, category_id, base_price) VALUES
('iPhone 14', 2, 2, 999.99),
('Galaxy S22', 3, 2, 899.99),
('Air Max 90', 1, 3, 120.00),
('PS5 Controller', 5, 6, 70.00),
('Running Shorts', 1, 1, 35.00),
('Smart Watch', 2, 4, 299.99);


-- Insert colors
INSERT INTO color (color_name) VALUES
('Black'),
('White'),
('Red'),
('Blue'),
('Green'),
('Yellow');


-- Insert size categories
INSERT INTO size_category (size_category_name) VALUES
('Clothing Sizes'),
('Shoe Sizes'),
('Watch Sizes'),
('Accessory Sizes'),
('Tech Dimensions'),
('Universal Sizes');


-- Insert  size options (assuming size_category_id from above)
INSERT INTO size_option (size_value, size_category_id) VALUES
('S', 1),
('M', 1),
('L', 1),
('42', 2),
('44', 2),
('XL', 1);


-- Insert  product images
INSERT INTO product_image (product_id, image_url) VALUES
(1, 'images/iphone14.png'),
(2, 'images/galaxys22.jpg'),
(3, 'images/airmax90.jpg'),
(4, 'images/ps5controller.png'),
(5, 'images/runningshorts.jpg'),
(6, 'images/smartwatch.jpg');


-- Insert  product items (SKUs)
INSERT INTO product_item (product_id, sku, price, stock_quantity) VALUES
(1, 'IPH14-BLK', 999.99, 10),
(2, 'GALAXY22-WHT', 899.99, 15),
(3, 'AIRMAX90-RED-42', 120.00, 20),
(4, 'PS5-CONT-BLK', 70.00, 25),
(5, 'SHORTS-M', 35.00, 30),
(6, 'SMARTWATCH-BLU', 299.99, 12);


-- Insert  product variations
INSERT INTO product_variation (product_id, color_id, size_option_id) VALUES
(1, 1, NULL),
(2, 2, NULL),
(3, 3, 4),
(4, 1, NULL),
(5, 4, 2),
(6, 4, NULL);


-- Insert  attribute types
INSERT INTO attribute_type (type_name) VALUES
('Text'),
('Number'),
('Boolean'),
('Date'),
('Image'),
('URL');


-- Insert attribute categories
INSERT INTO attribute_category (category_name) VALUES
('Technical'),
('Physical'),
('Design'),
('Functionality'),
('Material'),
('Compatibility');


-- Insert product attributes
INSERT INTO product_attribute (product_id, attribute_name, attribute_value, attribute_category_id, attribute_type_id) VALUES
(1, 'Battery Life', '24 hours', 1, 1),
(2, 'Resolution', '1080p', 1, 1),
(3, 'Material', 'Leather', 5, 1),
(4, 'Wireless', 'Yes', 4, 3),
(5, 'Fabric', 'Polyester', 5, 1),
(6, 'Water Resistant', 'Yes', 2, 3);


-- Get product name, brand, and category
SELECT p.name AS product_name, b.name AS brand_name, pc.name AS category_name
FROM product p
JOIN brand b ON p.brand_id = b.id
JOIN product_category pc ON p.product_category_id = pc.id;


-- List variations with color and size
SELECT pv.product_id, p.name AS product_name, c.name AS color, so.name AS size
FROM product_variation pv
JOIN product p ON pv.product_id = p.id
JOIN color c ON pv.color_id = c.id
JOIN size_option so ON pv.size_option_id = so.id;


-- Attributes linked to a specific product (e.g., product_id = 1)
SELECT p.name AS product_name, at.name AS attribute_type, pa.value
FROM product_attribute pa
JOIN product p ON pa.product_id = p.id
JOIN attribute_type at ON pa.attribute_type_id = at.id
WHERE p.id = 1;
