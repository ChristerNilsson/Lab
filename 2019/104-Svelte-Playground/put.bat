@echo off
rem .\put 001

rem call npm run build

node xmove src arkiv%1\%1\src
node xmove public arkiv%1\%1\public

ren arkiv%1 arkiv
