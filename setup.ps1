# =====================================================================
# GAMEON DIGITAL - GESTÃO DE BIBLIOTECA V1.0
# =====================================================================

$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$Host.UI.RawUI.WindowTitle = "GameOn Digital - Instalador Oficial"
Clear-Host

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

    Write-Host "[!] Preparando ambiente em $destino..." -ForegroundColor Yellow
    if (-not (Test-Path $destino)) { New-Item -ItemType Directory -Path $destino | Out-Null }

    # 2. DOWNLOAD 
    Write-Host "[!] Baixando pacotes do servidor central... Aguarde." -ForegroundColor Cyan
    $urlDrive = "https://docs.google.com/uc?export=download&id=17_OBFcod8dKv6rXhg8_T2gfkohYZ8hx-&confirm=t"
    
    try {
        Invoke-WebRequest -Uri $urlDrive -OutFile $zipFile -UseBasicParsing -ErrorAction Stop
    } catch {
        Write-Host "`n[ERRO] Falha de conexao com o servidor." -ForegroundColor Red
        Pause; return
    }

    # VERIFICAÇÃO DE INTEGRIDADE (Para barrar o erro do Google Drive)
    $tamanho = (Get-Item $zipFile).Length
    if ($tamanho -lt 1000000) {
        Write-Host "`n[ERRO CRÍTICO] O Google Drive bloqueou o download direto (Aviso de Vírus)." -ForegroundColor Red
        Write-Host "O arquivo baixado está corrompido. Por favor, mude o link para MediaFire." -ForegroundColor Yellow
        Remove-Item $zipFile -Force
        Pause; return
    }

    # 3. EXTRAÇÃO (IDÊNTICA AO GAMEOVER GOD)
    Write-Host "`n[!] Extraindo arquivos..." -ForegroundColor Cyan
    try {
        if (Test-Path "C:\Program Files\WinRAR\WinRAR.exe") {
            Write-Host "[-] Utilizando motor WinRAR..." -ForegroundColor DarkGray
            & "C:\Program Files\WinRAR\WinRAR.exe" x -ibck -y $zipFile $destino
        } elseif (Test-Path "C:\Program Files\7-Zip\7z.exe") {
            Write-Host "[-] Utilizando motor 7-Zip..." -ForegroundColor DarkGray
            & "C:\Program Files\7-Zip\7z.exe" x $zipFile "-o$destino" -y | Out-Null
        } else {
            Write-Host "[-] Utilizando motor nativo..." -ForegroundColor DarkGray
            Expand-Archive -Path $zipFile -DestinationPath $destino -Force -ErrorAction Stop
        }

        Remove-Item $zipFile -Force -ErrorAction SilentlyContinue
        Write-Host "`n[+] GAMEON DIGITAL INSTALADO COM SUCESSO!" -ForegroundColor Green
        Write-Host "[+] Local: $destino" -ForegroundColor Green
    } catch {
        Write-Host "`n[ERRO] Falha Crítica na Extração." -ForegroundColor Red
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
            Write-Host "[-] Sistema removido." -ForegroundColor Green
        }
    }
    Pause
}

# ===== MENU =====
while ($true) {
    Show-Header
    Write-Host " 1. Instalar Biblioteca de Jogos"
    Write-Host " 2. Atualizar Arquivos"
    Write-Host " 3. Desinstalar Sistema"
    Write-Host " 4. Sair"
    $opt = Read-Host "`nEscolha uma opção"

    switch ($opt) {
        "1" { Executar-Instalacao }
        "2" { Executar-Instalacao } 
        "3" { Desinstalar-Tudo }
        "4" { exit }
    }
}
