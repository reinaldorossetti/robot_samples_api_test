*** Settings ***
Library        RequestsLibrary
Library        Collections
Library        FakerLibrary
Suite Setup    Criar a sessao com a api serverest

*** Variables ***
${URL}                https://fakerestapi.azurewebsites.net/api/v1/
${ALIAS}              fakersite
${usuario}
${TOKEN}


*** Test Cases ***
Testar Listar os Produtos
    [Tags]    ListarProduto
    Cadastrar os livros

*** Keywords ***
Criar a sessao com a api serverest
    ${HEADER}=    Create Dictionary        Content-Type=application/json
    Create Session    ${ALIAS}    url=${URL}    headers=${HEADER}    disable_warnings=1

Cadastrar os livros
    ${BODY}=    Create Dictionary          title=Teste de Software      description=livro sobre testes     excerpt=string      publishDate=2022-05-26T00:24:28.399Z
    ${RESPONSE}=    POST On Session        ${ALIAS}    json=${BODY}    url=Books
    Log        Resposta Retornada: ${RESPONSE.json()}
    Log To Console     Resposta Retornada: ${RESPONSE.json()}
    Request Should Be Successful
