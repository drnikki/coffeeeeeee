Feature: Manage The Menu
  In order to fulfill customer orders
  A barista
  Should be able to edit menu items

  Scenario: Change the description of a menu item
    Given there is a "MenuItem" called coffee
    When I go to the "MenuItems" listing page
      And I edit "coffee"
    Then "coffee" should be modified