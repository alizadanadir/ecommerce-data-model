-- inserting data into dwh.shipping_country_rates table
insert into dwh.shipping_country_rates(shipping_country,shipping_country_base_rate)
select distinct shipping_country, shipping_country_base_rate from public.shipping s;

-- inserting data into dwh.shipping_agreement table 
insert into dwh.shipping_agreement
select distinct 
    cast(SPLIT_PART(vendor_agreement_description, ':', 1) as integer) AS agreementid,
    SPLIT_PART(vendor_agreement_description, ':', 2) AS agreement_number,
    cast(SPLIT_PART(vendor_agreement_description, ':', 3) as decimal(10,2)) AS agreement_rate,
    cast(SPLIT_PART(vendor_agreement_description, ':', 4) as decimal(10,2)) AS agreement_commission from public.shipping s
   order by agreementid;
   
-- inserting data into dwh.shipping_transfer
insert into dwh.shipping_transfer (transfer_type,transfer_model,shipping_transfer_rate)
select distinct
    SPLIT_PART(shipping_transfer_description, ':', 1) AS transfer_type,
    SPLIT_PART(shipping_transfer_description, ':', 2) AS transfer_model,
    shipping_transfer_rate
    from public.shipping s
    
-- inserting data into dwh.shipping_info
insert into dwh.shipping_info
select distinct s.shippingid, s.vendorid, s.payment_amount, s.shipping_plan_datetime, 
scr.shipping_country_id, sa.agreementid, st.transfer_type_id
from public.shipping s
join dwh.shipping_country_rates scr on s.shipping_country = scr.shipping_country
join dwh.shipping_agreement sa on cast(SPLIT_PART(s.vendor_agreement_description, ':', 1) as integer) = sa.agreementid
join dwh.shipping_transfer st on SPLIT_PART(s.shipping_transfer_description, ':', 1) = st.transfer_type 
and SPLIT_PART(s.shipping_transfer_description, ':', 2) = st.transfer_model;

-- inserting data into dwh.shipping_status
insert into dwh.shipping_status
with latest_state as (
select 
shippingid, 
status, state, row_number () over(partition by shippingid order by state_datetime desc) rn
from public.shipping s),

booked as (
select shippingid, state_datetime as shipping_start_fact_datetime
from public.shipping s where state = 'booked'),

recieved as (
select shippingid, state_datetime as shipping_end_fact_datetime
from public.shipping s where state = 'recieved')

select l.shippingid, l.status, l.state, b.shipping_start_fact_datetime, r.shipping_end_fact_datetime 
from latest_state l
left join booked b on l.shippingid = b.shippingid
left join recieved r on l.shippingid = r.shippingid
where l.rn = 1;