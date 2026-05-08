@echo off
title GameOn Digital - Central de Jogos
color 0A

:: ============================================
:: CONFIGURAÇÃO DE ACESSO
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
    echo Adquira sua licenca em: gameondigital.carrd.co
    pause
    exit
)

:menu
cls
echo ============================================
echo           GAMEON DIGITAL - MENU
echo ============================================
echo.
echo  [1] INSTALAR BIBLIOTECA DE JOGOS
echo  [2] ATUALIZAR ARQUIVOS
echo  [3] DESINSTALAR TUDO
echo  [4] SAIR
echo.
echo ============================================
set /p opcao="Escolha uma opcao: "

if "%opcao%"=="1" goto :instalar
if "%opcao%"=="2" goto :instalar
if "%opcao%"=="3" goto :desinstalar
if "%opcao%"=="4" exit
goto :menu

:instalar
cls
echo [!] Preparando ambiente em C:\GameON...
if not exist "C:\GameON" mkdir "C:\GameON"
cd /d "C:\GameON"

echo [!] Baixando arquivos... Aguarde ate concluir (100%%).
echo.

:: DOWNLOAD DIRETO VIA MEDIAFIRE (LINK ATUALIZADO)
curl -L "https://download1474.mediafire.com/8yr33b8af2iguqXHXEqQpoJp9QG8u93ewiXFtrXcsIwQ2YGndtEAlRDzKmB-KLNO2Mz87sIGLdgPwXioBovB0b4YrZ--I0DCjMWsBvA_7lYA3Gbkw5zeHcJF7ZJt2IaCZ9syMOEf6RMEv2LCHf9R76mF-vHcPfVH1Hd00RoH0JMsGA/baoqw8uen6qnh83/JOGOS+STEAM+GameON.zip" -o "JOGOS.zip"

:: Validação: Se o arquivo tiver menos de 1MB, o link provavelmente expirou
for %%A in ("JOGOS.zip") do if %%~zA LSS 1000000 (
    echo.
    echo [ERRO] O download falhou ou o link expirou.
    echo Por favor, gere um novo link no MediaFire e atualize o script.
    del "JOGOS.zip"
    pause
    goto :menu
)

echo.
echo [!] Extraindo jogos... Isso pode levar alguns minutos.
tar -xf "JOGOS.zip"
del /f /q "JOGOS.zip"

echo.
echo [+] INSTALACAO CONCLUIDA COM SUCESSO!
echo [+] Seus jogos estao prontos em C:\GameON
echo.
pause
goto :menu

:desinstalar
cls
echo [!] ATENCAO: Isso apagara todos os jogos da pasta C:\GameON.
set /p confirma="Deseja continuar? (S/N): "
if /i "%confirma%"=="S" (
    cd /d C:\
    rd /s /q "C:\GameON"
    echo.
    echo [-] Remocao concluida.
)
pause
goto :menu
