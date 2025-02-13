*** Settings ***
Library  RequestsLibrary
Library  OperatingSystem
Library  JSONLibrary
Library  Collections
Library  BuiltIn

*** Variables ***

${CEP_VÁLIDO}          51111011
${CEP_INVÁLIDO}        00100101
${CEP_INCOMPLETO}      111  
${CEP_INCORRETO}       8888888888888888888888888888888888888888888
${CEP_SPECIAL}         1111321@
${JSON_FILE}  ./dados_cep.json

${Dados_corretos_51111011}      {
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
    ${response}    Get     https://viacep.com.br/ws/${CEP_VÁLIDO}/json/
    Request Should Be Successful    ${response} 
    ${json_data}    Set Variable    ${response.json()}
    ${json_string}    Evaluate    json.dumps(${json_data}, indent=4)    json
    Create File    ${JSON_FILE}    ${json_string}
    File Should Exist    ${JSON_FILE}
    Log To Console    JSON salvo em: ${JSON_FILE}
    ${result}       Should Be Equal    ${Dados_corretos_51111011}    ${json_string}
    Run Keyword If    '${result[0]}' == 'FAIL'    Log    TESTE NOK, Os dados não são iguais    level=ERROR
    Run Keyword If    '${result[0]}' == 'PASS'    Log    TESTE OK, Os dados estão corretos

02 - Consultar um CEP Inválido
    ${response}     Get     https://viacep.com.br/ws/${CEP_INVÁLIDO}/json/    
    ${result}       Should Not Be Equal As Numbers    ${response.status_code}    200   
    Run Keyword If    '${result[0]}' == 'FAIL'    Log    TESTE NOK, Status Code = 200    level=ERROR
    Run Keyword If    '${result[0]}' == 'PASS'    Log    TESTE OK, Status Code != 200 
    ${response}    Get     https://viacep.com.br/ws/${CEP_INVÁLIDO}/json/
    ${json_data}    Set Variable    ${response.json()}
    ${json_string}    Evaluate    json.dumps(${json_data}, indent=4)    json
    Create File    ${JSON_FILE}    ${json_string}
    File Should Exist    ${JSON_FILE}
    Log To Console    JSON salvo em: ${JSON_FILE}
    ${result}   Run Keyword And Ignore Error  Should COntain    ${json_string}      erro 
    Run Keyword If    '${result[0]}' == 'FAIL'    Log    TESTE NOK, No Json não há erro    level=ERROR
    Run Keyword If    '${result[0]}' == 'PASS'    Log    TESTE OK, No Json há erro

03 - Consultar um CEP Incompleto
    
    ${response}     Run Keyword And Ignore Error    Get    https://viacep.com.br/ws/${CEP_INCOMPLETO}/json/
    ${responset}        Should Not Be Equal As Numbers      ${response.status_code}      400

04 - Consultar um CEP Incrreto
    
    ${response}     Run Keyword And Ignore Error    Get    https://viacep.com.br/ws/${CEP_INCORRETO}/json/
    ${response}       Should Not Be Equal As Numbers      ${response.status_code}      400

05 - Consultar um CEP Especial

    ${response}     Run Keyword And Ignore Error    Get    https://viacep.com.br/ws/${CEP_SPECIAL}/json/
    ${response}       Should Not Be Equal As Numbers      ${response.status_code}      400

*** Keywords ***

