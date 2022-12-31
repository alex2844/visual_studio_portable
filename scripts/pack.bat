@echo off

cd "%~dp0"
if not exist "%PROGRAMFILES%\Microsoft Visual Studio" (
	echo not found vs
	exit /b 1
)
if not exist "%PROGRAMFILES(x86)%\Windows Kits" (
	echo not found windows kits
	exit /b 1
)
if exist "%PROGRAMFILES%\7-Zip\7z.exe" (
	"%PROGRAMFILES%\7-Zip\7z.exe" a ..\vs.zip -tzip -mx=0 ^
		"%PROGRAMFILES%\Microsoft Visual Studio" ^
		"%PROGRAMFILES(x86)%\Windows Kits" ^
		"..\scripts\"
	exit /b 0
)
powershell Compress-Archive ^
	-CompressionLevel NoCompression ^
	-Path '..\scripts\', ${env:ProgramFiles}'\Microsoft Visual Studio', ${env:ProgramFiles(x86)}'\Windows Kits' ^
	-DestinationPath ..\vs.zip
