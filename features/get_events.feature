Feature:
  As a user
  So that I can collect all events from other services
  I should be able to fetch my events

  Background:
    Given the following projects exist
      | specifier |
      | project 1 |
      | project 2 |
    And the following events exist
      | order   | event_type  | author  | data        | project_id  |
      | 1       | github      | user1   | 'github 1'  | project 1   |
      | 2       | github      | user2   | 'github 2'  | project 1   |
      | 3       | github      | user1   | 'github 3'  | project 1   |
      | 4       | tracker     | user1   | 'tracker 1' | project 1   |
      | 1       | github      | user3   | 'github 4'  | project 2   |
      | 2       | github      | user3   | 'github 5'  | project 2   |
    And the following users exist
      | token   |
      | user 1  |
      | user 2  |


  Scenario: Get all events from a project
    Given I am user "user 1"
    When I get all events for project "project 1"
    Then I should receive all events belong to "project 1"

  Scenario: Reject request when user is now authorized
    Given I am user "fake user"
    When I get all events for project "project 1"
    Then I should receive an authorization error

  Scenario: Remember user's last activity
    Given I am user "user 1"
    When I get all events for project "project 1"
    Then I should see an activity for "user 1" and "project 1" at order 4

  Scenario: Only get user's latest events
    Given I am user "user 1"
    And there is an activity for "user 1" and "project 1" at order 2
    When I get all events for project "project 1"
    Then I should receive 2 events
    And I should see an activity for "user 1" and "project 1" at order 4
