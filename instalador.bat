# GameOn Digital - Oficial
$senhaCorreta = "2727"

Clear-Host
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "          GAMEON DIGITAL - ACESSO" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
$tentativa = Read-Host " Digite sua Chave"

if ($tentativa -ne $senhaCorreta) {
    Write-Host "`n[ERRO] Chave incorreta!" -ForegroundColor Red
    Start-Sleep -Seconds 2; exit
}

Write-Host "`n[!] Preparando ambiente..." -ForegroundColor Yellow
if (!(Test-Path "C:\GameON")) { New-Item -Path "C:\GameON" -ItemType Directory | Out-Null }
Set-Location "C:\GameON"

Write-Host "[!] Baixando jogos... Aguarde." -ForegroundColor Cyan
# Link direto para download
$url = "https://docs.google.com/uc?export=download&id=17_OBFcod8dKv6rXhg8_T2gfkohYZ8hx-&confirm=t"
Start-BitsTransfer -Source $url -Destination "C:\GameON\JOGOS.zip"

Write-Host "[!] Extraindo arquivos..." -ForegroundColor Yellow
Expand-Archive -Path "C:\GameON\JOGOS.zip" -DestinationPath "C:\GameON" -Force
Remove-Item "C:\GameON\JOGOS.zip" -Force

Write-Host "`n[+] INSTALACAO CONCLUIDA!" -ForegroundColor Green
pause
