@echo off
title GameOn Digital - Central de Jogos
color 0A

:menu
cls
echo ============================================
echo           GAMEON DIGITAL - MENU
echo ============================================
echo.
echo  [1] INSTALAR BIBLIOTECA (BAIXAR TUDO)
echo  [2] ATUALIZAR ARQUIVOS
echo  [3] DESINSTALAR (REMOVER TUDO)
echo  [4] SAIR
echo.
echo ============================================
set /p opcao="Escolha uma opcao: "

if "%opcao%"=="1" goto :instalar
if "%opcao%"=="2" goto :atualizar
if "%opcao%"=="3" goto :desinstalar
if "%opcao%"=="4" exit
goto :menu

:instalar
cls
echo [!] Iniciando Instalacao...
echo Baixando arquivos (1.5GB)... Isso pode demorar.
:: Usei o link direto corrigido abaixo
curl -L "https://www.mediafire.com/download/baoqw8uen6qnh83" -o JOGOS_GameON.zip
echo.
echo [!] Extraindo jogos...
tar -xf JOGOS_GameON.zip
del JOGOS_GameON.zip
echo.
echo [+] Instalacao concluida!
pause
goto :menu

:atualizar
cls
echo [!] Verificando atualizacoes...
curl -L "https://www.mediafire.com/download/baoqw8uen6qnh83" -o JOGOS_GameON.zip
tar -xf JOGOS_GameON.zip -m
del JOGOS_GameON.zip
echo [+] Arquivos atualizados!
pause
goto :menu

:desinstalar
cls
echo [!] ATENCAO: Isso vai apagar a pasta de jogos.
set /p confirma="Tem certeza? (S/N): "
if /i "%confirma%"=="S" (
    rd /s /q "JOGOS_STEAM_GameON" 2>nul
    echo.
    echo [-] Arquivos removidos.
)
pause
goto :menu
