cls

@ECHO OFF

Folder Private

if EXIST "HTG Locker" goto UNLOCK

if NOT EXIST Private goto MDLOCKER

:CONFIRM

echo Are you sure you want to hide this private folder?(Y/N)

set/p "cho=>"

if %cho%==Y goto LOCK

if %cho%==y goto LOCK

if %cho%==n goto END

if %cho%==N goto END

echo Invalid choice.

goto CONFIRM

:LOCK

ren Private "HTG Locker"

attrib +h +s "HTG Locker"

echo Folder locked

goto End

:UNLOCK

echo Enter the password to display the private folder

set/p "pass=>"

if NOT %pass%== xsl goto FAIL

attrib -h -s "HTG Locker"

ren "HTG Locker" Private

echo Folder Unlocked successfully

goto End

:FAIL

echo Invalid password

goto end

:MDLOCKER

md Private

echo Private created successfully

goto End

:End