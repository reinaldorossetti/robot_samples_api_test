*** Settings ***
Resource        ../feature_variables.robot

*** Keywords ***
Criar Os Dados Do Usuario
    ${Email}          FakerLibrary.email
    ${Name}           FakerLibrary.name
    Update JSON       user_body.json    email    ${Email}
    Update JSON       user_body.json    nome     ${Name}

Criar A Sessao Com A Api Serverest
    Criar os dados do usuario
    ${HEADER}=    Create Dictionary        Content-Type=application/json
    Create Session    ${ALIAS}    url=${URL}    headers=${HEADER}    disable_warnings=1

Cadastrar o usuario de teste
    ${RESPONSE}=    POST On Session        ${ALIAS}    json=${DATA}    url=/usuarios
    Log        Resposta Retornada: ${RESPONSE.json()}    level=DEBUG
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
    Validate Json By Schema File      ${RESPONSE.json()}     ${PATH_SCHEMA}/user_schema.json     

Efetuar o login
    ${BODY}=    Create Dictionary     email=${DATA.email}    password=${DATA.password}
    ${RESPONSE}=    POST On Session        ${ALIAS}    json=${BODY}    url=${URL}/login
    Log                Resposta : ${RESPONSE.json()}    level=DEBUG
    Request Should Be Successful
    Dictionary Should Contain Item    ${RESPONSE.json()}     message   Login realizado com sucesso
    Should Not Be Empty    ${RESPONSE.json()["authorization"]}
    ${TOKEN}          Get From Dictionary    ${RESPONSE.json()}    authorization
    Set Suite Variable             ${TOKEN}
    Validate Json Schema           ${PATH_SCHEMA}/login.json        ${RESPONSE.json()}         

Cadastrar um Produto
    ${produto}            FakerLibrary.company
    Set Suite Variable    ${produto} 
    ${BODY}=            Create Dictionary     nome=${produto}    preco=${preco}    descricao=${descricao}    quantidade=${quantidade}  
    ${HEADERS}=         Create Dictionary    Authorization=${TOKEN}
    ${RESPONSE}=        POST On Session        ${ALIAS}    json=${BODY}    url=produtos    headers=${HEADERS}
    Log                Resposta : ${RESPONSE}    level=DEBUG
    Request Should Be Successful
    Dictionary Should Contain Item    ${RESPONSE.json()}     message   Cadastro realizado com sucesso
    Length Should Be                  ${RESPONSE.json()["_id"]}    16
    ${ID_PRODUTO_CADASTRADO}  Get From Dictionary    ${RESPONSE.json()}    _id
    Set Suite Variable   ${ID_PRODUTO_CADASTRADO}
    Log                Resposta : ${RESPONSE.json()}    level=DEBUG
    Log To Console     Resposta : ${RESPONSE.json()}    STDERR
    Validate Json Schema          ${PATH_SCHEMA}/produto.json      ${RESPONSE.json()}

Listar o produto cadastrado
    ${HEADERS}=             Create Dictionary    Authorization=${TOKEN}
    ${PARAMS}=              Create Dictionary    _id=${ID_PRODUTO_CADASTRADO}
    ${RESPONSE}=            GET On Session      ${ALIAS}    url=produtos    headers=${HEADERS}   params=${PARAMS}
    Log                Resposta : ${RESPONSE.json()}    level=DEBUG
    Request Should Be Successful
    Dictionary Should Contain Item    ${RESPONSE.json()["produtos"][0]}     nome           ${produto}
    Dictionary Should Contain Item    ${RESPONSE.json()["produtos"][0]}     preco          ${preco}
    Dictionary Should Contain Item    ${RESPONSE.json()["produtos"][0]}     descricao      ${descricao} 
    Dictionary Should Contain Item    ${RESPONSE.json()["produtos"][0]}     quantidade     ${quantidade}
    Dictionary Should Contain Item    ${RESPONSE.json()["produtos"][0]}     _id            ${ID_PRODUTO_CADASTRADO}
    Validate Json Schema              ${PATH_SCHEMA}/listar_produto.json     ${RESPONSE.json()}
