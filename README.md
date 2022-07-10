# Auto-ProcmonData
---------------------------------

The Auto-ProcmonData will run Sysinternal utility Process Monitor 'Procmon' on a remote system, 
and will prompt the user to provide the remote machine name and also the duration of colletion of data in seconds.
The script will copy Procmon in the remote system and run it stealthy using PsExec,
once complete it will generate a log file and copied into your local machine for analysis.

What is Process Monitor?

"Process Monitor is an advanced monitoring tool for Windows that shows real-time file system, Registry and process/thread activity. It combines the features of two legacy Sysinternals utilities, Filemon and Regmon, and adds an extensive list of enhancements including rich and non-destructive filtering, comprehensive event properties such as session IDs and user names, reliable process information, full thread stacks with integrated symbol support for each operation, simultaneous logging to a file, and much more. Its uniquely powerful features will make Process Monitor a core utility in your system troubleshooting and malware hunting toolkit." official definition (Markruss, 2021).

Reference:
Markruss. (2021, September 22). Process monitor - Windows Sysinternals. Developer tools, technical documentation and coding examples | Microsoft Docs. https://docs.microsoft.com/en-us/sysinternals/downloads/procmon

---------------------------------
# Details

You will need the sysinternal utility Procmon.exe and PsExec.exe on your local machine.
Make sure Procmon.exe and PsExec.exe are in the same location you specified on the parameter $ProcmonPath & $PsExecPath "C:\".
Your log file generated by the script will be at the same location specified on the parameter $SaveDataPath "C:\".
 
 The section below is the only one you will need to modify on the script before execution.
 
         [Parameter()][string]$ProcmonPath = 'C:\', #Path To Procmon.exe on local machine
         [Parameter()][string]$PsExecPath = 'C:\', #Path to PsExec.exe on local machine
         [Parameter()][string]$SaveDataPath = 'C:\' #Path to save generated file

    $TempFolder = 'File Path here' #Path for the Temp folder
-----------------------------------
# Usage & Proof of Concept
