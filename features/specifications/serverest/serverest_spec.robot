*** Settings ***
Resource        ../../steps_definitions/serverest/serverest_steps.robot
Suite Setup    Criar a sessao com a api serverest

*** Test Cases ***
Testar Listar os Produtos
    [Tags]    ListarProduto
    Cadastrar o usuario de teste
    Efetuar o login
    Cadastrar um Produto
    Listar o produto cadastrado
 