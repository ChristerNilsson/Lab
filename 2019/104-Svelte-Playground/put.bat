@echo off
rem .\put 001

rem call npm run build

move src arkiv%1\%1\src
move public arkiv%1\%1\public

ren arkiv%1 arkiv
