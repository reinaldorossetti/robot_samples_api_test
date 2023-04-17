*** Settings ***
Resource        ../global_variables.robot
Library         ./libraries/baseTests.py

*** Keywords ***

Get Json
    [Arguments]        ${file_name} 
    ${dados}           Load Json From File	        ${PATH_FEATURES}/${file_name}
    [Return]           ${dados}

Get Json Schema
    [Arguments]            ${file_name} 
    ${schema_binary}       Get Binary File	        ${PATH_FEATURES}/${file_name}
    ${schema}              evaluate    json.loads('''${schema_binary}''')    json
    [Return]               ${schema}

Update JSON
    [Arguments]        ${file_name}    ${Chave}    ${New_Value}
    [Documentation]    Ler o arquivo Json, atualiza com a nova informação e seta a variavel ${DATA}
    ...                faz uso do https://robotframework-thailand.github.io/robotframework-jsonlibrary/JSONLibrary.html
    ...    
    ${DATA}              Load Json From File	        ${PATH_DATA}/${file_name}
    ${DATA}              Set To Dictionary    ${DATA}   ${Chave}=${New_Value}
    Dump JSON To File    ${PATH_DATA}/${file_name}    ${DATA}
    Set Suite Variable   &{DATA}
