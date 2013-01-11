Feature: Manage The Store
  In order to fulfill customer orders
  A barista
  Should be able to configure store settings

  Scenario: Open the store
    Given the store is closed
    When I go to the "StoreConfig" listing page
      And I edit "status"
    Then "status" should be modified