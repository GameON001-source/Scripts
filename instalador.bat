@echo off
title GameOn Digital - Central de Jogos
color 0A

:: ============================================
:: CONFIGURAÇÃO DA SENHA
:: ============================================
set "senhaCorreta=2727"

:autenticacao
cls
echo ============================================
echo           GAMEON DIGITAL - ACESSO
echo ============================================
echo.
set /p "tentativa=Digite sua Chave de Acesso: "

if "%tentativa%"=="%senhaCorreta%" (
    goto :menu
) else (
    echo.
    echo [ERRO] Chave incorreta!
    pause
    exit
)

:menu
cls
echo ============================================
echo           GAMEON DIGITAL - MENU
echo ============================================
echo.
echo  [1] INSTALAR BIBLIOTECA
echo  [2] ATUALIZAR ARQUIVOS
echo  [3] DESINSTALAR TUDO
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
echo [!] Preparando ambiente...
if not exist "C:\GameON" mkdir "C:\GameON"
cd /d "C:\GameON"
echo [!] Baixando arquivos... Aguarde.
powershell -Command "Start-BitsTransfer -Source 'https://drive.google.com/uc?export=download&id=17_OBFcod8dKv6rXhg8_T2gfkohYZ8hx-' -Destination 'C:\GameON\JOGOS_GameON.zip'"
echo [!] Instalando...
powershell -Command "Expand-Archive -Path 'C:\GameON\JOGOS_GameON.zip' -DestinationPath 'C:\GameON' -Force"
del /f /q "C:\GameON\JOGOS_GameON.zip"
echo.
echo [+] INSTALACAO CONCLUIDA!
pause
goto :menu

:atualizar
cls
cd /d "C:\GameON"
echo [!] Atualizando...
powershell -Command "Start-BitsTransfer -Source 'https://drive.google.com/uc?export=download&id=17_OBFcod8dKv6rXhg8_T2gfkohYZ8hx-' -Destination 'C:\GameON\JOGOS_GameON.zip'"
powershell -Command "Expand-Archive -Path 'C:\GameON\JOGOS_GameON.zip' -DestinationPath 'C:\GameON' -Force"
del /f /q "C:\GameON\JOGOS_GameON.zip"
echo [+] Atualizado!
pause
goto :menu

:desinstalar
cls
echo [!] Desinstalando...
rd /s /q "C:\GameON" 2>nul
echo [-] Pasta removida.
pause
goto :menu
