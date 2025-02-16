# **Automatização de Testes de API - Consulta de CEP**

## 🔍 **Descrição**
Este projeto utiliza o **Robot Framework** com a biblioteca **RequestsLibrary** para automatizar testes de API relacionados à consulta de CEPs no webservice **ViaCEP**. O objetivo dos testes é validar diferentes cenários de entrada de CEP e verificar se as respostas estão corretas.

---

## ⚙️ **Requisitos**
- **Python 3.x**
- **Robot Framework**
- **RequestsLibrary**

---

## ♻️ **Instalação das Dependências**
1. Instale o **Python 3.x** (caso ainda não esteja instalado).
2. Instale o **Robot Framework**:
   ```sh
   pip install robotframework
   ```
3. Instale a **RequestsLibrary** para integrar com APIs:
   ```sh
   pip install robotframework-requests
   ```

---

## 📚 **Estrutura do Código**
O código está estruturado da seguinte forma:

### **🔧 Settings**
Importa as bibliotecas necessárias para a execução dos testes:
- **RequestsLibrary**
- **OperatingSystem**
- **JSONLibrary**
- **Collections**
- **BuiltIn**

### **📝 Variables**
Define as variáveis globais, incluindo:
- **URL base** do ViaCEP.
- **CEPs para teste** (válido, inválido, incompleto, incorreto, caracteres especiais).
- **Dados esperados** para validação de um CEP válido.

### **🌟 Test Cases**
Cada caso de teste executa uma requisição **GET** para o webservice do ViaCEP e valida a resposta:

1. **Consultar um CEP Válido**
   - Verifica se um CEP válido retorna os dados corretos.
   - Compara a resposta da API com os dados esperados.

2. **Consultar um CEP Inválido**
   - Testa um CEP inválido e verifica se retorna erro.
   - Confere se o **status code** não é 200 e se a resposta contém "erro".

3. **Consultar um CEP Incompleto**
   - Testa um CEP incompleto para verificar se retorna **status code 400**.

4. **Consultar um CEP Incorreto**
   - Testa um CEP muito longo e verifica se retorna **status code 400**.

5. **Consultar um CEP com Caracteres Especiais**
   - Testa um CEP com caracteres especiais e verifica se retorna **status code 400**.

---

## ⚡ **Como Executar os Testes**
1. Clone este repositório ou baixe o arquivo **.robot**.
2. Abra o terminal na pasta onde o arquivo **.robot** está localizado.
3. Execute o seguinte comando:
   ```sh
   robot nome_do_arquivo.robot
   ```
4. Após a execução, os **logs e relatórios** serão gerados automaticamente para verificação dos resultados.

---

## 📈 **Resultados Esperados**
- A **API** deve retornar os dados corretos para um **CEP válido**.
- Para entradas **inválidas**, a API deve retornar mensagens de erro apropriadas.
- O **status code** deve refletir a resposta esperada para cada caso de teste.

---

## 🚀 **Considerações Finais**
- O código pode precisar de ajustes caso a **API do ViaCEP** passe por mudanças.
- Certifique-se de estar **conectado à internet** para a execução correta dos testes.
- O projeto pode ser expandido para testar outros **endpoints da API do ViaCEP**.

---

## 📚 **Licença**
Este projeto é licenciado sob a **licença MIT** - consulte o arquivo **LICENSE** para mais detalhes.

