Feature: Manage The Store
  In order to fulfill customer orders
  A barista
  Should be able to configure store settings

  # if one 'normal' setting works, the rest likely will as well.
  Scenario: Open the store
    Given the store is closed
    When I go to store settings page
    When I edit "status"
    Then "status" should be modified