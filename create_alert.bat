@echo off
set /p message="Entrez le message de l'alerte : "
set /p title="Entrez le titre de l'alerte : "
set /p timeout="Entrez le temps d'affichage en secondes (0 pour une durée illimitée) : "
msg * "%message%" /time:%timeout% /title:"%title%"
