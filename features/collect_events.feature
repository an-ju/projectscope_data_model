Feature: collect new events from tools
  As a user
  So that I can present a data model for different tools
  I should be able to collect events from development tools

  Background:
    Given the following projects exist
    | specifier     |
    | test project  |
    And the following resources exist
    | name    | project_id    | meta        |
    | github  | test project  | test/test   |


  Scenario: collect new event
    Given new event from GitHub for test project
    Then I should see the new event added to database

  Scenario: collect multiple events
    Given new event from GitHub for test project
    And new event from GitHub for test project
    Then I should see 2 events in the database of test project
    And event 2 of test project should have priority 2
