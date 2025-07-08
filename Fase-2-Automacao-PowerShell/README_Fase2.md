# Projeto de Laboratório: Infraestrutura Vértice Consultoria

Este projeto demonstra a criação e o gerenciamento de uma infraestrutura de TI completa baseada em Windows Server e Active Directory. Ele está sendo construído em fases para abranger diferentes competências.

---

## 🌳 Fases do Projeto

### ✅ Fase 1: Fundação do Active Directory (Concluída)
* **Descrição:** Instalação e configuração de um Controlador de Domínio, DNS, estrutura de OUs, usuários e implementação de Políticas de Grupo (GPOs) para padronização e segurança.
* **Habilidades Demonstradas:** Windows Server, AD DS, DNS, Group Policy Management, Troubleshooting.
* **[Ver Detalhes e Screenshots da Fase 1](#fase-1-detalhes)**

### ✅ Fase 2: Automação com PowerShell (Concluída)
* **Descrição:** Desenvolvimento de um script para automatizar a criação de novos usuários em massa a partir de um arquivo CSV, alocando-os dinamicamente em suas respectivas OUs.
* **Habilidades Demonstradas:** PowerShell Scripting, Automação de Tarefas, Manipulação de Dados (CSV).
* **[Ver Detalhes e Screenshots da Fase 2](#fase-2-detalhes)**

### 🔜 Fase 3: Servidor de Arquivos e Permissões (Próximos Passos)
* **Objetivo:** Configurar um servidor de arquivos com pastas departamentais e permissões de segurança NTFS específicas para cada grupo, garantindo que cada departamento acesse apenas seus próprios dados.

---

## <a name="fase-1-detalhes"></a> Fase 1: Detalhes da Fundação do AD

*(Aqui você vai colar a documentação detalhada e os prints que fizemos para a Fase 1: Instalação do AD, criação das OUs e GPOs iniciais).*

---

## <a name="fase-2-detalhes"></a> Fase 2: Detalhes da Automação com PowerShell

#### 1. Objetivo

O processo manual de criação de novos usuários ("onboarding") em uma empresa é demorado e suscetível a erros. O objetivo desta fase foi desenvolver uma solução automatizada para provisionar novas contas de usuário no Active Directory de forma rápida, padronizada e eficiente.

#### 2. Componentes da Solução

Para alcançar este objetivo, a solução foi dividida em dois componentes principais:

* **Fonte de Dados (`novos_funcionarios.csv`):** Foi criado um arquivo no formato CSV para servir como a fonte de dados padronizada, contendo as informações essenciais de cada novo colaborador (Nome, Sobrenome, Departamento, Cargo). Esta abordagem permite que o departamento de RH, por exemplo, preencha uma planilha simples que servirá de entrada para a automação.

* **Script de Automação (`criar_usuarios.ps1`):** O coração da automação é um script desenvolvido em PowerShell. Este script é responsável por ler os dados do arquivo CSV e interagir diretamente com o Active Directory para executar as tarefas de criação de contas.

#### 3. Detalhes da Implementação do Script

O script foi projetado para seguir uma lógica clara e robusta:

1.  **Importação de Dados:** Utilizando o cmdlet `Import-Csv`, o script inicia importando os dados do arquivo `.csv`, transformando cada linha em um objeto estruturado.
2.  **Loop de Processamento:** Através de um loop `foreach`, o script itera sobre cada registro (cada futuro funcionário) que foi importado do CSV, garantindo que a mesma sequência de ações seja aplicada a todos.
3.  **Criação Dinâmica do Usuário:** Para cada funcionário na lista, o cmdlet `New-ADUser` é utilizado para criar a conta no Active Directory. Os parâmetros são preenchidos dinamicamente com as informações do funcionário atual no loop.
4.  **Alocação na OU Correta:** O parâmetro `-Path` do comando `New-ADUser` utiliza a informação da coluna "Departamento" do CSV para alocar o novo usuário automaticamente na Unidade Organizacional (OU) correta, garantindo a organização do AD.
5.  **Configuração de Segurança:** Seguindo as melhores práticas, o script define uma senha inicial padrão e ativa a opção `-ChangePasswordAtLogon $true`, forçando o usuário a criar sua própria senha no primeiro login.

#### 4. Resultados e Benefícios

A execução do script resultou na criação bem-sucedida de 4 novos usuários em seus respectivos departamentos em menos de 5 segundos. Os principais benefícios alcançados são a drástica redução do tempo de trabalho, a eliminação de erros de digitação e a garantia de que todos os novos usuários são criados seguindo um padrão consistente.

*(Aqui é um ótimo lugar para um print do seu PowerShell ISE mostrando o script e a saída bem-sucedida no console, ou um print do Active Directory com os novos usuários já criados em suas OUs corretas)*
