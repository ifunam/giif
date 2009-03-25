Feature: Creating a Currency record

In order to create a currency record and save it
As a user not validated
I want to save currency

  Scenario: Save currency and currency_order
    Given a currency with valid params
    When I save currency it will validate params
    Then currency will saved

