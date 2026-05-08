# Configuração GameOn Digital
$senhaCorreta = "2727"
Clear-Host
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "          GAMEON DIGITAL - ACESSO" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
$tentativa = Read-Host "Digite sua Chave de Acesso"

if ($tentativa -eq $senhaCorreta) {
    Clear-Host
    Write-Host "[!] Preparando ambiente em C:\GameON..." -ForegroundColor Yellow
    if (!(Test-Path "C:\GameON")) { New-Item -Path "C:\GameON" -ItemType Directory }
    Set-Location "C:\GameON"
    
    Write-Host "[!] Baixando arquivos... Aguarde." -ForegroundColor Cyan
    # Link direto do Google Drive
    curl.exe -L "https://docs.google.com/uc?export=download&id=17_OBFcod8dKv6rXhg8_T2gfkohYZ8hx-&confirm=t" -o "JOGOS.zip"
    
    Write-Host "[!] Instalando..." -ForegroundColor Yellow
    tar.exe -xf "JOGOS.zip"
    Remove-Item "JOGOS.zip" -Force
    
    Write-Host ""
    Write-Host "[+] INSTALACAO CONCLUIDA COM SUCESSO!" -ForegroundColor Green
    pause
} else {
    Write-Host "[ERRO] Chave incorreta!" -ForegroundColor Red
    pause
}
