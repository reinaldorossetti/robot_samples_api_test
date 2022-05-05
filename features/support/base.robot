*** Settings ***
Library        OperatingSystem
Library        JSONLibrary


*** Keywords ***

Get JSON
    [Arguments]        ${file_name}
    ${file}            Get File        ${EXECDIR}/features/resources/data/${file_name}
    ${dados}           Load Json From File	        ${file} 
    [Return]           ${dados}

Update JSON
    [Arguments]        ${file_name}    ${Chave}    ${Valor}
    ${file_content}            Get File        ${EXECDIR}/features/resources/data/${file_name}
    ${dados}           Update Value To Json		${file_content}     ${Chave}    ${Valor}
    [Return]           ${dados}