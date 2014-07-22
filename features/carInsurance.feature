Feature: View Premium for Quote

  @javascript
  Scenario Outline: View correct premium for different combinations of age, gender, state etc
    Given I am on the SydneyTesters Car Insurance page
    When I submit my  details '<age>', '<gender>', '<state>' & '<make>' for a car insurance quote
    Then I should see the correct '<premium>' shown

    Examples:
      |  age |  gender  |  state             | make             |  premium  |
      |  23  |  male    |  New South Wales   | BMW              |  $55.54   |
      |  70  |  female  |  Victoria          | Alfa Romeo       |  $137.51  |
      |  75  |  male    |  Tasmania          | Lexus            |  $229.38  |
      |  100 |  female  |  Queensland        | Audi             |  $230.8   |
      |  18  |  female  |  Western Australia | BMW              |  $51.73   |
      |  37  |  male    |  South Australia   | Lexus            |  $103.80  |