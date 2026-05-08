# Central de Instalacao - GameOn Digital
$senhaCorreta = "2727"

Clear-Host
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "          GAMEON DIGITAL - ACESSO" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

$tentativa = Read-Host "Digite sua Chave de Acesso"

if ($tentativa -eq $senhaCorreta) {
    Clear-Host
    Write-Host "[!] Preparando ambiente em C:\GameON..." -ForegroundColor Yellow
    if (!(Test-Path "C:\GameON")) { New-Item -Path "C:\GameON" -ItemType Directory }
    Set-Location "C:\GameON"
    
    Write-Host "[!] Baixando biblioteca de jogos... Aguarde." -ForegroundColor Cyan
    # Download via CURL (mais estavel para arquivos grandes do Google Drive)
    curl.exe -L "https://docs.google.com/uc?export=download&id=17_OBFcod8dKv6rXhg8_T2gfkohYZ8hx-&confirm=t" -o "JOGOS.zip"
    
    if (Test-Path "JOGOS.zip") {
        Write-Host "[!] Extraindo e instalando arquivos..." -ForegroundColor Yellow
        tar.exe -xf "JOGOS.zip"
        Remove-Item "JOGOS.zip" -Force
        
        Write-Host ""
        Write-Host "[+] INSTALACAO CONCLUIDA COM SUCESSO!" -ForegroundColor Green
        Write-Host "[+] Os arquivos estao prontos em C:\GameON" -ForegroundColor Green
    } else {
        Write-Host "[ERRO] Nao foi possivel baixar os arquivos. Verifique sua conexao." -ForegroundColor Red
    }
    pause
} else {
    Write-Host ""
    Write-Host "[ERRO] Chave incorreta! Acesso negado." -ForegroundColor Red
    pause
}
