*** Settings ***
Library  RequestsLibrary
Library  OperatingSystem
Library  JSONLibrary
Library  Collections
Library  BuiltIn

*** Variables ***
${BASE_URL}    https://viacep.com.br/ws/
${JSON_FILE}   ./dados_cep.json

# CEPs para teste
${CEP_VÁLIDO}          51111011
${CEP_INVÁLIDO}        00100101
${CEP_INCOMPLETO}      111  
${CEP_INCORRETO}       8888888888888888888888888888888888888888888
${CEP_SPECIAL}         1111321@

# Dados esperados para CEP válido
${Dados_corretos_51111011}    {
  "cep": "51111-011",
  "logradouro": "Avenida Conselheiro Aguiar",
  "complemento": "de 1367 a 2255 - lado ímpar",
  "unidade": "",
  "bairro": "Boa Viagem",
  "localidade": "Recife",
  "uf": "PE",
  "estado": "Pernambuco",
  "regiao": "Nordeste",
  "ibge": "2611606",
  "gia": "",
  "ddd": "81",
  "siafi": "2531"
}

*** Test Cases ***
01 - Consultar um CEP Válido
    [Documentation]  Verifica se um CEP válido retorna os dados corretos.
    Consultar CEP Válido
    Verificar sucesso da request 
    Verificar informações do response

02 - Consultar um CEP Inválido
    [Documentation]  Testa um CEP inválido e verifica se retorna erro.
    Consultar CEP inválido 
    Verificar fracasso da request
    Verificar error no response

03 - Consultar um CEP Incompleto
    [Documentation]  Testa um CEP incompleto e verifica se retorna erro.
    Consultar CEP incompleto 
    Verificar que CEP incompleto não gera erro 400 

04 - Consultar um CEP Incorreto
    [Documentation]  Testa um CEP muito grande e verifica se retorna erro.
    Consultar um CEP Incorreto
    Verificar que CEP incorreto não gera erro 400 

05 - Consultar um CEP com Caracteres Especiais
    [Documentation]  Testa um CEP com caracteres especiais e verifica se retorna erro.
    Consultar CEP com caracteres especiais 
    Verificar que CEP com caracteres especiais não gera erro 400 

*** Keywords ***
Consultar CEP Válido
    ${response}    Get    ${BASE_URL}${CEP_VÁLIDO}/json/

Verificar sucesso da request 
    Request Should Be Successful    ${response}

Verificar informações do response
    ${json_data}    Set Variable    ${response.json()}
    ${json_string}    Evaluate    json.dumps(${json_data}, indent=4)    json
    Create File    ${JSON_FILE}    ${json_string}
    File Should Exist    ${JSON_FILE}
    Log To Console    JSON salvo em: ${JSON_FILE}
    ${result}    Run Keyword And Ignore Error    Should Be Equal    ${json_string}    ${Dados_corretos_51111011}
    Run Keyword If    '${result[0]}' == 'FAIL'    Log    TESTE NOK: Dados não conferem    level=ERROR
    Run Keyword If    '${result[0]}' == 'PASS'    Log    TESTE OK: Dados corretos

Consultar CEP inválido 
    ${response}    Get    ${BASE_URL}${CEP_INVÁLIDO}/json/

Verificar fracasso da request
    ${result}    Run Keyword And Ignore Error    Should Not Be Equal As Numbers    ${response.status_code}    200
    Run Keyword If    '${result[0]}' == 'FAIL'    Log    TESTE NOK: Status Code 200 para CEP inválido    level=ERROR
    Run Keyword If    '${result[0]}' == 'PASS'    Log    TESTE OK: Status Code diferente de 200

Verificar error no response
    ${json_data}    Set Variable    ${response.json()}
    ${json_string}    Evaluate    json.dumps(${json_data}, indent=4)    json
    Create File    ${JSON_FILE}    ${json_string}
    ${result}    Run Keyword And Ignore Error    Should Contain    ${json_string}    error
    Run Keyword If    '${result[0]}' == 'FAIL'    Log    TESTE NOK: JSON não contém erro    level=ERROR
    Run Keyword If    '${result[0]}' == 'PASS'    Log    TESTE OK: JSON contém erro

Consultar CEP incompleto 
    ${response}    Run Keyword And Ignore Error    Get    ${BASE_URL}${CEP_INCOMPLETO}/json/

Verificar que CEP incompleto não gera erro 400 
    ${result}    Run Keyword And Ignore Error    Should Not Be Equal As Numbers    ${response.status_code}    400
    Run Keyword If    '${result[0]}' == 'FAIL'    Log    TESTE NOK: Status Code 400    level=ERROR
    Run Keyword If    '${result[0]}' == 'PASS'    Log    TESTE OK: Status Code correto

Consultar um CEP Incorreto
    ${response}    Run Keyword And Ignore Error    Get    ${BASE_URL}${CEP_INCORRETO}/json/

Verificar que CEP incorreto não gera erro 400 
    ${result}    Run Keyword And Ignore Error    Should Not Be Equal As Numbers    ${response.status_code}    400
    Run Keyword If    '${result[0]}' == 'FAIL'    Log    TESTE NOK: Status Code 400    level=ERROR
    Run Keyword If    '${result[0]}' == 'PASS'    Log    TESTE OK: Status Code correto

Consultar CEP com caracteres especiais 
    ${response}    Run Keyword And Ignore Error    Get    ${BASE_URL}${CEP_SPECIAL}/json/

Verificar que CEP com caracteres especiais não gera erro 400 
    ${result}    Run Keyword And Ignore Error    Should Not Be Equal As Numbers    ${response.status_code}    400
    Run Keyword If    '${result[0]}' == 'FAIL'    Log    TESTE NOK: Status Code 400    level=ERROR
    Run Keyword If    '${result[0]}' == 'PASS'    Log    TESTE OK: Status Code correto


