-- creating dictionary table to store rates for shipping to different country
CREATE TABLE dwh.shipping_country_rates (
    shipping_country_id SERIAL PRIMARY KEY,
    shipping_country VARCHAR(255),
	shipping_country_base_rate DECIMAL(10,4)
);

-- creating dictionary table to store delivery tariff guide for the vendors
create table dwh.shipping_agreement (
agreementid integer PRIMARY KEY,
agreement_number VARCHAR(255),
agreement_rate decimal(10,2),
agreement_commission decimal(10,2)
);

-- creating dictionary table to store delivery types and their rates
create table dwh.shipping_transfer (
transfer_type_id SERIAL PRIMARY KEY,
transfer_type VARCHAR(255),
transfer_model VARCHAR(255),
shipping_transfer_rate decimal(10,6)
);

-- creating table with unique shippings
create table dwh.shipping_info (
shippingid INTEGER PRIMARY KEY,
vendorid INTEGER,
payment_amount decimal(14,6),
shipping_plan_datetime timestamp,
shipping_country_id INTEGER,
agreementid INTEGER,
transfer_type_id INTEGER
);

-- creating table with the actual status and state of the shipment
create table dwh.shipping_status (
shippingid INTEGER PRIMARY KEY,
status VARCHAR(255),
state VARCHAR(255),
shipping_start_fact_datetime timestamp,
shipping_end_fact_datetime timestamp
);