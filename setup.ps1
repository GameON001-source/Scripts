# =====================================================================
# GAMEON DIGITAL - GESTÃO DE BIBLIOTECA V1.0
# STATUS: MOTOR DE ALTA PERFORMANCE (MEDIAFIRE + WINRAR)
# =====================================================================

$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$Host.UI.RawUI.WindowTitle = "GameOn Digital - Gestão de Elite v1.0"
Clear-Host

# Ativação de Cores ANSI
if ($host.Name -eq 'ConsoleHost') {
    $mode = Get-ItemProperty -Path "HKCU:\Console" -Name "VirtualTerminalLevel" -ErrorAction SilentlyContinue
    if (-not $mode) {
        New-ItemProperty -Path "HKCU:\Console" -Name "VirtualTerminalLevel" -PropertyType DWord -Value 1 -Force | Out-Null
    }
}

# ===== ACESSO =====
$senhaCorreta = "2727"
Write-Host "----------------------------------------------------" -ForegroundColor Cyan
$inputSenha = Read-Host " DIGITE A SUA CHAVE DE ACESSO GAMEON "
if ($inputSenha -ne $senhaCorreta) { 
    Write-Host "`n[!] Chave Inválida. Verifique em seu painel de compra." -ForegroundColor Red
    Start-Sleep -Seconds 3
    exit 
}

function Show-Header {
    Clear-Host
    Write-Host "   ____                     ___        " -ForegroundColor Cyan
    Write-Host "  / ___| __ _ _ __ ___   ___/ _ \ _ __  " -ForegroundColor Magenta
    Write-Host " | |  _ / _` | '_ ` _ \ / _ \ | | | '_ \ " -ForegroundColor Cyan
    Write-Host " | |_| | (_| | | | | | |  __/ |_| | | | |" -ForegroundColor Magenta
    Write-Host "  \____|\__,_|_| |_| |_|\___|\___/|_| |_|" -ForegroundColor Cyan
    Write-Host " ----------------------------------------------------" -ForegroundColor White
    Write-Host "         MODO: INSTALAÇÃO DE ALTA VELOCIDADE" -ForegroundColor Yellow
    Write-Host " ----------------------------------------------------`n" -ForegroundColor White
}

function Executar-Instalacao {
    Show-Header
    
    $destino = "C:\GameON"
    $zipFile = "$env:TEMP\JOGOS_GameON.zip"
    $urlMediaFire = "https://download1474.mediafire.com/8yr33b8af2iguqXHXEqQpoJp9QG8u93ewiXFtrXcsIwQ2YGndtEAlRDzKmB-KLNO2Mz87sIGLdgPwXioBovB0b4YrZ--I0DCjMWsBvA_7lYA3Gbkw5zeHcJF7ZJt2IaCZ9syMOEf6RMEv2LCHf9R76mF-vHcPfVH1Hd00RoH0JMsGA/baoqw8uen6qnh83/JOGOS+STEAM+GameON.zip"

    # 1. PREPARAÇÃO
    Write-Host "[!] Preparando diretório: $destino" -ForegroundColor Yellow
    if (-not (Test-Path $destino)) { New-Item -ItemType Directory -Path $destino | Out-Null }

    # 2. DOWNLOAD (SEM TRAVAS)
    Write-Host "[!] Conectando ao servidor MediaFire..." -ForegroundColor Cyan
    Write-Host "[!] Baixando pacotes de jogos (Aguarde conclusão)..." -ForegroundColor Cyan
    
    try {
        Invoke-WebRequest -Uri $urlMediaFire -OutFile $zipFile -UseBasicParsing -ErrorAction Stop
    } catch {
        Write-Host "`n[ERRO] O link do MediaFire expirou ou está offline." -ForegroundColor Red
        Pause; return
    }

    # 3. EXTRAÇÃO (LÓGICA GAMEOVER GOD)
    Write-Host "`n[!] Iniciando extração dos arquivos..." -ForegroundColor Cyan
    try {
        if (Test-Path "C:\Program Files\WinRAR\WinRAR.exe") {
            Write-Host "[-] Motor WinRAR detectado. Extraindo..." -ForegroundColor Gray
            & "C:\Program Files\WinRAR\WinRAR.exe" x -ibck -y $zipFile $destino
        } elseif (Test-Path "C:\Program Files\7-Zip\7z.exe") {
            Write-Host "[-] Motor 7-Zip detectado. Extraindo..." -ForegroundColor Gray
            & "C:\Program Files\7-Zip\7z.exe" x $zipFile "-o$destino" -y | Out-Null
        } else {
            Write-Host "[-] Usando motor nativo do Windows..." -ForegroundColor Gray
            Expand-Archive -Path $zipFile -DestinationPath $destino -Force -ErrorAction Stop
        }

        # 4. FINALIZAÇÃO
        if (Test-Path $zipFile) { Remove-Item $zipFile -Force -ErrorAction SilentlyContinue }
        Write-Host "`n[+] BIBLIOTECA INSTALADA COM SUCESSO!" -ForegroundColor Green
        Write-Host "[+] Local: $destino" -ForegroundColor Green
    } catch {
        Write-Host "`n[ERRO] Falha ao extrair arquivos." -ForegroundColor Red
    }
    Pause
}

function Desinstalar-Sistema {
    Show-Header
    Write-Host "[!] ATENÇÃO: Todos os dados em $destino serão removidos." -ForegroundColor Red
    $confirm = Read-Host "Deseja desinstalar? (S/N)"
    if ($confirm -eq 'S' -or $confirm -eq 's') {
        if (Test-Path "C:\GameON") {
            Remove-Item "C:\GameON" -Recurse -Force -ErrorAction SilentlyContinue
            Write-Host "[-] Sistema removido." -ForegroundColor Yellow
        }
    }
    Pause
}

# ===== MENU PRINCIPAL =====
while ($true) {
    Show-Header
    Write-Host " 1. Instalar / Atualizar Biblioteca"
    Write-Host " 2. Verificar Integridade"
    Write-Host " 3. Desinstalar Tudo"
    Write-Host " 4. Sair"
    $opt = Read-Host "`nSelecione uma opção"

    switch ($opt) {
        "1" { Executar-Instalacao }
        "2" { Executar-Instalacao }
        "3" { Desinstalar-Sistema }
        "4" { exit }
    }
}
