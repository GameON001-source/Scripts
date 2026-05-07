@echo off
title GameOn Digital - Central de Jogos
color 0A

:: ============================================
:: CONFIGURAÇÃO DA SENHA (ATUALIZADA)
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
echo  [1] INSTALAR BIBLIOTECA (ALTA VELOCIDADE)
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
echo [!] Criando ambiente GameON...
if not exist "C:\GameON" mkdir "C:\GameON"
cd /d "C:\GameON"

echo [!] Iniciando Download de 1.5GB (Google Drive)...
echo Por favor, aguarde a conclusao.
echo.

:: DOWNLOAD DE ALTA VELOCIDADE (BITS)
powershell -Command "Start-BitsTransfer -Source 'https://drive.google.com/uc?export=download&id=17_OBFcod8dKv6rXhg8_T2gfkohYZ8hx-' -Destination 'JOGOS_GameON.zip'"

if not exist "JOGOS_GameON.zip" (
    echo.
    echo [ERRO] Falha ao conectar ao servidor de arquivos.
    pause
    goto :menu
)

echo.
echo [!] Extraindo jogos automaticamente...
tar -xf JOGOS_GameON.zip
del JOGOS_GameON.zip
echo.
echo [+] SUCESSO! Jogos prontos em C:\GameON
pause
goto :menu

:atualizar
cls
cd /d "C:\GameON"
echo [!] Buscando novas versoes...
powershell -Command "Start-BitsTransfer -Source 'https://drive.google.com/uc?export=download&id=17_OBFcod8dKv6rXhg8_T2gfkohYZ8hx-' -Destination 'JOGOS_GameON.zip'"
tar -xf JOGOS_GameON.zip
del JOGOS_GameON.zip
echo.
echo [+] Atualizacao concluida!
pause
goto :menu

:desinstalar
cls
echo [!] ATENCAO: Isso apagara todos os jogos da pasta C:\GameON.
set /p confirma="Confirmar remocao? (S/N): "
if /i "%confirma%"=="S" (
    cd /d C:\
    rd /s /q "C:\GameON"
    echo [-] Limpeza concluida.
)
pause
goto :menu
