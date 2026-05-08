@echo off
title GameOn Digital - Central de Jogos
color 0A

:: SENHA
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
echo  [3] SAIR
echo.
echo ============================================
set /p opcao="Escolha uma opcao: "

if "%opcao%"=="1" goto :instalar
if "%opcao%"=="2" goto :instalar
if "%opcao%"=="3" exit
goto :menu

:instalar
cls
echo [!] Preparando ambiente...
if not exist "C:\GameON" mkdir "C:\GameON"
cd /d "C:\GameON"

echo [!] Baixando arquivos... Aguarde.
echo.

:: COMANDO DE DOWNLOAD DIRETO (SEM POWERSHELL)
bitsadmin /transfer GameOnDownload /download /priority FOREGROUND "https://drive.google.com/uc?export=download&id=17_OBFcod8dKv6rXhg8_T2gfkohYZ8hx-" "C:\GameON\JOGOS_GameON.zip"

if not exist "C:\GameON\JOGOS_GameON.zip" (
    echo.
    echo [ERRO] O download falhou. Tente novamente.
    pause
    goto :menu
)

echo.
echo [!] Instalando...
tar -xf "C:\GameON\JOGOS_GameON.zip" -C "C:\GameON"
del /f /q "C:\GameON\JOGOS_GameON.zip"

echo.
echo [+] INSTALACAO CONCLUIDA!
pause
goto :menu
