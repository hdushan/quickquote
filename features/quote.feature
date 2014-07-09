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
