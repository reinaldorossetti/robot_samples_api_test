*** Settings ***
Library        Collections
Library        FakerLibrary
Library        JSONLibrary
Library        jsonschema
Library        OperatingSystem
Library        RequestsLibrary
Library        JSONSchemaLibrary    ${EXECDIR}/features/specifications

*** Variables ***
${URL}                https://serverest.dev
${ALIAS}              session_serverest
${admin}              true
${usuario}
${TOKEN}
${preco}               470
${descricao}           "Mouse"
${quantidade}          5
${ID_PRODUTO_CADASTRADO}
${produto}


*** Keywords ***

Get Json
    [Arguments]        ${file_name} 
    ${dados}           Load Json From File	        ${EXECDIR}/features/specifications/${file_name}
    [Return]           ${dados}

Get Json Schema
    [Arguments]            ${file_name} 
    ${schema_binary}       Get Binary File	        ${EXECDIR}/features/specifications/${file_name}
    ${schema}              evaluate    json.loads('''${schema_binary}''')    json
    [Return]               ${schema}

Update JSON
    [Arguments]        ${file_name}    ${Chave}    ${New_Value}
    [Documentation]    Ler o arquivo Json, atualiza com a nova informação e seta a variavel ${DATA}
    ...                faz uso do https://robotframework-thailand.github.io/robotframework-jsonlibrary/JSONLibrary.html
    ...    
    ${DATA}              Load Json From File	        ${EXECDIR}/features/specifications/${file_name}
    ${DATA}              Set To Dictionary    ${DATA}    ${Chave}=${New_Value}
    Dump JSON To File    ${EXECDIR}/features/specifications/${file_name}    ${DATA}
    Set Suite Variable   &{DATA}