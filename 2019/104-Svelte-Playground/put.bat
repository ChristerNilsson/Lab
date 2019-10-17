@echo off
rem .\put 001

call npm run build

move src\*.* arkiv%1\src%1
move public\*.* arkiv%1\public%1

ren arkiv%1 arkiv

