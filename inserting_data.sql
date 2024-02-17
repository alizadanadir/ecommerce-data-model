-- inserting data into dwh.shipping_country_rates table
insert into dwh.shipping_country_rates(shipping_country,shipping_country_base_rate)
select distinct shipping_country, shipping_country_base_rate from public.shipping s;