# Automacao de Testes de API - Consulta de CEP

## Descricao
Este projeto utiliza o **Robot Framework** com a biblioteca **RequestsLibrary** para automatizar testes de API relacionados a consulta de CEPs no webservice **ViaCEP**. O objetivo dos testes e validar diferentes cenarios de entrada de CEP e verificar se as respostas estao corretas.

## Requisitos

- **Python 3.x**
- **Robot Framework**
- **RequestsLibrary**

## Instalacao das Dependencias

1. Instale o Python 3.x (caso ainda nao esteja instalado).
2. Instale o Robot Framework:
   ```sh
   pip install robotframework
   ```
3. Instale a RequestsLibrary para integrar com APIs:
   ```sh
   pip install robotframework-requests
   ```

## Estrutura do Codigo
O codigo esta estruturado da seguinte forma:

### **Settings**
- Importa as bibliotecas necessarias para a execucao dos testes:
  - RequestsLibrary
  - OperatingSystem
  - JSONLibrary
  - Collections
  - BuiltIn

### **Variables**
- Define as variaveis globais, incluindo:
  - **URL base** do ViaCEP.
  - **CEPs para teste** (valido, invalido, incompleto, incorreto, caracteres especiais).
  - **Dados esperados** para validacao de um CEP valido.

### **Test Cases**
Cada caso de teste executa um tipo de requisicao GET para o webservice do ViaCEP e valida a resposta:

1. **Consultar um CEP Valido**:
   - Verifica se um CEP valido retorna os dados corretos.
   - Compara a resposta da API com os dados esperados.

2. **Consultar um CEP Invalido**:
   - Testa um CEP invalido e verifica se retorna erro.
   - Confere se o status code nao e 200 e se a resposta contem "erro".

3. **Consultar um CEP Incompleto**:
   - Testa um CEP incompleto para verificar se retorna status code 400.

4. **Consultar um CEP Incorreto**:
   - Testa um CEP muito longo e verifica se retorna status code 400.

5. **Consultar um CEP com Caracteres Especiais**:
   - Testa um CEP com caracteres especiais e verifica se retorna status code 400.

## Como Executar os Testes

1. Clone este repositorio ou baixe o arquivo **.robot**.
2. Abra o terminal na pasta onde o arquivo **.robot** esta localizado.
3. Execute o seguinte comando:
   ```sh
   robot nome_do_arquivo.robot
   ```
4. Apos a execucao, os logs e reports serao gerados automaticamente para verificacao dos resultados.

## Resultados Esperados

- A API deve retornar os dados corretos para um CEP valido.
- Para entradas invalidas, a API deve retornar mensagens de erro apropriadas.
- O status code deve refletir a resposta esperada para cada caso de teste.

## Consideracoes Finais
- O codigo pode precisar de ajustes caso a API do ViaCEP passe por mudancas.
- Certifique-se de estar conectado a internet para a execucao correta dos testes.
- O projeto pode ser expandido para testar outros endpoints da API do ViaCEP.

## Licenca
Este projeto e licenciado sob a licenca MIT - consulte o arquivo LICENSE para mais detalhes.
