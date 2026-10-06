@echo off
title Le Peuple Vert - serveur local
cd /d "%~dp0"
set PORT=8000
set PAGE=peuple-vert-v6.html

echo.
echo  === LE PEUPLE VERT : demarrage du serveur local ===
echo.

rem --- 1) Python, s'il est VRAIMENT installe (le faux "python" du Microsoft Store echoue ce test) ---
python -c "import sys" >nul 2>nul
if %errorlevel%==0 (
  echo Serveur Python sur http://localhost:%PORT%/
  start "" cmd /c "timeout /t 2 >nul & start http://localhost:%PORT%/%PAGE%"
  python -m http.server %PORT%
  goto :fin
)

py -c "import sys" >nul 2>nul
if %errorlevel%==0 (
  echo Serveur Python sur http://localhost:%PORT%/
  start "" cmd /c "timeout /t 2 >nul & start http://localhost:%PORT%/%PAGE%"
  py -m http.server %PORT%
  goto :fin
)

rem --- 2) Pas de Python : serveur integre a Windows (PowerShell), rien a installer ---
echo Python non trouve : utilisation du serveur integre (PowerShell).
start "" cmd /c "timeout /t 2 >nul & start http://localhost:%PORT%/%PAGE%"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0serveur.ps1" -Port %PORT%

:fin
echo.
echo ============================================================
echo  Le serveur s'est arrete. Si ce n'est pas voulu, lisez les
echo  messages ci-dessus, puis relancez ce fichier.
echo ============================================================
pause
