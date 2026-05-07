@echo off
title GameOn Digital - Central de Jogos
color 0A

:menu
cls
echo ============================================
echo           GAMEON DIGITAL - MENU
echo ============================================
echo.
echo  [1] INSTALAR BIBLIOTECA (1.5GB)
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
echo [!] Criando pasta GameON no C:\...
if not exist "C:\GameON" mkdir "C:\GameON"
cd /d "C:\GameON"

echo [!] Iniciando Download (1.5GB)...
echo Isso pode demorar varios minutos dependendo da sua internet.
echo.
:: Usando o seu Link Direto atualizado
curl -L "https://download1474.mediafire.com/bfzl5bfosxxgqc7qK9mpuyDwxSsQxtRcxHJYKu5GvHs90NO5Faw8On3RpQLcEOsdIwxG1K2rU34tYbcN8XrSajJyobUiEEqbhXuKakS6NvMesrIPzvNvrQyk3mN9RzMqlx_sXGzLbqlLw8cD9dLnHtljnvVEiGRkcZTLeRUxw1wO7g/baoqw8uen6qnh83/JOGOS+STEAM+GameON.zip" -o JOGOS_GameON.zip

if %errorlevel% neq 0 (
    echo.
    echo [ERRO] O link de download expirou! 
    echo Por favor, contate o suporte GameOn.
    pause
    goto :menu
)

echo.
echo [!] Download concluido! Extraindo jogos...
tar -xf JOGOS_GameON.zip
del JOGOS_GameON.zip
echo.
echo [+] Tudo pronto! Seus jogos estao em C:\GameON
pause
goto :menu

:atualizar
cls
cd /d "C:\GameON"
echo [!] Verificando atualizacoes...
curl -L "https://download1474.mediafire.com/bfzl5bfosxxgqc7qK9mpuyDwxSsQxtRcxHJYKu5GvHs90NO5Faw8On3RpQLcEOsdIwxG1K2rU34tYbcN8XrSajJyobUiEEqbhXuKakS6NvMesrIPzvNvrQyk3mN9RzMqlx_sXGzLbqlLw8cD9dLnHtljnvVEiGRkcZTLeRUxw1wO7g/baoqw8uen6qnh83/JOGOS+STEAM+GameON.zip" -o JOGOS_GameON.zip
tar -xf JOGOS_GameON.zip
del JOGOS_GameON.zip
echo.
echo [+] Arquivos atualizados com sucesso!
pause
goto :menu

:desinstalar
cls
echo [!] ATENCAO: Todos os jogos em C:\GameON serao apagados.
set /p confirma="Deseja continuar? (S/N): "
if /i "%confirma%"=="S" (
    cd /d C:\
    rd /s /q "C:\GameON"
    echo.
    echo [-] Pasta removida com sucesso.
)
pause
goto :menu
