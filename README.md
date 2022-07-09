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
