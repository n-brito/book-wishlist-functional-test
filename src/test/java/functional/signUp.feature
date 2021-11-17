Feature: Create a new user

  Background:
    * url 'http://localhost:8081'
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'

  Scenario: Creates a new user and return an error if it already exists
    Given path 'signup'
    And request { "username":"Testando", "password":"1234" }
    When method post
    Then status 201
    * print response
    And match response.username == "Testando"
    And match response.password != "1234"

  Scenario: Cannot create user with invalid username 
    Given path 'signup'
    And request { "username":"", "password":"1234" }
    When method post
    Then status 400
    * print response
    And match response contains {"field":"username","error":"size must be between 4 and 15"}
    And match response contains {"field":"username","error":"Username must be between 4 to 15 characters and not be blank"}

  Scenario: Cannot create user with invalid password 
    Given path 'signup'
    And request { "username":"Testando", "password":"" }
    When method post
    Then status 400
    * print response
    And match response contains {"field":"password","error":"size must be between 4 and 15"}
    And match response contains {"field":"password","error":"Password must be between 4 to 15 characters and not be blank"}