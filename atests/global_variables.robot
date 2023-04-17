*** Settings ***
Library        Collections
Library        FakerLibrary
Library        JSONLibrary
Library        jsonschema
Library        OperatingSystem
Library        RequestsLibrary

*** Variables ***

${PATH_SCHEMA}              ${PATH_FEATURES}/serverest/resources/schemas
${PATH_DATA}                ${PATH_FEATURES}/serverest/resources/data_requests
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
${PATH_FEATURES}            ${EXECDIR}/atests/features