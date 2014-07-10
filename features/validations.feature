Feature: Validate age for generating quote

  @javascript
  Scenario Outline: View validation error when incorrect values are entered for age
    Given I am on the SydneyTesters Home page '/'
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