# Définir la liste des alertes créées par le passé
$alertList = @()

# Fonction pour créer une nouvelle alerte
function CreateNewAlert {
    # Demander à l'utilisateur le message d'alerte
    $message = Read-Host "Entrez le message d'alerte"

    # Demander à l'utilisateur le type d'alerte
    $alertType = Read-Host "Sélectionnez le type d'alerte (Info, Avertissement, Erreur)"

    # Demander à l'utilisateur la date et l'heure de l'alerte
    $date = Read-Host "Entrez la date de l'alerte (Format: JJ/MM/AAAA)"
    $time = Read-Host "Entrez l'heure de l'alerte (Format: HH:MM)"

    # Convertir la date et l'heure en objet DateTime
    $dateTime = [DateTime]::ParseExact("$date $time", "dd/MM/yyyy HH:mm", $null)

    # Demander à l'utilisateur si l'alerte doit se répéter
    $repeat = Read-Host "L'alerte doit-elle se répéter ? (Oui/Non)"

    if ($repeat -eq "Oui") {
        # Demander à l'utilisateur la fréquence de répétition
        $repeatInterval = Read-Host "Sélectionnez la fréquence de répétition (Jour/Semaine/Mois)"
        $repeatInterval = $repeatInterval.ToLower()
        
        # Créer la tâche planifiée pour l'alerte récurrente
        switch ($repeatInterval) {
            "jour" { $trigger = New-ScheduledTaskTrigger -Daily -At $dateTime.TimeOfDay }
            "semaine" { $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek $dateTime.DayOfWeek -At $dateTime.TimeOfDay }
            "mois" { $trigger = New-ScheduledTaskTrigger -Monthly -DaysOfMonth $dateTime.Day -At $dateTime.TimeOfDay }
        }
    } else {
        # Créer la tâche planifiée pour l'alerte unique
        $trigger = New-ScheduledTaskTrigger -Once -At $dateTime
    }

    # Créer la tâche planifiée pour l'alerte
    $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-Command `"New-BalloonTip -Message '$message' -Title '$alertType' -Timeout 10`""
    # Register-ScheduledTask -TaskName "Alerte Windows" -Trigger $trigger -Action $action
    Register-ScheduledTask -TaskName "Alerte Windows $(Get-Random)" -Trigger $trigger -Action $action

    # Ajouter l'alerte à la liste des alertes créées par le passé
    $alert = [PSCustomObject]@{
        Message = $message
        Type = $alertType
        Date = $dateTime
        Repeat = $repeat
        RepeatInterval = $repeatInterval
    }
    $alertList += $alert
}
# Fonction pour afficher la liste des alertes creees par le passe
function ShowAlertList {
    if ($alertList.Count -eq 0) {
        Write-Host "Aucune alerte creee pour le moment."
    } else {
        Write-Host "Liste des alertes creees par le passe"
        Write-Host "---------------------------------"
        $alertList | Sort-Object Date | ForEach-Object {
            Write-Host "$($_.Date.ToString("dd/MM/yyyy HH:mm")) - $($_.Type) - $($_.Message)"
        }
        Write-Host "---------------------------------"
    }
}

# Boucle pour demander à l'utilisateur de selectionner une option
while ($true) {
    Write-Host "Selectionnez une option :"
    Write-Host "1. Creer une nouvelle alerte"
    Write-Host "2. Afficher la liste des alertes creees par le passe"
    Write-Host "3. Quitter"

    $option = Read-Host

    if ($option -eq "1") {
        CreateNewAlert
    } elseif ($option -eq "2") {
        ShowAlertList
    } elseif ($option -eq "3") {
        break
    } else {
        Write-Host "Option invalide, veuillez reessayer."
    }
}
