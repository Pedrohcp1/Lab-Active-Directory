### Fase 3: Servidor de Arquivos e Permissões NTFS

#### 1. Objetivo

Em qualquer ambiente corporativo, a segurança e a organização dos dados são cruciais. O objetivo desta fase foi configurar um **Servidor de Arquivos (File Server)** centralizado e implementar um sistema de permissões robusto para garantir que cada departamento da "Vértice Consultoria" pudesse acessar apenas seus próprios documentos, protegendo a confidencialidade e a integridade das informações.

#### 2. Estratégia e Componentes

A solução foi implementada seguindo as melhores práticas de administração de sistemas da Microsoft, baseada no princípio de **A-G-P (Contas em Grupos, Grupos recebem Permissões)**.

* **Grupos de Segurança:** Para cada departamento, foi criado um Grupo de Segurança correspondente no Active Directory (ex: `GRP_Acesso_Diretoria`, `GRP_Acesso_Consultores`). Esta abordagem permite gerenciar o acesso de forma centralizada e escalável. Os usuários de cada departamento foram adicionados como membros de seus respectivos grupos.

* **Estrutura de Pastas:** No disco do servidor `SRV-DC01`, foi criada uma estrutura de pastas lógica em `C:\Departamentos`, com uma subpasta para cada setor da empresa (`Diretoria`, `Consultores`, `Administrativo`, `TI`).

#### 3. Detalhes da Implementação

A configuração foi realizada em duas camadas de permissões distintas: Compartilhamento (Share) e NTFS (Segurança).

* **Permissões de Compartilhamento (Share):** A pasta pai `C:\Departamentos` foi compartilhada na rede com o nome `Departamentos`. As permissões de Share foram intencionalmente definidas de forma mais aberta (`Usuários Autenticados` com `Controle Total`). Esta camada funciona como a "porta de entrada do prédio", permitindo que todos os funcionários autenticados acessem o compartilhamento, enquanto o controle fino de acesso é delegado à camada NTFS.

* **Permissões NTFS (A Segurança Real):** Esta é a camada de segurança mais importante e granular. Para cada subpasta departamental (ex: `Diretoria`), o seguinte processo foi aplicado:
    1.  **Desabilitação da Herança:** As permissões herdadas da pasta pai (`Departamentos`) foram desabilitadas, permitindo a criação de uma lista de acesso explícita e única para cada "sala".
    2.  **Limpeza de Permissões:** As permissões genéricas que foram convertidas da herança (como para `Users`) foram removidas.
    3.  **Atribuição Específica:** Foram adicionadas apenas as permissões estritamente necessárias:
        * O grupo `Administrators` do domínio com "Controle Total" para fins administrativos.
        * O grupo de segurança específico do departamento (ex: `GRP_Acesso_Diretoria`) com a permissão de **"Modificar"**, permitindo que os membros criem, leiam, editem e excluam arquivos *apenas dentro da sua própria pasta*.

#### 4. Resultados e Validação

Os testes de acesso foram realizados com sucesso a partir da máquina cliente (`WKS-W10-01`), validando o modelo de segurança:

* **Teste de Acesso Permitido:** Um usuário membro do `GRP_Acesso_Diretoria` (`carla.moura`) conseguiu navegar até `\\SRV-DC01\Departamentos\Diretoria` e criar/editar arquivos.
* **Teste de Acesso Negado:** O mesmo usuário, ao tentar acessar a pasta de outro departamento (ex: `\\SRV-DC01\Departamentos\Consultores`), recebeu uma mensagem de "Acesso Negado", confirmando que a segregação de dados está funcionando como projetado.

*(Aqui é o lugar perfeito para um print mostrando a estrutura de pastas e grupos, e talvez um print da mensagem de "Acesso Negado" durante o teste para provar que a segurança funcionou).*
