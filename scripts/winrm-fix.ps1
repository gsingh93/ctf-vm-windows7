Set-Item WSMan:\localhost\Shell\MaxShellsPerUser -Value 30
Set-Item WSMan:\localhost\Shell\MaxProcessesPerShell -Value 30
Set-Item WSMan:\localhost\Service\MaxConcurrentOperationsPerUser -Value 1500
Set-Item WSMan:\localhost\Shell\MaxMemoryPerShellMB -Value 2048
