# Fase 3: Detalhes do Servidor de Arquivos e Permissões

### 1. Objetivo

Em qualquer ambiente corporativo, a segurança e a organização dos dados são cruciais. O objetivo desta fase foi configurar um **Servidor de Arquivos (File Server)** centralizado e implementar um sistema de permissões robusto para garantir que cada departamento da "Vértice Consultoria" pudesse acessar apenas seus próprios documentos, protegendo a confidencialidade e a integridade das informações.

### 2. Estratégia de Implementação (A-G-P)

A solução foi implementada seguindo a melhor prática de administração de sistemas da Microsoft, conhecida como **A-G-P (Contas de usuário são colocadas em Grupos, e Grupos recebem Permissões)**. Esta abordagem garante um gerenciamento escalável e de fácil manutenção.

* **Grupos de Segurança:** Para cada departamento, foi criado um Grupo de Segurança correspondente no Active Directory (ex: `GRP_Acesso_Diretoria`, `GRP_Acesso_Consultores`) dentro de uma OU dedicada chamada `Grupos`. Os usuários de cada departamento foram então adicionados como membros de seus respectivos grupos de acesso.

<img width="474" height="199" alt="01_Grupos" src="https://github.com/user-attachments/assets/e4e2704b-13a6-4259-8785-e325c657af33" />

Figura 1: Grupos criados no Servidor da Vértice Consultoria.

* **Estrutura de Pastas:** No disco do servidor `SRV-DC01`, foi criada uma estrutura de pastas centralizada em `C:\Departamentos`, com uma subpasta para cada setor da empresa (`Diretoria`, `Consultores`, `Administrativo`, `TI`).

<img width="663" height="212" alt="02_Pastas-Criadas" src="https://github.com/user-attachments/assets/da4f7da0-ed85-42fb-b4da-68ec696c74c2" />

Figura 2: Pastas de cada departamento.

### 3. Detalhes da Configuração

A configuração foi realizada em duas camadas de permissões distintas, uma prática fundamental para a segurança de compartilhamentos Windows:

* **Permissões de Compartilhamento (Share - "A Porta da Rua"):** A pasta pai `C:\Departamentos` foi compartilhada na rede com o nome `Departamentos`. As permissões de *Share* foram intencionalmente definidas de forma mais aberta (para o grupo `Usuários Autenticados` com `Controle Total`). Esta camada funciona como a "porta de entrada do prédio", permitindo que todos os funcionários autenticados acessem o compartilhamento, enquanto o controle fino de acesso é delegado à camada seguinte, o NTFS.

* **Permissões NTFS (A Segurança Real - "As Chaves das Salas"):** Esta é a camada de segurança mais importante e granular. Para cada subpasta departamental (ex: `C:\Departamentos\Diretoria`), o seguinte processo foi aplicado:
    1.  **Desabilitação da Herança:** As permissões que eram herdadas da pasta pai (`Departamentos`) foram desabilitadas. Isso permitiu a criação de uma lista de acesso explícita e única para cada pasta.
    2.  **Limpeza de Permissões:** As permissões genéricas que foram convertidas da herança (como para o grupo `Users`) foram removidas, garantindo que nenhum acesso indesejado permanecesse.
    3.  **Atribuição Específica:** Foram adicionadas apenas as permissões estritamente necessárias: o grupo de `Administradores do Domínio` com "Controle Total" e o **grupo de segurança específico do departamento** (ex: `GRP_Acesso_Diretoria`) com a permissão de **"Modificar"**. A permissão de "Modificar" permite que os membros do grupo criem, leiam, editem e excluam arquivos e pastas apenas dentro de seu próprio diretório.

<img width="762" height="518" alt="03_Permissoes" src="https://github.com/user-attachments/assets/d248ae47-621e-4305-b14b-9184c4f02de3" />

Figura 3: Configuações de acesso a pastas.

### 4. Validação e Resultados

Os testes de acesso foram realizados a partir da máquina cliente (`WKS-W10-01`) para validar o modelo de segurança:

* **Teste de Acesso Permitido:** Um usuário membro do `GRP_Acesso_Diretoria` (a `carla.moura`) conseguiu acessar a pasta `\\SRV-DC01\Departamentos\Diretoria` e criar/editar arquivos de texto com sucesso.
* **Teste de Acesso Negado:** O mesmo usuário, ao tentar acessar a pasta de outro departamento (ex: `\\SRV-DC01\Departamentos\Consultores`), recebeu uma mensagem de **"Acesso Negado"**, confirmando que a segregação de dados entre os departamentos está funcionando como projetado.

<img width="630" height="330" alt="04_Pasta-SemAcesso" src="https://github.com/user-attachments/assets/8c042fbb-9053-4cea-ac08-3c7bb6c726c0" />

Figura 4: Comprovação do acesso negado ao usuario do departamento diferente. 
