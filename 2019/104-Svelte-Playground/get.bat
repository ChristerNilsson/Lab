@echo off
rem .\get 001

move arkiv\%1\src\*.* src > nul
move arkiv\%1\public\*.* public > nul

ren arkiv arkiv%1 > nul

call npm run dev