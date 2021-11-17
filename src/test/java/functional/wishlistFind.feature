Feature: Create wishlist

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
    
    #authenticating user
    Given path 'auth'
    And request { "username":"#(username)", "password":"1234" }
    When method post
    Then status 200
    * print response
    And match response.type == "Bearer"
    And match response.token == "#notnull"
    * def token = response.token
    
    # creating wishlist
  	Given path 'wishlist'
    And request { "name":"wishlist to find" }
		And header Authorization = 'Bearer ' + token
    When method post
    Then status 201
    * print response
    And match response.name == "wishlist to find"
    And match response.id == "#notnull"
    * def wishlistId = response.id
    * def wishlistName = response.name
    
  Scenario: Finding wishlist created
  	Given path 'wishlist/' + wishlistId
    #And request { "name":"wishlist" }
		And header Authorization = 'Bearer ' + token
    When method get
    Then status 200
    * print response
    And match response.name == "wishlist to find"
    