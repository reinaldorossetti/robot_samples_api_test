*** Settings ***
Resource        ../resources/imports_api.robot

Force Tags      api_tests
Suite Setup     Given I start the session

*** Test Cases ***
Checking the weather by city
    [Tags]    weather_by_city
    When send a request about the city weather
    Then validating the Response's success data

Checking the weather by id
    [Tags]    weather_by_id
    When send a request about the city weather by id
    Then validating the Response's success data

Checking weather by longitude and latitude
    [Tags]    weather_long_lati
    When send a request about weather by longitude and latitude
    Then validating the Response's success data

Checking weather by zip code
    [Tags]    weather_zipcod
    When send a request about weather by zip code us
    Then expect API response will be code    200

Checking weather by not found zip code
    [Tags]    weather_zipcode_fail
    When send a request about weather by zip code wrong
    Then expect API response will be code    404

Checking cities within a rectangle zone
    [Tags]    weather_rectangle_zone
    When send a request about cities within a rectangle zone
    Then expect API response will be code    200

Checking cities in circle
    [Tags]    cities_circle
    When send a request about weather by cities in circle
    Then expect API response will be code    200

Checking multilingual support
    [Tags]    multilingual
    When send a request about multilingual support
    Then expect API response will be code    200

Checking Call back function
    [Tags]    call_back
    When send a request about call back support
    Then expect API response will be code    200

Checking Units of measurement - For temperature in Fahrenheit use units=imperial
    [Tags]    units_imperial
    When send a request about Units of measurement    imperial
    Then expect API response will be code    200

Checking Units of measurement - For temperature in Celsius use units=metric
    [Tags]    units_metric
    When send a request about Units of measurement    metric
    Then expect API response will be code    200

Checking Units of measurement - For temperature in Kelvin use units=standard
    [Tags]    units_standard
    When send a request about Units of measurement    standard
    Then expect API response will be code    200

Search weather data by city name with invalid api key
    [Tags]    api_key_invalid
    When send a request within invalid api key
    Then validate error message for invalid api key
