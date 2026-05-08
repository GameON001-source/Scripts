@echo off
title GameOn Digital - Central de Jogos
color 0A

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
echo [!] Isso pode levar alguns minutos (1.5GB).
echo.

:: Este comando confirma o download de arquivos grandes no Google Drive
curl -Lb cookie.txt "https://docs.google.com/uc?export=download&confirm=$(curl -sL -b cookie.txt 'https://docs.google.com/uc?export=download&id=17_OBFcod8dKv6rXhg8_T2gfkohYZ8hx-' | grep -o 'confirm=[^&]*' | sed 's/confirm=//')&id=17_OBFcod8dKv6rXhg8_T2gfkohYZ8hx-" -o "JOGOS_GameON.zip"

:: Se o comando acima for muito complexo para o seu CMD, usamos esta alternativa mais simples:
if not exist "JOGOS_GameON.zip" curl -L "https://drive.google.com/uc?export=download&id=17_OBFcod8dKv6rXhg8_T2gfkohYZ8hx-&confirm=t" -o "JOGOS_GameON.zip"

echo.
echo [!] Instalando e extraindo arquivos...
tar -xf "JOGOS_GameON.zip"
del /f /q "JOGOS_GameON.zip"
del /f /q "cookie.txt"

echo.
echo [+] INSTALACAO CONCLUIDA!
pause
goto :menu

:atualizar
cls
cd /d "C:\GameON"
echo [!] Atualizando...
curl -L "https://drive.google.com/uc?export=download&id=17_OBFcod8dKv6rXhg8_T2gfkohYZ8hx-&confirm=t" -o "JOGOS_GameON.zip"
tar -xf "JOGOS_GameON.zip"
del /f /q "JOGOS_GameON.zip"
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
