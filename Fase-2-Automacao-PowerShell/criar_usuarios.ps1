# Passo 1: Importar a lista de funcionários de um arquivo local no Desktop.
$caminhoDoArquivo = "C:\Users\Administrator\Desktop\novos_funcionarios.csv"
$dadosCsv = Import-Csv -Path $caminhoDoArquivo

# Mensagem de status para o usuário
Write-Host "Dados importados com sucesso. Iniciando criação de usuários..." -ForegroundColor Green

# Passo 2: Loop para criar cada usuário (usando a sintaxe 'foreach', que é mais clara)
foreach ($funcionario in $dadosCsv) {
    # A variável "$funcionario" representa a linha ATUAL do CSV que o loop está processando
    $primeiroNome = $funcionario.Nome
    $sobrenome = $funcionario.Sobrenome
    $departamentoOU = $funcionario.Departamento
    $cargo = $funcionario.Cargo

    # Montando os nomes de usuário padrão
    $nomeDeLogin = ($primeiroNome + "." + $sobrenome).ToLower() # ex: joao.santos
    $nomeCompleto = "$primeiroNome $sobrenome" # ex: Joao Santos

    # Mensagem de status para cada usuário
    Write-Host "Criando usuário: $nomeCompleto no departamento $departamentoOU..."

    # Comando para criar o usuário no Active Directory
    New-ADUser -Name $nomeCompleto `
               -GivenName $primeiroNome `
               -Surname $sobrenome `
               -SamAccountName $nomeDeLogin `
               -UserPrincipalName "$nomeDeLogin@verticeconsultoria.local" `
               -Path "OU=$departamentoOU,DC=verticeconsultoria,DC=local" `
               -Description $cargo `
               -Enabled $true `
               -ChangePasswordAtLogon $true `
               -AccountPassword (ConvertTo-SecureString "Mudar@1234" -AsPlainText -Force)
}

Write-Host "Processo de criação de usuários concluído!" -ForegroundColor Green