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
    echo [ERRO] Chave incorreta ou expirada!
    echo Adquira sua licenca em: gameondigital.carrd.co
    pause
    goto :autenticacao
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

:: DOWNLOAD VIA BITS (MOSTRA BARRA DE PROGRESSO NO TOPO)
powershell -Command "Start-BitsTransfer -Source 'https://drive.google.com/uc?export=download&id=17_OBFcod8dKv6rXhg8_T2gfkohYZ8hx-' -Destination 'C:\GameON\JOGOS_GameON.zip'"

if not exist "C:\GameON\JOGOS_GameON.zip" (
    echo.
    echo [ERRO] Nao foi possivel completar o download.
    pause
    goto :menu
)

cls
echo ============================================
echo           GAMEON DIGITAL - INSTALANDO
echo ============================================
echo.
echo [!] Extraindo e instalando arquivos... 
echo [!] Este processo pode levar alguns minutos.
echo.

:: EXTRAÇÃO SILENCIOSA
tar -xf "C:\GameON\JOGOS_GameON.zip" -C "C:\GameON"

:: LIMPEZA DO ARQUIVO ZIP
del /f /q "C:\GameON\JOGOS_GameON.zip"

echo.
echo [+] INSTALACAO CONCLUIDA COM SUCESSO!
echo [+] Local: C:\GameON
echo.
pause
goto :menu

:atualizar
cls
echo [!] Procurando atualizacoes... Aguarde.
cd /d "C:\GameON"
powershell -Command "Start-BitsTransfer -Source 'https://drive.google.com/uc?export=download&id=17_OBFcod8dKv6rXhg8_T2gfkohYZ8hx-' -Destination 'C:\GameON\JOGOS_GameON.zip'"
tar -xf "C:\GameON\JOGOS_GameON.zip" -C "C:\GameON"
del /f /q "C:\GameON\JOGOS_GameON.zip"
echo.
echo [+] Atualizado com sucesso!
pause
goto :menu

:desinstalar
cls
echo [!] ATENCAO: Todos os dados da pasta C:\GameON serao removidos.
set /p confirma="Deseja continuar? (S/N): "
if /i "%confirma%"=="S" (
    cd /d C:\
    rd /s /q "C:\GameON"
    echo.
    echo [-] Remocao concluida.
)
pause
goto :menu
