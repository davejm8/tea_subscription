Tea Subscription Service API
This API allows you to manage customers, teas, and subscriptions for a hypothetical tea subscription service.

Installation
To install and run this project locally, follow these steps:

Clone this repository:

Copy code
git clone https://github.com/davejm8/tea_subscription

Change to the application directory:
sh
Copy code
cd tea_subscription


Copy code
bundle install

Setup the database:


Copy code

rails db:create db:migrate

(Optional) Seed the database with sample data:


Copy code

rails db:seed

Start the local server:

Copy code

rails server

Usage

The API provides several endpoints to manage customers, teas, and subscriptions:

POST /api/v1/customers: Create a new customer

GET /api/v1/customers/:customer_id/subscriptions: Retrieve a list of a customer's subscriptions

POST /api/v1/customers/:customer_id/subscriptions: Create a new subscription for a customer

PATCH /api/v1/customers/:customer_id/subscriptions/:id: Update a subscription for a customer


Testing

You can run the test suite using the following command:

Copy code
bundle exec rspec


