Feature: Discovery's watch list.

Scenario: Add Two videos to favorite list
  Given I visit Discovery's site
 	And Look for recommended videos
 	When I select any two videos in my favorite list
 	And Navigate to My videos
 	And Look for selected videos
 	Then I should see selected videos
