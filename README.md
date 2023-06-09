<img width="472" alt="Screen Shot 2023-06-09 at 11 40 37 AM" src="https://user-images.githubusercontent.com/116821829/244740757-08307f16-7c1e-44c1-8c29-0c46605c0c84.png">

# Tea Subscription Service API
This API allows you to manage customers, teas, and subscriptions for a tea subscription service.

## Installation
To install and run this project locally, follow these steps:

## Clone this repository:

Copy code
`git clone https://github.com/davejm8/tea_subscription`

## Change to the application directory:

Copy code
`cd tea_subscription`


Copy code
`bundle install`

## Setup the database:

![Screen Shot 2023-06-09 at 12 11 49 PM](https://user-images.githubusercontent.com/116821829/244747921-d367d9b2-13c0-4b72-9782-90b743cdac89.png)

Copy code

`rails db:create db:migrate`

(Optional) Seed the database with sample data:


Copy code

`rails db:seed`

## Start the local server:

Copy code

`rails server`

## Usage

The API provides several endpoints to manage customers, teas, and subscriptions:

POST /api/v1/customers: Create a new customer

GET /api/v1/customers/:customer_id/subscriptions: Retrieve a list of a customer's subscriptions

POST /api/v1/customers/:customer_id/subscriptions: Create a new subscription for a customer

PATCH /api/v1/customers/:customer_id/subscriptions/:id: Update a subscription for a customer


## Testing

You can run the test suite using the following command:

Copy code
bundle exec rspec


