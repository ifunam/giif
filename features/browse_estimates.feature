Feature: Browse Estimate Requests
So that I can fill a basic order request with some products and providers, this will be sent to our providers
As an academic (salva user)
I want to save and send the order request of products to our providers, including quantity, description and category for each product

Scenario: Add order with products and providers
	Given a order request
	When I add products and providers
	Then my order should be saved into database
