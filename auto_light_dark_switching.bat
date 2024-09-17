@echo off
setlocal

rem Define registry key and value
set "regKey=HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
set "regValue=AppsUseLightTheme"

rem Query the registry
for /f "tokens=2*" %%A in ('reg query "%regKey%" /v "%regValue%" 2^>nul') do (
    set "darkMode=%%B"
)

rem Interpret the result
if "%darkMode%"=="0x0" (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d 1 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d 1 /f
    
) else (
    echo Light mode is enabled.
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d 0 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d 0 /f

rem powershell "New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0 -Type Dword -Force; New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0 -Type Dword -Force"

)

endlocal 