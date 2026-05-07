@echo off
title GameOn Digital - Instalador Automatico
color 0A

cls
echo ============================================
echo        GAMEON DIGITAL - INSTALADOR
echo ============================================
echo.
echo [1/3] Baixando biblioteca de jogos (1.5GB)...
echo Aguarde, o tempo depende da sua internet.
echo.

:: O comando abaixo baixa o arquivo direto do seu MediaFire
curl -L "https://www.mediafire.com/file/baoqw8uen6qnh83/JOGOS_STEAM_GameON.zip/file" -o JOGOS_GameON.zip

echo.
echo [2/3] Download concluido! Extraindo arquivos...
echo.

:: O tar extrai o ZIP automaticamente para uma pasta chamada JOGOS_GameON
tar -xf JOGOS_GameON.zip

echo [3/3] Limpando arquivos temporarios...
del JOGOS_GameON.zip

echo.
echo ============================================
echo      INSTALACAO CONCLUIDA COM SUCESSO!
echo    Os jogos estao na pasta JOGOS_STEAM
echo ============================================
echo.
pause
exit
