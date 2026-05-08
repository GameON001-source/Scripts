# Setup GameOn Digital
$senhaCorreta = "2727"
Clear-Host
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "          GAMEON DIGITAL - ACESSO" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
$tentativa = Read-Host "Digite sua Chave de Acesso"

if ($tentativa -eq $senhaCorreta) {
    Clear-Host
    Write-Host "[!] Criando pasta em C:\GameON..." -ForegroundColor Yellow
    if (!(Test-Path "C:\GameON")) { New-Item -Path "C:\GameON" -ItemType Directory }
    Set-Location "C:\GameON"
    
    Write-Host "[!] Baixando arquivos da biblioteca... Aguarde." -ForegroundColor Cyan
    # Download forçado do Google Drive
    curl.exe -L "https://docs.google.com/uc?export=download&id=17_OBFcod8dKv6rXhg8_T2gfkohYZ8hx-&confirm=t" -o "JOGOS.zip"
    
    Write-Host "[!] Extraindo e instalando..." -ForegroundColor Yellow
    tar.exe -xf "JOGOS.zip"
    Remove-Item "JOGOS.zip" -Force
    
    Write-Host ""
    Write-Host "[+] TUDO PRONTO! Verifique a pasta C:\GameON" -ForegroundColor Green
    pause
} else {
    Write-Host "[ERRO] Senha invalida. Tente novamente." -ForegroundColor Red
    pause
}
