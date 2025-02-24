@ECHO OFF &SETLOCAL ENABLEDELAYEDEXPANSION

del ..\output\*.* /Q /S /F

CALL check_prerequisites.cmd

IF NOT "%errorlevel%"=="0" (
	EXIT /B %errorlevel%
)

nandeck ..\src\nde\cards\projects.nde /createpdf /output=..\..\..\output\projects.pdf /[backs]=_TRUE_ /[duplexbacks]=_TRUE_
nandeck ..\src\nde\cards\modules.nde /createpdf /output=..\..\..\output\modules.pdf /[backs]=_TRUE_ /[duplexbacks]=_TRUE_
pdfmerge -o planetb_pnp.pdf ..\output\projects.pdf ..\output\modules.pdf

del ..\output\*.* /Q /S /F

move planetb_pnp.pdf ..\output\
