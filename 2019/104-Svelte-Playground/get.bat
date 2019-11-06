@echo off
rem .\get 001

move arkiv\%1\src src
move arkiv\%1\public public

ren arkiv arkiv%1

rem call npm run dev