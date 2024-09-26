  #  Activity
    #Send request to /api/accounts/add-primary-account
    # Status should be 201 and response contain email entity
  @Regression
  Feature: Create Account Feature
    @NewAccount_1
    Scenario: Create new account
      Given url BASE_URL
      Given path "/api/accounts/add-primary-account"
      * def email = "ali.akbar@tekschool.us"
      Given request
        """
        {
          "email": "#(email)",
          "firstName": "Ali",
          "lastName": "Akbar",
          "title": "Mr.",
          "gender": "MALE",
          "maritalStatus": "Single",
          "employmentStatus": "Student",
          "dateOfBirth": "2001-10-15"
        }
        """
      When method post
      Then print response
      Then status 201
      Then assert response.email == email
      * def createdAccountId = response.id
      * def tokenGenerationResult = callonce read('GenerateSupervisorToken.feature')
      * def validToken = "Bearer " + tokenGenerationResult.response.token
      Given path "/api/accounts/delete-account"
      Given param primaryPersonId = createdAccountId
      Given header Authorization = validToken
      When method delete
      Then status 202