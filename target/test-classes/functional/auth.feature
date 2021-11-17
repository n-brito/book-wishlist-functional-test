Feature: Create user and login

  Background:
    * url 'http://localhost:8081'
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'
    * def now = function(){ return java.lang.System.currentTimeMillis() }
    * def timeNow = call now
    * def username = ("" + timeNow)
    
    #creating user
  	Given path 'signup'
    And request { "username":"#(username)", "password":"1234" }
    When method post
    Then status 201
    * print response
    And match response.username == username
    And match response.password != "1234"


  Scenario: Create user then log in 
  	Given path 'auth'
    And request { "username":"#(username)", "password":"1234" }
    When method post
    Then status 200
    * print response
    And match response.type == "Bearer"
    And match response.token == "#notnull"
    
  Scenario: Dont log in with wrong password
  	Given path 'auth'
    And request { "username":"#(username)", "password":"12345" }
    When method post
    Then status 404
    * print response
    And match response contains { "field": "username or password", "error": "Please check that both the username and password are typed correctly" }
    