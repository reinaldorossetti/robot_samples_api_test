*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    FakerLibrary

Suite Setup    Criar a sessao com a api serverest

*** Variables ***
${URL}                https://serverest.dev
${ALIAS}              session_serverest
${admin}              true
${user}

*** Test Cases ***
Testar Listar os Produtos
    [Tags]    ListarProduto
    Cadastrar o usuario de teste
    #Obter Token
    #Cadastrar um Produto
    #Listar o produto cadastrado

*** Keywords ***
Criar os dados do usuario
    ${nome}         FakerLibrary.Name
    ${email}        FakerLibrary.Email
    ${password}     FakerLibrary.Password
    ${user}      Create Dictionary    nome=${nome}    email=${email}    password=${password}   administrador=${admin}
    Set Suite Variable    ${user}
    Log       ${user} 

Criar a sessao com a api serverest
    Criar os dados do usuario
    ${HEADER}    Create Dictionary        Content-Type=application/json
    Create Session    ${ALIAS}    url=${URL}    headers=${HEADER}    disable_warnings=1

Cadastrar o usuario de teste
    ${RESPONSE}    POST On Session        ${ALIAS}    json=${user}    url=${URL}/usuarios
    Log        Resposta Retornada: ${RESPONSE}