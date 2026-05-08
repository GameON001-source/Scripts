# ===== FIX DE CODIFICAÇÃO E AMBIENTE =====
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
Clear-Host

# ===== CORES =====
$corPrincipal = "Green"
$corSecundaria = "DarkGreen"

# ===== SUPORTE ANSI =====
if ($host.Name -eq 'ConsoleHost') {

    $mode = Get-ItemProperty `
        -Path "HKCU:\Console" `
        -Name "VirtualTerminalLevel" `
        -ErrorAction SilentlyContinue

    if (-not $mode) {

        New-ItemProperty `
            -Path "HKCU:\Console" `
            -Name "VirtualTerminalLevel" `
            -PropertyType DWord `
            -Value 1 `
            -Force | Out-Null
    }
}

# ===== SENHA =====
$senhaCorreta = "2727"

Write-Host "====================================================" -ForegroundColor $corPrincipal

$inputSenha = Read-Host " DIGITE A SUA CHAVE DE ACESSO GAMEON "

if ($inputSenha -ne $senhaCorreta) {

    Write-Host "`n[!] CHAVE INVÁLIDA." -ForegroundColor Red
    Start-Sleep -Seconds 3
    exit
}

# ===== DETECTAR STEAM =====
$steamReg = Get-ItemProperty `
    "HKCU:\Software\Valve\Steam" `
    -ErrorAction SilentlyContinue

$steamExe = $steamReg.SteamExe

if (-not $steamExe) {

    Write-Host "ERRO: STEAM NÃO ENCONTRADA." -ForegroundColor Red
    pause
    exit
}

$steamDir = [System.IO.Path]::GetDirectoryName($steamExe)
$configDir = Join-Path $steamDir "config"

# ===== BANNER =====
function Show-Header {

    Clear-Host

    Write-Host " ██████╗  █████╗ ███╗   ███╗███████╗ ██████╗ ███╗   ██╗ " -ForegroundColor $corPrincipal
    Write-Host "██╔════╝ ██╔══██╗████╗ ████║██╔════╝██╔═══██╗████╗  ██║ " -ForegroundColor $corPrincipal
    Write-Host "██║  ███╗███████║██╔████╔██║█████╗  ██║   ██║██╔██╗ ██║ " -ForegroundColor $corPrincipal
    Write-Host "██║   ██║██╔══██║██║╚██╔╝██║██╔══╝  ██║   ██║██║╚██╗██║ " -ForegroundColor $corPrincipal
    Write-Host "╚██████╔╝██║  ██║██║ ╚═╝ ██║███████╗╚██████╔╝██║ ╚████║ " -ForegroundColor $corPrincipal
    Write-Host " ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝ " -ForegroundColor $corPrincipal

    Write-Host ""
    Write-Host "====================================================" -ForegroundColor $corPrincipal
    Write-Host "         GAMEON - INSTALAÇÃO ULTRA RÁPIDA" -ForegroundColor $corPrincipal
    Write-Host "====================================================`n" -ForegroundColor $corPrincipal
}

# ===== FECHAR STEAM =====
function Stop-Steam {

    Write-Host "[•] FECHANDO STEAM..." -ForegroundColor $corPrincipal

    Get-Process steam, steamwebhelper `
        -ErrorAction SilentlyContinue | Stop-Process -Force

    Start-Sleep -Seconds 2
}

# ===== INSTALAÇÃO =====
function Executar-Instalacao {

    param ($Modo)

    Show-Header

    # ===== DOWNLOAD =====
    if (-not (Test-Path "KRAYz STORE.zip")) {

        Write-Host "[•] BAIXANDO ARQUIVOS..." -ForegroundColor $corPrincipal

        $ProgressPreference = 'SilentlyContinue'

        $urlDoZip = "https://download1474.mediafire.com/8yr33b8af2iguqXHXEqQpoJp9QG8u93ewiXFtrXcsIwQ2YGndtEAlRDzKmB-KLNO2Mz87sIGLdgPwXioBovB0b4YrZ--I0DCjMWsBvA_7lYA3Gbkw5zeHcJF7ZJt2IaCZ9syMOEf6RMEv2LCHf9R76mF-vHcPfVH1Hd00RoH0JMsGA/baoqw8uen6qnh83/JOGOS+STEAM+GameON.zip"

        try {

            try {

                Start-BitsTransfer `
                    -Source $urlDoZip `
                    -Destination "KRAYz STORE.zip"
            }
            catch {

                Invoke-WebRequest `
                    -Uri $urlDoZip `
                    -OutFile "KRAYz STORE.zip" `
                    -UseBasicParsing `
                    -ErrorAction Stop
            }

            Write-Host "[✓] DOWNLOAD CONCLUÍDO!" -ForegroundColor $corPrincipal
        }
        catch {

            Write-Host "[X] ERRO AO BAIXAR O ARQUIVO." -ForegroundColor Red
            Pause
            return
        }
    }

    Stop-Steam

    # ===== EXTRAÇÃO =====
    Write-Host "[•] EXTRAINDO ARQUIVOS..." -ForegroundColor $corPrincipal

    $tmp = "$env:TEMP\gameon_tmp"

    if (Test-Path $tmp) {
        Remove-Item $tmp -Recurse -Force
    }

    try {

        Expand-Archive `
            -Path "KRAYz STORE.zip" `
            -DestinationPath $tmp `
            -Force

        # ===== LIMPEZA =====
        $limpar = @(
            "$configDir\depotcache",
            "$configDir\stplug-in"
        )

        foreach ($l in $limpar) {

            if (Test-Path $l) {

                Remove-Item `
                    $l `
                    -Recurse `
                    -Force `
                    -ErrorAction SilentlyContinue
            }
        }

        # ===== CÓPIA =====
        if (Test-Path "$tmp\Config") {

            Copy-Item `
                -Path "$tmp\Config\*" `
                -Destination "$configDir\" `
                -Recurse `
                -Force
        }

        if (Test-Path "$tmp\Hid.dll") {

            Copy-Item `
                -Path "$tmp\Hid.dll" `
                -Destination "$steamDir\" `
                -Force
        }

        # ===== MODO FULL =====
        if ($Modo -eq "Full") {

            $folders = @("cache", "temp", "tmp")

            foreach ($f in $folders) {

                $p = Join-Path $steamDir $f

                if (Test-Path $p) {

                    Remove-Item `
                        "$p\*" `
                        -Recurse `
                        -Force `
                        -ErrorAction SilentlyContinue
                }
            }
        }

        Write-Host "`n[✓] INSTALAÇÃO CONCLUÍDA!" -ForegroundColor $corPrincipal
    }
    catch {

        Write-Host "[X] ERRO NA EXTRAÇÃO DO ZIP." -ForegroundColor Red
    }
}

# ===== MENU =====
Show-Header

Write-Host " [1] Atualizar Biblioteca" -ForegroundColor $corPrincipal
Write-Host " [2] Instalação Completa" -ForegroundColor $corPrincipal
Write-Host " [3] Remover Sistema" -ForegroundColor $corPrincipal
Write-Host " [4] Sair" -ForegroundColor $corPrincipal

Write-Host ""
Write-Host "====================================================" -ForegroundColor $corPrincipal

$opt = Read-Host " ESCOLHA UMA OPÇÃO "

switch ($opt) {

    "1" {
        Executar-Instalacao "Normal"
    }

    "2" {
        Executar-Instalacao "Full"
    }

    "3" {

        Stop-Steam

        $files = @(
            "Hid.dll",
            "xinput1_4.dll",
            "dwmapi.dll"
        )

        foreach ($f in $files) {

            $p = Join-Path $steamDir $f

            if (Test-Path $p) {
                Remove-Item $p -Force
            }
        }

        Write-Host "[✓] SISTEMA REMOVIDO!" -ForegroundColor $corPrincipal
    }

    Default {
        exit
    }
}

Write-Host "`n[•] INICIANDO STEAM..." -ForegroundColor $corPrincipal

Start-Process $steamExe

Start-Sleep -Seconds 2
