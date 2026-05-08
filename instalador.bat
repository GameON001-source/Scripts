# Central GameOn Digital - Versao PowerShell
$senhaCorreta = "2727"

function Mostrar-Menu {
    Clear-Host
    Write-Host "============================================" -ForegroundColor Cyan
    Write-Host "          GAMEON DIGITAL - MENU" -ForegroundColor Cyan
    Write-Host "============================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host " [1] INSTALAR BIBLIOTECA"
    Write-Host " [2] ATUALIZAR ARQUIVOS"
    Write-Host " [3] DESINSTALAR TUDO"
    Write-Host " [4] SAIR"
    Write-Host ""
    Write-Host "============================================" -ForegroundColor Cyan
}

Clear-Host
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "          GAMEON DIGITAL - ACESSO" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
$tentativa = Read-Host " Digite sua Chave de Acesso"

if ($tentativa -eq $senhaCorreta) {
    do {
        Mostrar-Menu
        $opcao = Read-Host " Escolha uma opcao"

        switch ($opcao) {
            "1" {
                Clear-Host
                Write-Host "[!] Preparando pasta C:\GameON..." -ForegroundColor Yellow
                if (!(Test-Path "C:\GameON")) { New-Item -Path "C:\GameON" -ItemType Directory | Out-Null }
                
                Write-Host "[!] Baixando arquivos... Aguarde." -ForegroundColor Cyan
                # O comando abaixo baixa e mostra a barra de progresso no topo
                $url = "https://docs.google.com/uc?export=download&id=17_OBFcod8dKv6rXhg8_T2gfkohYZ8hx-&confirm=t"
                Start-BitsTransfer -Source $url -Destination "C:\GameON\JOGOS_GameON.zip" -DisplayName "Baixando Biblioteca GameOn"

                Write-Host "[!] Instalando e extraindo jogos..." -ForegroundColor Yellow
                Expand-Archive -Path "C:\GameON\JOGOS_GameON.zip" -DestinationPath "C:\GameON" -Force
                Remove-Item "C:\GameON\JOGOS_GameON.zip" -Force
                
                Write-Host "`n[+] INSTALACAO CONCLUIDA COM SUCESSO!" -ForegroundColor Green
                pause
            }
            "2" {
                Write-Host "[!] Verificando atualizacoes..." -ForegroundColor Cyan
                Start-BitsTransfer -Source "https://docs.google.com/uc?export=download&id=17_OBFcod8dKv6rXhg8_T2gfkohYZ8hx-&confirm=t" -Destination "C:\GameON\JOGOS_GameON.zip"
                Expand-Archive -Path "C:\GameON\JOGOS_GameON.zip" -DestinationPath "C:\GameON" -Force
                Remove-Item "C:\GameON\JOGOS_GameON.zip" -Force
                Write-Host "[+] Tudo atualizado!" -ForegroundColor Green
                pause
            }
            "3" {
                $confirm = Read-Host " Deseja apagar TUDO em C:\GameON? (S/N)"
                if ($confirm -eq "S" -or $confirm -eq "s") {
                    Remove-Item "C:\GameON" -Recurse -Force
                    Write-Host "[-] Removido com sucesso." -ForegroundColor Yellow
                }
                pause
            }
            "4" { exit }
        }
    } while ($opcao -ne "4")
} else {
    Write-Host "`n[ERRO] Chave incorreta! Acesso negado." -ForegroundColor Red
    pause
}
