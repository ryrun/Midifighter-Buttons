@echo off
del /F /Q out/toimp.ryrun.MidifighterButtons.xrnx
"C:\Program Files\7-Zip\7z" a -tzip out/toimp.ryrun.MidifighterButtons.xrnx main.lua manifest.xml 
