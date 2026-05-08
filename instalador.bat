# GAMEON DIGITAL - INSTALADOR OFICIAL
$senhaCorreta = "2727"
$urlDownload = "https://docs.google.com/uc?export=download&id=17_OBFcod8dKv6rXhg8_T2gfkohYZ8hx-&confirm=t"

Clear-Host
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "          GAMEON DIGITAL - ACESSO" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
$tentativa = Read-Host "Digite sua Chave de Acesso"

if ($tentativa -ne $senhaCorreta) {
    Write-Host "[ERRO] Chave incorreta!" -ForegroundColor Red
    exit
}

# MENU
Write-Host "`n[1] INSTALAR BIBLIOTECA`n[2] SAIR"
$opcao = Read-Host "Escolha"

if ($opcao -eq "1") {
    $destino = "C:\GameON"
    if (!(Test-Path $destino)) { New-Item -ItemType Directory -Path $destino }
    Set-Location $destino

    Write-Host "`n[!] Baixando arquivos... Isso pode demorar dependendo da sua internet." -ForegroundColor Yellow
    
    # O segredo da velocidade: Start-BitsTransfer (O mesmo que grandes instaladores usam)
    Start-BitsTransfer -Source $urlDownload -Destination "$destino\JOGOS.zip"
    
    Write-Host "[!] Extraindo jogos..." -ForegroundColor Cyan
    Expand-Archive -Path "$destino\JOGOS.zip" -DestinationPath $destino -Force
    Remove-Item "$destino\JOGOS.zip" -Force
    
    Write-Host "`n[+] INSTALACAO CONCLUIDA COM SUCESSO!" -ForegroundColor Green
    pause
}
