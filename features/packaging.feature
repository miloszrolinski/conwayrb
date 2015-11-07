Feature: Creating a gem
    rake should succesfully create a .gem file with current version number in it's name

Scenario: Checking the exit code
        When I run 'rake package'
        Then it's exit code should be zero (succesfull)

Scenario: Checking if the file with current version number exists
        When I run 'rake package'
        Then there should exist a .gem file with current version number

