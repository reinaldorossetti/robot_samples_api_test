*** Settings ***
Library        Collections
Library        FakerLibrary
Library        JSONLibrary
Library        jsonschema
Library        OperatingSystem
Library        RequestsLibrary
Library        JSONSchemaLibrary    ${EXECDIR}/atests/features

*** Variables ***

${PATH_SCHEMA}              serverest/resources/schemas
${PATH_DATA}                serverest/resources/data_requests
${URL}                      https://serverest.dev
${ALIAS}                    session_serverest
${admin}                    true
${usuario}
${TOKEN}
${preco}                    470
${descricao}                "Mouse"
${quantidade}               5
${ID_PRODUTO_CADASTRADO}
${produto}