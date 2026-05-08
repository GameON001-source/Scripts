# GameOn Digital - Sistema de Download Inteligente
$senhaCorreta = "2727"
$fileId = "17_OBFcod8dKv6rXhg8_T2gfkohYZ8hx-"
$destino = "C:\GameON\JOGOS.zip"

Clear-Host
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "          GAMEON DIGITAL - ACESSO" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
$tentativa = Read-Host " Digite sua Chave de Acesso"

if ($tentativa -ne $senhaCorreta) {
    Write-Host "`n[ERRO] Chave incorreta!" -ForegroundColor Red
    Start-Sleep -Seconds 2; exit
}

# Criar pasta de destino
if (!(Test-Path "C:\GameON")) { New-Item -Path "C:\GameON" -ItemType Directory | Out-Null }
Set-Location "C:\GameON"

Write-Host "`n[!] Iniciando conexao segura com o servidor..." -ForegroundColor Yellow

# --- LOGICA PARA PULAR AVISO DO GOOGLE DRIVE ---
$url = "https://docs.google.com/uc?export=download&id=$fileId"
$cookieFile = [System.IO.Path]::GetTempFileName()
try {
    $resp = Invoke-WebRequest -Uri $url -SessionVariable 'sess' -UseBasicParsing
    $token = ($resp.Links | Where-Object { $_.href -like "*confirm=*" }).href.Split('confirm=')[1].Split('&')[0]
    $downloadUrl = "https://docs.google.com/uc?export=download&confirm=$token&id=$fileId"
} catch {
    # Se não precisar de token (arquivos menores), usa a URL direta
    $downloadUrl = $url
}

Write-Host "[!] Baixando jogos (1.5GB)... Por favor, aguarde." -ForegroundColor Cyan
# Download com barra de progresso visivel
Start-BitsTransfer -Source $downloadUrl -Destination $destino -Priority Foreground

Write-Host "`n[!] Extraindo arquivos... Nao feche a janela." -ForegroundColor Yellow
Expand-Archive -Path $destino -DestinationPath "C:\GameON" -Force
Remove-Item $destino -Force

Write-Host "`n[+] INSTALACAO FINALIZADA COM SUCESSO!" -ForegroundColor Green
Write-Host "[+] Seus jogos estao em C:\GameON"
pause
