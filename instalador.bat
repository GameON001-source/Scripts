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
echo Baixando arquivos do servidor MediaFire...
:: Substitua pelo seu link direto se necessario
curl -L "https://www.mediafire.com/file/baoqw8uen6qnh83/JOGOS_STEAM_GameON.zip/file" -o JOGOS_GameON.zip
echo [!] Extraindo jogos...
tar -xf JOGOS_GameON.zip
del JOGOS_GameON.zip
echo.
echo [+] Instalacao concluida com sucesso!
pause
goto :menu

:atualizar
cls
echo [!] Verificando atualizacoes no GitHub...
:: Aqui ele basicamente roda o processo de baixar novamente para garantir que os arquivos sao os mais novos
curl -L "https://www.mediafire.com/file/baoqw8uen6qnh83/JOGOS_STEAM_GameON.zip/file" -o JOGOS_GameON.zip
tar -xf JOGOS_GameON.zip -m
del JOGOS_GameON.zip
echo.
echo [+] Arquivos atualizados!
pause
goto :menu

:desinstalar
cls
echo [!] ATENCAO: Isso vai apagar a pasta de jogos.
set /p confirma="Tem certeza? (S/N): "
if /i "%confirma%"=="S" (
    :: Altere "JOGOS_STEAM" para o nome exato da pasta que o seu ZIP cria
    rd /s /q "JOGOS_STEAM" 2>nul
    echo.
    echo [-] Arquivos removidos.
) else (
    echo Desinstalacao cancelada.
)
pause
goto :menu
