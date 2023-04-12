*** Settings ***
Resource    weather_keyword.robot
### Behave steps call Keywords.


*** Keywords ***
When send a request about the city weather
    Setting the parameters for city weather test
    Setting session to weather using GET method

When send a request about the city weather by id
    Setting the parameters for weather test by id
    Setting session to weather using GET method

When send a request about weather by longitude and latitude
    Setting the parameters for weather by longitude and latitude
    Setting session to weather using GET method

When send a request about weather by zip code us
    Setting the parameters for weather by zip code us
    Setting session to weather using GET method

When send a request about weather by cities in circle
    Setting the parameters for weather by cities in circle
    Setting session to weather using GET method

When send a request about cities within a rectangle zone
    Setting the parameters for weather by cities within a rectangle zone
    Setting session to weather using GET method

When send a request about multilingual support
    Setting the parameters for multilingual support
    Setting session to weather using GET method

When send a request about call back support
    Setting the parameters for call back support
    Setting session to weather using GET method
