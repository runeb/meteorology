Feature: Weather forecast for Ruby objects
  In order to dress properly
  As a Ruby object
  I want to know what the weather will be like

  Scenario: Finding the current temperature
    Given I have a geocoded Ruby class
    And I include Meteorology in the objects class

	When the time is "2009-10-21 12:00"
	And I ask for its current temperature
	Then I should see "4.2 C"
