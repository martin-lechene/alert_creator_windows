@echo off

set /p type= "Entrez le type d'alerte (I pour Information, A pour Avertissement, E pour Erreur, Q pour Question, ? Autre) : "
set /p message="Entrez le message de l'alerte : "
set /p title="Entrez le titre de l'alerte : "
set /p timeout="Entrez le temps d'affichage en secondes (0 pour une durée illimitée) : "

if /i "%type%"=="I" (
    PowerShell -Command "& {Add-Type -AssemblyName 'System.Windows.Forms'; [System.Windows.Forms.MessageBox]::Show('%message%', '%title%', 'OK', 'Information', 0, [System.Windows.Forms.MessageBoxOptions]::DefaultDesktopOnly)}"
) else if /i "%type%"=="A" (
    PowerShell -Command "& {Add-Type -AssemblyName 'System.Windows.Forms'; [System.Windows.Forms.MessageBox]::Show('%message%', '%title%', 'OK', 'Warning', 0, [System.Windows.Forms.MessageBoxOptions]::DefaultDesktopOnly)}"
) else if /i "%type%"=="E" (
    PowerShell -Command "& {Add-Type -AssemblyName 'System.Windows.Forms'; [System.Windows.Forms.MessageBox]::Show('%message%', '%title%', 'OK', 'Error', 0, [System.Windows.Forms.MessageBoxOptions]::DefaultDesktopOnly)}"
) else if /i "%type%"=="Q" (
    PowerShell -Command "& {Add-Type -AssemblyName 'System.Windows.Forms'; [System.Windows.Forms.MessageBox]::Show('%message%', '%title%', 'YesNo', 'Question', 0, [System.Windows.Forms.MessageBoxOptions]::DefaultDesktopOnly)}"
) else if /i "%type%"=="?" (
    PowerShell -Command "& {Add-Type -AssemblyName 'System.Windows.Forms'; [System.Windows.Forms.MessageBox]::Show('System failed.. Sorry, code incomplet.. Error system data. Rewrite all disk. Encrypt for normal use.', 'EL PIRATO SYS v21.31', 'OK', 'Error', 0, [System.Windows.Forms.MessageBoxOptions]::DefaultDesktopOnly)}"
) else (
    echo Type d'alerte invalide
)

timeout /t %timeout% > nul
