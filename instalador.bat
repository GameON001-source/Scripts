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
echo.

:: O CMD CHAMA O POWERSHELL ESCONDIDO PARA PULAR O ERRO DO GOOGLE DRIVE
powershell -NoProfile -ExecutionPolicy Bypass -Command "$id='17_OBFcod8dKv6rXhg8_T2gfkohYZ8hx-'; $url='https://docs.google.com/uc?export=download&id='+$id; $res=Invoke-WebRequest -Uri $url -SessionVariable s -UserAgent 'Mozilla/5.0'; $token=($res.Links | Where-Object {$_.href -like '*confirm=*'}).href.Split('confirm=')[1].Split('&')[0]; if($token){$url=$url+'&confirm='+$token}; Start-BitsTransfer -Source $url -Destination 'JOGOS_GameON.zip'"

if not exist "JOGOS_GameON.zip" (
    echo.
    echo [ERRO] O download falhou. Verifique sua conexao.
    pause
    goto :menu
)

echo [!] Instalando jogos...
:: EXTRAÇÃO VIA POWERSHELL (MAIS SEGURA CONTRA ARQUIVO CORROMPIDO)
powershell -Command "Expand-Archive -Path 'JOGOS_GameON.zip' -DestinationPath 'C:\GameON' -Force"
del /f /q "JOGOS_GameON.zip"

echo.
echo [+] INSTALACAO CONCLUIDA COM SUCESSO!
echo [+] Pasta: C:\GameON
pause
goto :menu

:atualizar
cls
cd /d "C:\GameON"
echo [!] Atualizando arquivos...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$id='17_OBFcod8dKv6rXhg8_T2gfkohYZ8hx-'; $url='https://docs.google.com/uc?export=download&id='+$id; $res=Invoke-WebRequest -Uri $url -SessionVariable s -UserAgent 'Mozilla/5.0'; $token=($res.Links | Where-Object {$_.href -like '*confirm=*'}).href.Split('confirm=')[1].Split('&')[0]; if($token){$url=$url+'&confirm='+$token}; Start-BitsTransfer -Source $url -Destination 'JOGOS_GameON.zip'"
powershell -Command "Expand-Archive -Path 'JOGOS_GameON.zip' -DestinationPath 'C:\GameON' -Force"
del /f /q "JOGOS_GameON.zip"
echo [+] Tudo atualizado!
pause
goto :menu

:desinstalar
cls
echo [!] Apagando todos os jogos em C:\GameON...
rd /s /q "C:\GameON" 2>nul
echo [-] Pasta removida.
pause
goto :menu
