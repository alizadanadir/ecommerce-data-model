-- creating dictionary table to store rates for shipping to different country
CREATE TABLE dwh.shipping_country_rates (
    shipping_country_id SERIAL PRIMARY KEY,
    shipping_country VARCHAR(255),
	shipping_country_base_rate DECIMAL(10,4)
);
