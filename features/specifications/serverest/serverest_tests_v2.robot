*** Settings ***
Resource        ../../baseTests.robot
Resource        tests_variables.robot
Resource        keywords/serverest_keyword.robot
Suite Setup     Criar a sessao com a api serverest
Default Tags    serverest_tests

*** Test Cases ***
Testar Listar os Produtos
    [Tags]    ListarProduto
    Cadastrar o usuario de teste
    Efetuar o login
    Cadastrar um Produto
    Listar o produto cadastrado
