*** Settings ***
Library        OperatingSystem
Library        JSONLibrary

*** Keywords ***

Get Json
    [Arguments]        ${file_name} 
    ${dados}           Load Json From File	        ${EXECDIR}/features/support/resources/data/${file_name}
    [Return]           ${dados}

Get Json Schema
    [Arguments]            ${file_name} 
    ${schema_binary}       Get Binary File	        ${EXECDIR}/features/support/resources/schemas/${file_name}
    ${schema}              evaluate    json.loads('''${schema_binary}''')    json
    [Return]               ${schema}

Update JSON
    [Arguments]       ${json_object}   ${file_name}    ${Chave}
    ${file_content}            Get File        ${EXECDIR}/features/support/resources/data/${file_name}
    ${dados}           Update Value To Json		${json_object}     ${file_content}     ${Chave}
    [Return]           ${dados}

Update JSON Data
    [Arguments]            ${nome_do_arquivo}              ${dicionario}
    ${dados}=              Convert JSON to string    ${dicionario}
    Create File            ${EXECDIR}/features/support/resources/data/${nome_do_arquivo}    ${dados}