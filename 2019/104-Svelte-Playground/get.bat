@echo off
rem .\get 001

node xmove arkiv\%1\src src
node xmove arkiv\%1\public public

ren arkiv arkiv%1

rem call npm run dev