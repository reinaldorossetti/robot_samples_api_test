*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    FakerLibrary
Library    JSONSchemaLibrary    ${EXECDIR}/features/support/resources/schemas/
Resource        ../../support/base.robot

Suite Setup    Criar a sessao com a api serverest

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

*** Test Cases ***
Testar Listar os Produtos
    [Tags]    ListarProduto
    Cadastrar o usuario de teste
    Efetuar o login
    Cadastrar um Produto
    Listar o produto cadastrado
    
*** Keywords ***
Criar os dados do usuario
    ${nome}=         FakerLibrary.Name
    ${email}=        FakerLibrary.Email
    ${password}=     FakerLibrary.Password
    ${usuario}=      Create Dictionary    nome=${nome}    email=${email}    password=${password}   administrador=${admin}
    Set Suite Variable    ${usuario}
    Log       ${usuario} 

Criar a sessao com a api serverest
    Criar os dados do usuario
    ${HEADER}=    Create Dictionary        Content-Type=application/json
    Create Session    ${ALIAS}    url=${URL}    headers=${HEADER}    disable_warnings=1

Cadastrar o usuario de teste
    ${RESPONSE}=    POST On Session        ${ALIAS}    json=${usuario}    url=${URL}/usuarios
    Log        Resposta Retornada: ${RESPONSE.json()}
    Log To Console     Resposta Retornada: ${RESPONSE.json()}
    Request Should Be Successful
    Status Should Be                  201        ${RESPONSE}
    Should Be Equal As Strings        Created    ${RESPONSE.reason}
    Should Be Equal                   ${RESPONSE.status_code}      ${201}
    Should Not Be Empty               ${RESPONSE.json()}
    Should Be Equal As Strings        ${RESPONSE.headers["Content-Type"]}    application/json; charset=utf-8
    Should Contain                    ${RESPONSE.headers["Content-Type"]}    application/json
    Dictionary Should Contain Item    ${RESPONSE.json()}     message   Cadastro realizado com sucesso
    ${count_id}=    Get length        ${RESPONSE.json()["_id"]}
    should be equal as numbers        ${count_id}                  16
    Length Should Be                  ${RESPONSE.json()["_id"]}    16
    ${ID_PRODUTO_CADASTRADO}          Get From Dictionary    ${RESPONSE.json()}    _id
    Set Suite Variable                ${ID_PRODUTO_CADASTRADO}
    Log                Resposta ID: ${ID_PRODUTO_CADASTRADO}
    Log To Console     Resposta ID: ${ID_PRODUTO_CADASTRADO}
    Validate Json        user.json        ${RESPONSE.json()}  

Efetuar o login
    ${BODY}=    Create Dictionary     email=${usuario.email}    password=${usuario.password}
    ${RESPONSE}=    POST On Session        ${ALIAS}    json=${BODY}    url=${URL}/login
    Log                Resposta : ${RESPONSE}
    Log To Console     Resposta : ${RESPONSE}
    Request Should Be Successful
    Dictionary Should Contain Item    ${RESPONSE.json()}     message   Login realizado com sucesso
    Should Not Be Empty    ${RESPONSE.json()["authorization"]}
    ${TOKEN}          Get From Dictionary    ${RESPONSE.json()}    authorization
    Set Suite Variable                ${TOKEN}

Cadastrar um Produto
    ${produto}=           FakerLibrary.City
    Set Suite Variable    ${produto} 
    Log To Console        Token : ${TOKEN}
    ${BODY}=            Create Dictionary     nome=${produto}    preco=${preco}    descricao=${descricao}    quantidade=${quantidade}  
    ${HEADERS}=         Create Dictionary    Authorization=${TOKEN}
    ${RESPONSE}=        POST On Session        ${ALIAS}    json=${BODY}    url=produtos    headers=${HEADERS}
    Log                Resposta : ${RESPONSE}
    Request Should Be Successful
    Dictionary Should Contain Item    ${RESPONSE.json()}     message   Cadastro realizado com sucesso
    Length Should Be                  ${RESPONSE.json()["_id"]}    16
    ${ID_PRODUTO_CADASTRADO}  Get From Dictionary    ${RESPONSE.json()}    _id
    Set Suite Variable   ${ID_PRODUTO_CADASTRADO}

Listar o produto cadastrado
    ${HEADERS}=         Create Dictionary    Authorization=${TOKEN}
    ${PARAMS}=          Create Dictionary    _id=${ID_PRODUTO_CADASTRADO}
    ${RESPONSE}=            GET On Session      ${ALIAS}    url=produtos    headers=${HEADERS}   params=${PARAMS}
    Log                Resposta : ${RESPONSE}
    Request Should Be Successful
    Dictionary Should Contain Item    ${RESPONSE.json()["produtos"][0]}     nome           ${produto}
    Dictionary Should Contain Item    ${RESPONSE.json()["produtos"][0]}     preco          ${preco}
    Dictionary Should Contain Item    ${RESPONSE.json()["produtos"][0]}     descricao      ${descricao} 
    Dictionary Should Contain Item    ${RESPONSE.json()["produtos"][0]}     quantidade     ${quantidade}
    Dictionary Should Contain Item    ${RESPONSE.json()["produtos"][0]}     _id     ${ID_PRODUTO_CADASTRADO}
