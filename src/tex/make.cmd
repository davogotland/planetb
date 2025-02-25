@ECHO OFF
setlocal EnableDelayedExpansion

IF NOT EXIST %1.tex (
	ECHO Can't find the file "%1.tex". Aborting build.
	goto :error
)

SET scriptname=%1

latex %scriptname%.tex
if errorlevel 1 goto :error

IF EXIST %scriptname%.aux bibtex %scriptname%.aux
if errorlevel 1 SET errorlevel=0

IF EXIST %scriptname%.idx makeindex %scriptname%.idx
if errorlevel 1 goto :error

pdflatex %scriptname%.tex
if errorlevel 1 goto :error

REM multiple runs to ensure indexing and stuff works out

pdflatex %scriptname%.tex
if errorlevel 1 goto :error

pdflatex %scriptname%.tex
if errorlevel 1 goto :error

call :deletefiles
IF EXIST %scriptname%.log del %scriptname%.log

goto :eof  'Successful compilation

:error
echo Error during compilation! Leaving the log file.
call :deletefiles
IF EXIST %scriptname%.pdf del %scriptname%.pdf
exit /b 1

:deletefiles
IF EXIST %scriptname%.aux del %scriptname%.aux
IF EXIST %scriptname%.bbl del %scriptname%.bbl
IF EXIST %scriptname%.blg del %scriptname%.blg
IF EXIST %scriptname%.dvi del %scriptname%.dvi
IF EXIST %scriptname%.idx del %scriptname%.idx
IF EXIST %scriptname%.ind del %scriptname%.ind
IF EXIST %scriptname%.lof del %scriptname%.lof
IF EXIST %scriptname%.lot del %scriptname%.lot
IF EXIST %scriptname%.nav del %scriptname%.nav
IF EXIST %scriptname%.out del %scriptname%.out
IF EXIST %scriptname%.snm del %scriptname%.snm
IF EXIST %scriptname%.toc del %scriptname%.toc

goto :eof

:eof
