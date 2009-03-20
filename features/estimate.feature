Feature: Saving and sending estimates requests

So that I can fill a basic order request with some products and providers, this will be sent to our providers
As an academic (salva user)
I want to save and send the order request of products to our providers, including quantity, description and category for each product

Scenario: Save the basic order with a set of products and a set of providers
	
	Given a basic order with a set of product and a set of providers
	When I save the order this will use the default status
	Then the order status should be "Sin Enviar" 
	When I sent the order to our providers
	Then the order status should be "Cotizaciones en progreso" 
