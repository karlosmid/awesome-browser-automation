Feature: Home Page
I shoud land on home page
  Scenario: Land On Home Page
    Given I visit home page
    Then I am on home page
  Scenario: Not Land On Home Page
    Given I visit home page
    Then I am not on home page