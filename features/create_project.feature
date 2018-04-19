Feature: create a new project
  As a user
  So that I can establish a new project to monitor
  I should be able to create a new project through APIs

  Scenario: create new project with complete parameters
    When I create a new project with complete parameters
    Then I should see a new project created