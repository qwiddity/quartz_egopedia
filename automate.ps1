# Initialize variables to store directory state and previous state
$currentState = ""
$prevState = ""

# Function to display an animated ellipsis
function ShowEllipsis ($message) {
    $ellipsis = ""
    for ($i=0; $i -lt 4; $i++) {
        Write-Host -NoNewline ("$message$ellipsis`r")
        Start-Sleep -Seconds 1
        $ellipsis += "."
    }
}

# Main loop
while ($true) {
    # Display "Waiting to scan..." message with active ellipsis
    for ($i=0; $i -lt 900; $i++) {  # 15 minutes = 900 seconds
        ShowEllipsis "Waiting to scan"
    }

    # Display "Scanning for changes..." message with active ellipsis
    ShowEllipsis "Scanning for changes"

    # Capture current directory state
    $currentState = Get-ChildItem | Out-String

    # Compare current and previous directory states
    if ($currentState -ne $prevState) {
        $output = Invoke-Expression -Command "npx quartz sync"  # Run the sync command
        Write-Host $output
    } else {
        Write-Host "No changes found."
    }

    # Pause for 30 seconds to show the message or output
    Start-Sleep -Seconds 30

    # Clear the console
    Clear-Host

    # Update previous state
    $prevState = $currentState
}
