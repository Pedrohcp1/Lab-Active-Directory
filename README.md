# Projeto de Laboratório: Infraestrutura Vértice Consultoria

Este projeto demonstra a criação e o gerenciamento de uma infraestrutura de TI completa baseada em Windows Server e Active Directory. Ele está sendo construído em fases para abranger diferentes competências.

---

## 🌳 Fases do Projeto

### ✅ Fase 1: Fundação do Active Directory (Concluída)
* **Descrição:** Instalação e configuração de um Controlador de Domínio, DNS, estrutura de OUs, usuários e implementação de Políticas de Grupo (GPOs) para padronização e segurança.
* **Habilidades Demonstradas:** Windows Server, AD DS, DNS, Group Policy Management, Troubleshooting.
* **[Ver Detalhes e Screenshots da Fase 1](#fase-1-detalhes)**

### 🔜 Fase 2: Automação com PowerShell (Próximos Passos)
* **Objetivo:** Desenvolver scripts para automatizar tarefas rotineiras, como a criação de novos usuários em massa a partir de um arquivo CSV.

### 🔜 Fase 3: Servidor de Arquivos e Permissões (Próximos Passos)
* **Objetivo:** Configurar um servidor de arquivos com pastas departamentais e permissões de segurança NTFS específicas para cada grupo.

---

## <a name="fase-1-detalhes"></a> Fase 1: Detalhes da Fundação do AD

## 1. Visão Geral do Projeto
Neste projeto, foi simulada a criação e configuração de uma infraestrutura de Active Directory do zero para uma empresa fictícia de consultoria financeira, a "Vértice Consultoria". O objetivo foi implementar e demonstrar habilidades essenciais em administração de servidores Windows Server, incluindo a estruturação de um domínio, gerenciamento de usuários e aplicação de Políticas de Grupo (GPOs) para padronização e segurança.

## 2. Ambiente do Laboratório
* **Software de Virtualização:** Oracle VM VirtualBox
* **Controlador de Domínio (DC):** Windows Server 2022 Standard (SRV-DC01)
* **Máquina Cliente:** Windows 10 Enterprise (WKS-W10-01)
* **Rede:** Rede Interna Virtual com o range de IP 192.168.100.x

## 3. Etapas Executadas

### 3.1. Configuração do Domínio
* Instalação do Windows Server 2022.
* Promoção do servidor a Controlador de Domínio para o novo domínio **`verticeconsultoria.local`**.
* Configuração das funções de AD DS e DNS.
* *(Aqui você pode adicionar o seu PRINT da tela de login mostrando VERTICECONSULTORIA\Administrator)*

### 3.2. Estrutura Organizacional
* Criação de Unidades Organizacionais (OUs) para espelhar a estrutura da empresa:
    * `Diretoria`
    * `Consultores`
    * `Administrativo`
    * `TI`
* Criação de usuários de teste (`carla.moura`, `bruno.costa`) e alocação em suas respectivas OUs.
* *(Um PRINT da sua janela de "Usuários e Computadores do AD" mostrando a estrutura de OUs seria ótimo aqui)*

### 3.3. Implementação de Políticas de Grupo (GPOs)
Foram implementadas duas políticas principais para demonstrar o gerenciamento centralizado:

* **GPO de Padronização (`GPO - Padronizacao Desktop`):**
    * **Escopo:** Aplicada a todo o domínio.
    * **Ação:** Define um papel de parede padrão da empresa para todos os usuários.
    * **Resultado:** Login com qualquer usuário do domínio resulta na aplicação do wallpaper padrão.
    * *(Um PRINT da área de trabalho do cliente com o wallpaper aplicado)*

* **GPO de Segurança (`GPO - Restricoes Consultores`):**
    * **Escopo:** Aplicada apenas à OU `Consultores`.
    * **Ação:** Proíbe o acesso ao Painel de Controle para os usuários deste departamento.
    * **Resultado:** Usuários na OU `Consultores` recebem "acesso negado" ao tentar abrir o Painel de Controle, enquanto usuários de outras OUs (como `Diretoria`) mantêm o acesso normal.
    * *(Um PRINT mostrando a mensagem de erro ao tentar acessar o painel de controle com o usuário Bruno, e talvez outro mostrando o acesso bem-sucedido com a Carla)*

## 4. Conclusão e Aprendizados
Este laboratório prático solidificou conhecimentos em administração de redes Windows, desde a instalação básica até a aplicação de políticas de segurança direcionadas. A principal competência demonstrada é a capacidade de criar um ambiente de TI organizado, seguro e gerenciado de forma centralizada e eficiente.
