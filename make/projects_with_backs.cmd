@ECHO OFF &SETLOCAL ENABLEDELAYEDEXPANSION

CALL check_prerequisites.cmd

IF NOT "%errorlevel%"=="0" (
	EXIT /B %errorlevel%
)

nandeck ..\src\nde\cards\projects.nde /createpdf /output=..\..\..\output\projects.pdf /[backs]=_TRUE_ /[duplexbacks]=_TRUE_
