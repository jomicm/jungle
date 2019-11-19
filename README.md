# 🦁 Jungle

A mini e-commerce application built with Rails 4.2 for purposes of teaching Rails by example.
You are able to edit/add products and categories from and admin panel. Users can also register and login.
It includes testing Stripe API so you can create testing transactions.

## Application screens

#### Welcome to the Jungle!
![Welcome](/docs/main_page.gif)

#### Add products to the cart
![Add-To-Cart](/docs/add_cart.gif)

#### Login Users
![Login-Users](/docs/login.gif)

#### Create New Products as Admin
![Create-New-Products](/docs/new_product.gif)

## Getting Started

1. Fork/Clone this repository.
2. Run `bundle install` to install dependencies
3. Create `config/database.yml` by copying `config/database.example.yml`
4. Create `config/secrets.yml` by copying `config/secrets.example.yml`
5. Run `bin/rake db:reset` to create, load and seed db
6. Create .env file based on .env.example
7. Sign up for a Stripe account
8. Put Stripe (test) keys into appropriate .env vars
9. Run `bin/rails s -b 0.0.0.0` to start the server

## Running RSpec Test Framework
```sh
bin/rspec spec/...
```

## Stripe Testing

Use Credit Card # 4111 1111 1111 1111 for testing success scenarios.

More information in their docs: <https://stripe.com/docs/testing#cards>

## Dependencies

* Rails 4.2 [Rails Guide](http://guides.rubyonrails.org/v4.2/)
* PostgreSQL 9.x
* Stripe
