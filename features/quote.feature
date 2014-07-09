Feature: View Premium for Quote

  @javascript
  Scenario Outline: View correct premium for different combinations of age, gender, state etc
    Given I am on the SydneyTesters Home page '/'
    When I submit my '<age>', '<gender>', '<state>' & '<occupation>' 
    Then I should see the correct '<premium>' shown

    Examples:
      |  age |  gender  |  state             | occupation       |  premium  |
      |  23  |  male    |  New South Wales   | High Risk        |  $55.54   |
      |  70  |  female  |  Victoria          | Medium Risk      |  $137.51  |
      |  75  |  male    |  Tasmania          | Very High Risk   |  $229.37  |
      |  100 |  female  |  Queensland        | Low Risk         |  $230.8   |
      |  18  |  female  |  Western Australia | High Risk        |  $51.73   |
      |  37  |  male    |  South Australia   | Very High Risk   |  $103.79  |

  @javascript
  Scenario Outline: Email validation for invalid emails
    Given I am on the SydneyTesters Home page '/'
    When I enter an invalid email '<invalid_email_address>'
    Then I should see an error message that the 'email is not valid'

    Examples:
      |  invalid_email_address |
      |  hans@gmail            |
      |  @gmail.com            |
      |  hans                  |
      |  hans.com              |
      
  @javascript
  Scenario: Email validation for valid email
    Given I am on the SydneyTesters Home page '/'
    When I enter a valid email 'hans@gmail.com'
    Then I should not see an error message that the 'email is not valid'