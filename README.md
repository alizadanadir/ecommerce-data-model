# Online shopping data model
Creating a data model for online shopping platform
---
![image](https://github.com/alizadanadir/ecommerce-data-model/assets/81812348/3e32f50c-e5db-4946-953a-17310a071b12)
---

The goal of the project is to perform migration of the transactional log data into separate logical tables, and then build a data model based on them. This will help optimize the load on the storage and allow analysts, tasked with analyzing business efficiency and profitability, to answer specific questions about vendor tariffs, delivery costs to different countries, and the number of delivered orders in the last week. Searching for this data in the original delivery logs table would be suboptimal, leading to complex queries and potential errors.

An order in an online store consists of purchased items and their quantities. Customers are accustomed to receiving their orders at once, so each order from the set of items forms a single delivery entity.

It's crucial for an online store to see that delivery deadlines are met, and its cost corresponds to the tariffs. The store pays for delivery on its own, and the delivery cost varies depending on the country. This is the base amount that the vendor takes into account. Additionally, based on the agreement, the vendor receives additional profit through a commission.

However, currently, this data is stored in a single table, 'shipping', where there is a lot of duplicating and unsystematized reference information. Essentially, it contains the entire delivery log from the moment of order placement to handing over the order to the customer.
---
