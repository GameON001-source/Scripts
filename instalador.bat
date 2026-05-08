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
echo.

:: O comando abaixo usa o CURL para baixar direto e mostra o progresso em %
curl -L "https://docs.google.com/uc?export=download&id=17_OBFcod8dKv6rXhg8_T2gfkohYZ8hx-&confirm=t" -o "JOGOS_GameON.zip"

if not exist "JOGOS_GameON.zip" (
    echo.
    echo [ERRO] O arquivo nao foi baixado. Verifique sua internet.
    pause
    goto :menu
)

echo.
echo [!] Instalando e extraindo arquivos... Aguarde.
tar -xf "JOGOS_GameON.zip"
del /f /q "JOGOS_GameON.zip"

echo.
echo [+] INSTALACAO CONCLUIDA COM SUCESSO!
pause
goto :menu

:atualizar
cls
cd /d "C:\GameON"
echo [!] Atualizando...
curl -L "https://docs.google.com/uc?export=download&id=17_OBFcod8dKv6rXhg8_T2gfkohYZ8hx-&confirm=t" -o "JOGOS_GameON.zip"
tar -xf "JOGOS_GameON.zip"
del /f /q "JOGOS_GameON.zip"
echo [+] Atualizado!
pause
goto :menu

:desinstalar
cls
echo [!] Desinstalar tudo?
set /p confirma="(S/N): "
if /i "%confirma%"=="S" (
    cd /d C:\
    rd /s /q "C:\GameON"
    echo [-] Removido.
)
pause
goto :menu
