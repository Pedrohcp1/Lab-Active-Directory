
### Fase 2: Automação do Provisionamento de Usuários com PowerShell

#### 1. Objetivo

O processo manual de criação de novos usuários ("onboarding") em uma empresa é demorado, repetitivo e suscetível a erros humanos, como erros de digitação ou esquecimento de configurar alguma propriedade importante. O objetivo desta fase foi desenvolver uma solução automatizada para provisionar novas contas de usuário no Active Directory de forma rápida, padronizada e eficiente.

#### 2. Componentes da Solução

Para alcançar o objetivo, a solução foi dividida em dois componentes principais:

* **Fonte de Dados (`novos_funcionarios.csv`):** Foi criado um arquivo no formato CSV (Valores Separados por Vírgula) para servir como a fonte de dados padronizada. Este arquivo contém as informações essenciais de cada novo colaborador (Nome, Sobrenome, Departamento, Cargo). Esta abordagem permite que o departamento de RH, por exemplo, preencha uma simples planilha que servirá de entrada para a automação, separando a coleta de dados da execução técnica.

* **Script de Automação (`criar_usuarios.ps1`):** O coração da automação é um script desenvolvido em PowerShell. Este script é responsável por ler os dados do arquivo CSV e interagir diretamente com o Active Directory para executar as tarefas de criação de contas.

#### 3. Detalhes da Implementação do Script

O script foi projetado para seguir uma lógica clara e robusta:

1.  **Importação de Dados:** O script inicia importando os dados do arquivo `.csv` utilizando o cmdlet `Import-Csv`. Este comando transforma cada linha do arquivo de texto em um objeto estruturado, facilitando a manipulação das informações.
2.  **Loop de Processamento:** Utilizando um loop `foreach`, o script itera sobre cada registro (cada futuro funcionário) que foi importado do CSV. Isso garante que a mesma sequência de ações seja aplicada a todos, um por um.
3.  **Criação Dinâmica do Usuário:** Para cada funcionário na lista, o cmdlet `New-ADUser` é utilizado para criar a conta no Active Directory. Os parâmetros deste comando são preenchidos dinamicamente com as informações do funcionário atual no loop (ex: `-GivenName` recebe o valor da coluna "Nome", `-Surname` recebe o valor da coluna "Sobrenome").
4.  **Alocação na OU Correta:** Um dos pontos chave da automação é o uso do parâmetro `-Path`. Ele utiliza a informação da coluna "Departamento" do CSV para alocar o novo usuário automaticamente na Unidade Organizacional (OU) correta, garantindo a organização do AD.
5.  **Configuração de Segurança:** Seguindo as melhores práticas de segurança, o script define uma senha inicial padrão e ativa a opção `-ChangePasswordAtLogon $true`, forçando o usuário a criar sua própria senha secreta no primeiro login.

#### 4. Resultados e Benefícios

A execução do script resultou na criação bem-sucedida de 4 novos usuários em seus respectivos departamentos em menos de 5 segundos, um processo que levaria vários minutos manualmente. Os principais benefícios alcançados com esta automação são:

* **Eficiência:** Drástica redução do tempo necessário para criar novas contas.
* **Padronização:** Garantia de que todas as contas são criadas seguindo o mesmo padrão de nomenclatura e configuração.
* **Redução de Erros:** Eliminação de erros de digitação ou esquecimento de configurações manuais.

*(Aqui é um ótimo lugar para um print do seu PowerShell ISE mostrando o script e a saída bem-sucedida no console, ou um print do Active Directory com os novos usuários já criados em suas OUs corretas)*
