# Central GameOn Digital - PowerShell Edition
$senhaCorreta = "2727"

function Mostrar-Menu {
    Clear-Host
    Write-Host "============================================" -ForegroundColor Cyan
    Write-Host "          GAMEON DIGITAL - ACESSO" -ForegroundColor Cyan
    Write-Host "============================================" -ForegroundColor Cyan
    Write-Host ""
}

Mostrar-Menu
$tentativa = Read-Host "Digite sua Chave de Acesso"

if ($tentativa -ne $senhaCorreta) {
    Write-Host ""
    Write-Host "[ERRO] Chave incorreta! Acesso negado." -ForegroundColor Red
    pause
    exit
}

function Exibir-Principal {
    Clear-Host
    Write-Host "============================================" -ForegroundColor Cyan
    Write-Host "          GAMEON DIGITAL - MENU" -ForegroundColor Cyan
    Write-Host "============================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host " [1] INSTALAR BIBLIOTECA"
    Write-Host " [2] ATUALIZAR ARQUIVOS"
    Write-Host " [3] SAIR"
    Write-Host ""
}

Exibir-Principal
$opcao = Read-Host "Escolha uma opcao"

if ($opcao -eq "1" -or $opcao -eq "2") {
    Clear-Host
    Write-Host "[!] Preparando ambiente..." -ForegroundColor Yellow
    if (!(Test-Path "C:\GameON")) { New-Item -Path "C:\GameON" -ItemType Directory | Out-Null }
    Set-Location "C:\GameON"
    
    Write-Host "[!] Baixando arquivos... Aguarde." -ForegroundColor Cyan
    # O comando abaixo baixa o arquivo do Drive com barra de progresso nativa
    Start-BitsTransfer -Source "https://docs.google.com/uc?export=download&id=17_OBFcod8dKv6rXhg8_T2gfkohYZ8hx-&confirm=t" -Destination "C:\GameON\JOGOS_GameON.zip"
    
    Write-Host "[!] Instalando e extraindo..." -ForegroundColor Yellow
    Expand-Archive -Path "C:\GameON\JOGOS_GameON.zip" -DestinationPath "C:\GameON" -Force
    Remove-Item "C:\GameON\JOGOS_GameON.zip" -Force
    
    Write-Host ""
    Write-Host "[+] CONCLUIDO COM SUCESSO!" -ForegroundColor Green
    pause
}
elseif ($opcao -eq "3") {
    exit
}
