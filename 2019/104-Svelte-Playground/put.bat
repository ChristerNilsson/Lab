@echo off
rem .\put 001

call npm run build

move src\*.* arkiv%1\%1\src
move public\*.* arkiv%1\%1\public

ren arkiv%1 arkiv

