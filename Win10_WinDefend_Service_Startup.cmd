@echo off
sc config WinDefend start= auto
sc start WinDefend
exit