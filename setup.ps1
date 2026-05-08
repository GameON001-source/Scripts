# Central GameOn Digital - Versão PowerShell
$senhaCorreta = "2727"

Clear-Host
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "          GAMEON DIGITAL - ACESSO" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

$tentativa = Read-Host "Digite sua Chave de Acesso"

if ($tentativa -ne $senhaCorreta) {
    Write-Host ""
    Write-Host "[ERRO] Chave incorreta! Acesso negado." -ForegroundColor Red
    pause
    exit
}

function Show-Menu {
    Clear-Host
    Write-Host "============================================" -ForegroundColor Cyan
    Write-Host "          GAMEON DIGITAL - MENU" -ForegroundColor Cyan
    Write-Host "============================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host " [1] INSTALAR BIBLIOTECA DE JOGOS"
    Write-Host " [2] SAIR"
    Write-Host ""
    Write-Host "============================================" -ForegroundColor Cyan
}

Show-Menu
$opcao = Read-Host "Escolha uma opcao"

if ($opcao -eq "1") {
    Clear-Host
    Write-Host "[!] Preparando ambiente em C:\GameON..." -ForegroundColor Yellow
    if (!(Test-Path "C:\GameON")) { New-Item -Path "C:\GameON" -ItemType Directory }
    Set-Location "C:\GameON"
    
    Write-Host "[!] Baixando arquivos... Isso pode demorar (1.5GB)." -ForegroundColor Cyan
    # Use o seu link do MediaFire ou Dropbox abaixo
    curl -L "COLE_AQUI_O_SEU_LINK_DO_MEDIAFIRE_OU_DROPBOX" -o "JOGOS.zip"
    
    Write-Host "[!] Extraindo jogos..." -ForegroundColor Yellow
    tar -xf "JOGOS.zip"
    Remove-Item "JOGOS.zip" -Force
    
    Write-Host ""
    Write-Host "[+] INSTALACAO CONCLUIDA COM SUCESSO!" -ForegroundColor Green
    Write-Host "[+] Verifique a pasta C:\GameON" -ForegroundColor Green
    pause
} else {
    exit
}
