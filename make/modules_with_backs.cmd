@ECHO OFF &SETLOCAL ENABLEDELAYEDEXPANSION

CALL check_prerequisites.cmd

IF NOT "%errorlevel%"=="0" (
	EXIT /B %errorlevel%
)

nandeck ..\src\nde\cards\modules.nde /createpdf /output=..\..\..\output\modules.pdf /[backs]=_TRUE_ /[duplexbacks]=_TRUE_
