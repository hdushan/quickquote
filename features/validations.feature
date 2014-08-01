Feature: Validate age for generating quote

  Scenario Outline: View validation error when incorrect values are entered for age
    Given I am on the SydneyTesters Life Insurance page
    When I submit my '<age>' with incorrect values 
    Then I should see an error message that the 'The age is required'

    Examples:
      |  age |
      |  gh  |
      |  JH  |
      |  !!  |
      |  *a  |
      |  @g  |
      |  \\  |
  
  Scenario Outline: Email validation for invalid emails
    Given I am on the SydneyTesters Life Insurance page
    When I enter an invalid email '<invalid_email_address>'
    Then I should see an error message that the 'email is not valid'

    Examples:
      |  invalid_email_address |
      |  hans@gmail            |
      |  @gmail.com            |
      |  hans                  |
      |  hans.com              |

  Scenario: Email validation for valid email
    Given I am on the SydneyTesters Life Insurance page
    When I enter a valid email 'hans@gmail.com'
    Then I should not see an error message that the 'email is not valid'