# Setup GameOn Digital - Versão Final Ultra-Estável
$senhaCorreta = "2727"
$caminhoFinal = "C:\GameON"
$zipTemp = "$env:TEMP\jogos_gameon.zip"

Clear-Host
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "          GAMEON DIGITAL - ACESSO" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
$tentativa = Read-Host "Digite sua Chave de Acesso"

if ($tentativa -ne $senhaCorreta) {
    Write-Host "`n[ERRO] Senha incorreta! O programa sera fechado." -ForegroundColor Red
    pause
    exit
}

# VERIFICAÇÃO DE ADMINISTRADOR (Necessário para instalar no C:)
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "`n[!] ERRO: VOCE PRECISA EXECUTAR COMO ADMINISTRADOR." -ForegroundColor Red
    Write-Host "[!] Feche, clique com o botao direito no PowerShell e escolha 'Executar como Administrador'." -ForegroundColor Yellow
    pause
    exit
}

Clear-Host
Write-Host "[!] Iniciando instalacao..." -ForegroundColor Yellow

# 1. Criar a pasta no C: (Forçado)
if (!(Test-Path $caminhoFinal)) {
    Write-Host "[+] Criando diretorio $caminhoFinal..." -ForegroundColor Gray
    New-Item -Path $caminhoFinal -ItemType Directory -Force | Out-Null
}

# 2. Download Direto (Ignora aviso de vírus do Google Drive)
Write-Host "[!] Baixando arquivos da biblioteca... Aguarde." -ForegroundColor Cyan
$url = "https://docs.google.com/uc?export=download&id=17_OBFcod8dKv6rXhg8_T2gfkohYZ8hx-&confirm=t"
curl.exe -L $url -o $zipTemp

# 3. Verificação e Extração
if (Test-Path $zipTemp) {
    $tamanho = (Get-Item $zipTemp).length
    if ($tamanho -gt 1000) {
        Write-Host "[!] Extraindo arquivos para $caminhoFinal..." -ForegroundColor Yellow
        # Usa o TAR do Windows para extrair o ZIP
        tar.exe -xf $zipTemp -C $caminhoFinal
        
        # Limpa o arquivo temporário
        Remove-Item $zipTemp -Force
        
        Write-Host "`n============================================" -ForegroundColor Green
        Write-Host "      INSTALACAO CONCLUIDA COM SUCESSO!" -ForegroundColor Green
        Write-Host "   Os jogos estao prontos em: $caminhoFinal" -ForegroundColor Green
        Write-Host "============================================" -ForegroundColor Green
    } else {
        Write-Host "[ERRO] O arquivo baixado parece estar vazio ou corrompido." -ForegroundColor Red
    }
} else {
    Write-Host "[ERRO] Falha critica no download. Verifique sua internet." -ForegroundColor Red
}

pause
