@echo off
rem .\get 001

move arkiv\src%1\*.* src > nul
move arkiv\public%1\*.* public > nul

ren arkiv arkiv%1 > nul

npm run dev