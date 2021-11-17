Feature: Create a new user

  Background:
    * url 'http://localhost:8081'
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'
    * def now = function(){ return java.lang.System.currentTimeMillis() }
    * def signUpJson = read('..\\data\\signUp.json')
    * signUpJson.username = 'user'

  Scenario: Creates a new user and return an error if it already exists
    Given path 'signup'
    And request signUpJson
    When method post
    Then status 201
    * print signUpJson
    * print response
    And match response.user.username == signUpJson.username 

    Given path 'signup'
    And request signUpJson
    When method post
    Then status 400
    * print signUpJson
    * print response
    And match response.status == 400
    And match response.details == "Username already exists"