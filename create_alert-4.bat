@echo off

set /p type="Entrez le type d'alerte (I pour Information, A pour Avertissement, E pour Erreur, Q pour Question) : "
set /p message="Entrez le message de l'alerte : "
set /p title="Entrez le titre de l'alerte : "
set /p timeout="Entrez le temps d'affichage en secondes (0 pour une durée illimitée) : "
set /p button_label="Entrez le libellé du bouton personnalisé (laisser vide pour ne pas en ajouter) : "
set /p button_link="Entrez l'emplacement de la cible du bouton personnalisé (URL ou chemin absolu) : "

set "button_command="
if not "%button_link%"=="" set "button_command=start ""%button_link%"""

if /i "%type%"=="I" (
    PowerShell -Command "& {Add-Type -AssemblyName 'System.Windows.Forms'; [System.Windows.Forms.MessageBox]::Show('%message%', '%title%', 'OK', 'Information', 0, [System.Windows.Forms.MessageBoxOptions]::DefaultDesktopOnly, '%button_command%', '%button_label%')}"
) else if /i "%type%"=="A" (
    PowerShell -Command "& {Add-Type -AssemblyName 'System.Windows.Forms'; [System.Windows.Forms.MessageBox]::Show('%message%', '%title%', 'OK', 'Warning', 0, [System.Windows.Forms.MessageBoxOptions]::DefaultDesktopOnly, '%button_command%', '%button_label%')}"
) else if /i "%type%"=="E" (
    PowerShell -Command "& {Add-Type -AssemblyName 'System.Windows.Forms'; [System.Windows.Forms.MessageBox]::Show('%message%', '%title%', 'OK', 'Error', 0, [System.Windows.Forms.MessageBoxOptions]::DefaultDesktopOnly, '%button_command%', '%button_label%')}"
) else if /i "%type%"=="Q" (
    PowerShell -Command "& {Add-Type -AssemblyName 'System.Windows.Forms'; [System.Windows.Forms.MessageBox]::Show('%message%', '%title%', 'YesNo', 'Question', 0, [System.Windows.Forms.MessageBoxOptions]::DefaultDesktopOnly, '%button_command%', '%button_label%')}"
) else (
    echo Type d'alerte invalide
)

timeout /t %timeout% > nul
