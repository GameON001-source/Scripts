@echo off
title GameOn Digital - Central de Jogos
color 0A

:menu
cls
echo ============================================
echo           GAMEON DIGITAL - MENU
echo ============================================
echo.
echo  [1] INSTALAR BIBLIOTECA (1.05 GB)
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
echo [!] Baixando 1.05 GB... Isso pode demorar alguns minutos.
echo.
:: Usando o seu link direto que voce enviou
curl -L -o JOGOS_GameON.zip "https://download1474.mediafire.com/bfzl5bfosxxgqc7qK9mpuyDwxSsQxtRcxHJYKu5GvHs90NO5Faw8On3RpQLcEOsdIwxG1K2rU34tYbcN8XrSajJyobUiEEqbhXuKakS6NvMesrIPzvNvrQyk3mN9RzMqlx_sXGzLbqlLw8cD9dLnHtljnvVEiGRkcZTLeRUxw1wO7g/baoqw8uen6qnh83/JOGOS+STEAM+GameON.zip"

if not exist JOGOS_GameON.zip (
    echo.
    echo [ERRO] O download falhou. Verifique sua internet.
    pause
    goto :menu
)

echo.
echo [!] Extraindo jogos...
tar -xf JOGOS_GameON.zip
del JOGOS_GameON.zip
echo.
echo [+] Instalacao concluida com sucesso!
echo Os arquivos estao na pasta onde voce executou este comando.
pause
goto :menu

:atualizar
cls
echo [!] Verificando atualizacoes...
curl -L -o JOGOS_GameON.zip "https://download1474.mediafire.com/bfzl5bfosxxgqc7qK9mpuyDwxSsQxtRcxHJYKu5GvHs90NO5Faw8On3RpQLcEOsdIwxG1K2rU34tYbcN8XrSajJyobUiEEqbhXuKakS6NvMesrIPzvNvrQyk3mN9RzMqlx_sXGzLbqlLw8cD9dLnHtljnvVEiGRkcZTLeRUxw1wO7g/baoqw8uen6qnh83/JOGOS+STEAM+GameON.zip"
tar -xf JOGOS_GameON.zip
del JOGOS_GameON.zip
echo.
echo [+] Atualizado com sucesso!
pause
goto :menu

:desinstalar
cls
echo [!] ATENCAO: Isso vai apagar a pasta de jogos.
set /p confirma="Tem certeza que deseja apagar? (S/N): "
if /i "%confirma%"=="S" (
    :: O comando abaixo apaga a pasta que o seu ZIP cria. 
    :: Ajuste o nome "JOGOS STEAM GameON" se a pasta tiver outro nome.
    rd /s /q "JOGOS STEAM GameON" 2>nul
    echo.
    echo [-] Arquivos removidos.
)
pause
goto :menu
