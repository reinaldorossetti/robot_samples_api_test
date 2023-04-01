*** Settings ***
Resource        ../support/imports_api.robot

*** Keywords ***
Given I start the session
    Create Session    ${SESSION}    ${HOST_BASE}    headers=${HEADER}    disable_warnings=True

Setting the parameters for city weather test
    &{params}=    Create Dictionary    q=${city}    appid=${API_KEY}
    Set Global Variable    &{params}

Setting session to weather using GET method
    ${RESPONSE}=    GET On Session    ${SESSION}    ${WEATHER_ENDPOINT}    params=${params}    headers=${HEADER}
    Set Test Variable    ${RESPONSE}

Setting session to weather using POST method
    ${RESPONSE}=    POST On Session    ${SESSION}    ${WEATHER_ENDPOINT}    params=${params}    headers=${HEADER}
    Set Test Variable    ${RESPONSE}

Then validating the Response's success data
    Should Not Be Empty    ${RESPONSE.json()}
    Dictionary Should Contain Item    ${RESPONSE.json()["sys"]}    country    ${COUNTRY}
    Dictionary Should Contain Item    ${RESPONSE.json()}    coord    ${COORDINATES}
    Dictionary Should Contain Item    ${RESPONSE.json()}    name    ${CITY}
    Should Be Equal As Strings    ${RESPONSE.status_code}    ${STATUS_ESPERADO}

Then expect API response will be code
    [Arguments]    ${STATUS_CODE}
    Should Be Equal As Strings    ${RESPONSE.status_code}    ${STATUS_CODE}

Then validating the Response's success country
    Dictionary Should Contain Item    ${RESPONSE.json()["temp"]}    country    ${COUNTRY}

Setting the parameters for weather test by id
    &{params}=    Create Dictionary    id=${ID_CITY}    appid=${API_KEY}
    Set Global Variable    &{params}

Setting the parameters for weather by longitude and latitude
    &{params}=    Create Dictionary    lat=${LATITUDE}    lon=${LONGITUDE}    appid=${API_KEY}
    Set Global Variable    &{params}

Setting the parameters for weather by zip code us
    &{params}=    Create Dictionary    zip=${ZIP_CODE_US}    appid=${API_KEY}
    Set Global Variable    &{params}

Setting the parameters for weather by cities within a rectangle zone
    &{params}=    Create Dictionary    bbox=${BBOX}    appid=${API_KEY}
    Set Global Variable    &{params}

Setting the parameters for weather by cities in circle
    &{params}=    Create Dictionary    lat=${LATITUDE}    lon=${LONGITUDE}    cnt=${CNT}    appid=${API_KEY}
    Set Global Variable    &{params}

Setting the parameters for multilingual support
    &{params}=    Create Dictionary    id=${ID_CITY}    lang=${LANGUAGE}    appid=${API_KEY}
    Set Global Variable    &{params}

Setting the parameters for call back support
    &{params}=    Create Dictionary    q=${city}    callback=test    appid=${API_KEY}
    Set Global Variable    &{params}

When send a request about Units of measurement
    [Arguments]    ${UNITS}
    &{params}=    Create Dictionary    q=${city}    units=${UNITS}    appid=${API_KEY}
    Setting session to weather using GET method

When send a request within invalid api key
    &{params}=    Create Dictionary    q=${city}    appid=${API_KEY_INCORRETA}
    ${RESPONSE}=    Post On Session
    ...    ${SESSION}
    ...    ${WEATHER_ENDPOINT}
    ...    params=${params}
    ...    headers=${HEADER}
    ...    expected_status=any
    Set Test Variable    ${RESPONSE}

When send a request about weather by zip code wrong
    &{params}=    Create Dictionary    zip=${ZIP_CODE_FAIL}    appid=${API_KEY}
    ${RESPONSE}=    POST On Session
    ...    ${SESSION}
    ...    ${WEATHER_ENDPOINT}
    ...    params=${params}
    ...    headers=${HEADER}
    ...    expected_status=any
    Set Test Variable    ${RESPONSE}

Then validate error message for invalid api key
    Dictionary Should Contain Item    ${RESPONSE.json()}    message    ${MSN_INVALID_KEY}
