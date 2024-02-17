# Online shopping data model
Creating a data model for online shopping platform

---

The goal of the project is to perform migration of the transactional log data into separate logical tables, and then build a data model based on them. This will help optimize the load on the storage and allow analysts, tasked with analyzing business efficiency and profitability, to answer specific questions about vendor tariffs, delivery costs to different countries, and the number of delivered orders in the last week. Searching for this data in the original delivery logs table would be suboptimal, leading to complex queries and potential errors.

An order in an online store consists of purchased items and their quantities. Customers are accustomed to receiving their orders at once, so each order from the set of items forms a single delivery entity.

It's crucial for an online store to see that delivery deadlines are met, and its cost corresponds to the tariffs. The store pays for delivery on its own, and the delivery cost varies depending on the country. This is the base amount that the vendor takes into account. Additionally, based on the agreement, the vendor receives additional profit through a commission.

However, currently, this data is stored in a single table, **shipping** (_attached the **shipping.csv** file for the simplicity_), where there is a lot of duplicating and unsystematized reference information. Essentially, it contains the entire delivery log from the moment of order placement to handing over the order to the customer.

---

![image](https://github.com/alizadanadir/ecommerce-data-model/assets/81812348/3e32f50c-e5db-4946-953a-17310a071b12)

---

Given the log **shipping** table it represents a sequence of delivery actions, listed below:

+ ```shippingid```: Unique identifier for the delivery.
+ ```saleid```: Unique identifier for the order. Multiple shippingid entries may be associated with one order, representing different delivery logs.
+ ```vendorid```: Unique identifier for the vendor. Multiple saleid and delivery entries can be linked to a single vendor.
+ ```payment```: Payment amount (redundant information).
+ ```shipping_plan_datetime```: Planned delivery date.
+ ```status```: Delivery status for the given shippingid. Can be either "in_progress" (delivery in progress) or "finished" (delivery completed).
+ ```state```: Intermediate order points that change over time based on the update of delivery information. state_datetime indicates the time of state update. Possible states include:
    + booked
    + fulfillment
    + queued
    + transition
    + pending
    + received
    + returned
+ ```state_datetime```: Time of the order state update.
+ ```shipping_transfer_description```: String with transfer_type and transfer_model values separated by a colon (e.g., "1p:car").
    + transfer_type: Delivery type. "1p" means the company takes responsibility for delivery, while "3p" means the vendor is responsible for shipping.
    + transfer_model: Delivery model, indicating the method by which the order is delivered: car, train, ship, airplane, multiple.
+ ```shipping_transfer_rate```: Percentage of the delivery cost for the vendor based on the type and model of delivery. This fee is charged by the online store to cover expenses.
+ ```shipping_country```: Delivery country, considering the tariff description for each country.
+ ```shipping_country_base_rate```: Delivery tax in the country, expressed as a percentage of the payment_amount cost.
+ ```vendor_agreement_description```: String containing agreementid, agreement_number, agreement_rate, and agreement_commission recorded with a colon separator (e.g., "12:vsp-34:0.02:0.023").
    + agreementid: Agreement identifier.
    + agreement_number: Agreement number in accounting.
    + agreement_rate: Tax rate for the delivery cost of the product for the vendor.
    + agreement_commission: Commission, representing the company's share of the transaction payment.

 ---

The shipping_datamart view based on existing tables for analytics that includes the following fields:

* ```shippingid``` — unique identifier for the delivery.
* ```vendorid``` — unique identifier for the vendor.
* ```transfer_type``` — delivery type from the shipping_transfer table
* ```full_day_at_shipping``` — the number of full days the delivery lasted. 
* ```is_delay``` — a status indicating whether the delivery is delayed. 
* ```is_shipping_finish``` — a status indicating whether the delivery is finished. 
* ```delay_day_at_shipping``` — the number of days the delivery was delayed. 
* ```payment_amount``` — the user's payment amount.
* ```vat``` — the total tax on delivery. 
* ```profit``` — the company's total income from the delivery.

---

Text


 
