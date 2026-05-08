# =====================================================================
# GAMEON DIGITAL - GESTÃO DE BIBLIOTECA V1.0
# =====================================================================

$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$Host.UI.RawUI.WindowTitle = "GameOn Digital - Instalador Oficial"
Clear-Host

# Habilita cores no console do Windows
if ($host.Name -eq 'ConsoleHost') {
    $mode = Get-ItemProperty -Path "HKCU:\Console" -Name "VirtualTerminalLevel" -ErrorAction SilentlyContinue
    if (-not $mode) {
        New-ItemProperty -Path "HKCU:\Console" -Name "VirtualTerminalLevel" -PropertyType DWord -Value 1 -Force | Out-Null
    }
}

# ===== ACESSO =====
$senhaCorreta = "2727"
Write-Host "----------------------------------------" -ForegroundColor Cyan
$inputSenha = Read-Host " DIGITE A CHAVE DE ACESSO (GAMEON) "
if ($inputSenha -ne $senhaCorreta) { 
    Write-Host "`n[ERRO] Acesso negado. Chave incorreta." -ForegroundColor Red
    Start-Sleep -Seconds 3
    exit 
}

function Show-Header {
    Clear-Host
    Write-Host "   ____                     ___        " -ForegroundColor Cyan
    Write-Host "  / ___| __ _ _ __ ___   ___/ _ \ _ __  " -ForegroundColor Cyan
    Write-Host " | |  _ / _` | '_ ` _ \ / _ \ | | | '_ \ " -ForegroundColor Cyan
    Write-Host " | |_| | (_| | | | | | |  __/ |_| | | | |" -ForegroundColor Cyan
    Write-Host "  \____|\__,_|_| |_| |_|\___|\___/|_| |_|" -ForegroundColor Cyan
    Write-Host " ----------------------------------------------------" -ForegroundColor White
    Write-Host "         SISTEMA DE INSTALAÇÃO DE ALTA PERFORMANCE" -ForegroundColor Yellow
    Write-Host " ----------------------------------------------------`n" -ForegroundColor White
}

function Executar-Instalacao {
    Show-Header
    
    $destino = "C:\GameON"
    $zipFile = "$env:TEMP\JOGOS_GameON.zip"

    # 1. PREPARAÇÃO
    Write-Host "[!] Preparando ambiente em $destino..." -ForegroundColor Yellow
    if (-not (Test-Path $destino)) { New-Item -ItemType Directory -Path $destino | Out-Null }

    # 2. DOWNLOAD (AGORA BLINDADO COM CURL)
    Write-Host "[!] Baixando pacotes do servidor central... Aguarde." -ForegroundColor Cyan
    $urlDrive = "https://docs.google.com/uc?export=download&id=17_OBFcod8dKv6rXhg8_T2gfkohYZ8hx-&confirm=t"
    
    # O "&" avisa ao PowerShell para rodar um aplicativo externo (curl.exe)
    & curl.exe -L $urlDrive -o $zipFile

    # Verifica se baixou o jogo ou se baixou uma página de erro do Google (menor que 1MB)
    if (Test-Path $zipFile) {
        $tamanho = (Get-Item $zipFile).Length
        if ($tamanho -lt 1000000) {
            Write-Host "`n[ERRO] Falha de comunicação com o Google Drive. O arquivo está vazio." -ForegroundColor Red
            Remove-Item $zipFile -Force
            Pause; return
        }
    } else {
        Write-Host "`n[ERRO] O arquivo não foi baixado." -ForegroundColor Red
        Pause; return
    }

    # 3. EXTRAÇÃO (AGORA BLINDADA COM TAR)
    Write-Host "`n[!] Extraindo arquivos para a biblioteca..." -ForegroundColor Cyan
    try {
        & tar.exe -xf $zipFile -C $destino
        
        # 4. LIMPEZA
        Remove-Item $zipFile -Force -ErrorAction SilentlyContinue
        Write-Host "`n[+] GAMEON DIGITAL INSTALADO COM SUCESSO!" -ForegroundColor Green
        Write-Host "[+] Local: $destino" -ForegroundColor Green
    } catch {
        Write-Host "`n[ERRO] Falha ao extrair. Arquivo corrompido ou espaço insuficiente." -ForegroundColor Red
    }
    Pause
}

function Desinstalar-Tudo {
    Show-Header
    Write-Host "[!] ATENÇÃO: Isso removerá todos os jogos da pasta C:\GameON" -ForegroundColor Red
    $confirma = Read-Host "Deseja continuar? (S/N)"
    if ($confirma -eq 'S' -or $confirma -eq 's') {
        if (Test-Path "C:\GameON") {
            Remove-Item "C:\GameON" -Recurse -Force -ErrorAction SilentlyContinue
            Write-Host "[-] Sistema removido com sucesso." -ForegroundColor Green
        } else {
            Write-Host "[-] A pasta não foi encontrada." -ForegroundColor Yellow
        }
    }
    Pause
}

# ===== MENU PRINCIPAL =====
while ($true) {
    Show-Header
    Write-Host " 1. Instalar Biblioteca de Jogos"
    Write-Host " 2. Atualizar Arquivos"
    Write-Host " 3. Desinstalar Sistema"
    Write-Host " 4. Sair do Instalador"
    $opt = Read-Host "`nEscolha uma opção"

    switch ($opt) {
        "1" { Executar-Instalacao }
        "2" { Executar-Instalacao } 
        "3" { Desinstalar-Tudo }
        "4" { exit }
    }
}
