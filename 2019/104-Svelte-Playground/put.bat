@echo off
rem .\put 001

move src\*.* arkiv%1\src%1 > nul
move public\*.* arkiv%1\public%1 > nul

ren arkiv%1 arkiv > nul
