@ECHO OFF &SETLOCAL ENABLEDELAYEDEXPANSION

REM CHECK THE WINDOWS VERSION if not supported, undefined behavior may arise.

for /F "tokens=1-3" %%J in ('wmic os get Caption /value') do (
	if "%%L"=="10" (
		set VALIDWINDOWSVERSION=1
	)
)

if defined VALIDWINDOWSVERSION (
	set RUNNORMALLY=1
) else (
	echo This Windows version is not supported, proceed with caution.
	echo:
	set /p yesorno= "Would you like to run the build script from this machine, even though undefined behavior may arise (Y/N)? "

	if "!yesorno!"=="Y" (
		set RUNANYWAYS=1
	)
)

if not defined RUNNORMALLY (
	if not defined RUNANYWAYS (
		echo exiting with error level 1
		EXIT /B 1
	)
)

REM CHECK THE PATH

for %%X in (nandeck.exe) do (
	set NANDECKONPATH=%%~$PATH:X
)

if not defined NANDECKONPATH (
	echo nandeck must be on the path to run this build script
	echo Exiting with error level 2
	EXIT /B 2
)

for %%X in (python.exe) do (
	set PYTHONONPATH=%%~$PATH:X
)

if not defined PYTHONONPATH (
	echo python must be on the path to run this build script
	echo Exiting with error level 3
	EXIT /B 3
)

for /F "tokens=*" %%X in ('where pdfmerge') do (
	set Y=%%X
	if "!Y:INFO=!"=="!Y!" set PDFMERGEONPATH=1
)

if not defined PDFMERGEONPATH (
	echo the python application pdfmerge must be installed to run this build script
	echo install it by running 'python -m pip install pdfmerge'
	echo Exiting with error level 4
	EXIT /B 4
)
