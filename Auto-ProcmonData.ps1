<# Script: Auto-ProcmonData
   Created : 06/13/2022
   
   The Auto-ProcmonData will run Sysinternal utility Process Monitor 'Procmon' on a remote system, 
   and will prompt the user to provide the remote machine name and also the duration of colletion of data in seconds.
   The script will copy Procmon in the remote system and run it stealthy using PsExec,
   once complete it will generate a log file and copied into your local machine for analysis.
   
   Note: You will need the sysinternal utility Procmon.exe and PsExec.exe on your local machine.
         Make sure Procmon.exe and PsExec.exe are in the same location you specified on the parameter $ProcmonPath & $PsExecPath "C:\".
         Your log file generated by the script will be at the same location specified on the parameter $SaveDataPath "C:\" #>

    Param(
         [Parameter(Mandatory)][string]$ComputerName, #Remote machine
         [Parameter(Mandatory)][ValidateRange(10,60)][int]$Duration, #Time of collect in Seconds
         [Parameter()][string]$ProcmonPath = 'C:\', #Path To Procmon.exe on local machine
         [Parameter()][string]$PsExecPath = 'C:\PsExec.exe', #Path to PsExec.exe
         [Parameter()][string]$SaveDataPath = 'C:\' #Path to save generated file
         )

    $remote = 'C$'
    $local = 'C:'
    $TempFolder = 'File Path here' #Path for the Temp folder

    if (!(Test-Connection $ComputerName)) { Write-Warning "$ComputerName is unreachable. Aborting..." }
    else{
        if (!(Test-Path $PsExecPath)) { Write-Warning "$PsExec not found, please verify path or use -PsExecPath." }
        else{
            if (!(Test-Path $ProcmonPath)) {Write-Warning "$ProcMon not found, please verify path or use -ProcmonPath." }
            else{
                if (!(Get-WmiObject Win32_Volume | Where-Object {$_.Capacity/1mb -gt 500  })) { Write-Warning "Not Enough Free Space on local machine."}
                   
                else {
                    Write-Host "Copying Procmon on $ComputerName..."
                    try { Copy-Item $ProcmonPath "\\$ComputerName\$remote\$TempFolder" -Force -Verbose -ErrorAction Stop } catch { Write-Warning $_.Exception; break }

                    Write-Host "Running Procmon on $ComputerName..."
                    Start-Process -FilePath $PsExecPath -ArgumentList "-accepteula -s -d \\$ComputerName $local\$TempFolder\Procmon.exe /accepteula /BackingFile $local\$TempFolder\$ComputerName.pml /Quiet"
                    Write-Host "Collecting Data... Please wait $duration seconds."
                    Start-Sleep -s $Duration
                 
                    Write-Host "Terminating Process..."
                    $Terminate = & $PsExecPath -accepteula -s \\$ComputerName $local\$TempFolder\Procmon.exe /accepteula /Terminate 2>&1;

                    Write-Host "Copying data to local machine..."
                    if (!(Test-Path -path $SaveDataPath)) { New-Item $SaveDataPath -Type Directory }
                    try { Copy-Item "\\$ComputerName\$remote\$TempFolder\$ComputerName.pml" $SaveDataPath -Force -Verbose -ErrorAction Stop } catch { Write-Warning $_.Exception }

                    Write-Host "Cleaning up..."
                    Remove-Item "\\$ComputerName\$remote\$TempFolder\$ComputerName.pml" -Verbose -Force
                    Remove-Item "\\$ComputerName\$remote\$TempFolder\Procmon.exe" -Verbose -Force
                }
            }
        }

        if(get-process -ComputerName $ComputerName -Name "*procmon*"){
        Write-Warning "Procmon is still running..."
    }

    }
