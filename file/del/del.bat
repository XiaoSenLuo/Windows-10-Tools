@echo off
echo 顺序就是先使用 Takeown 修改文件所有者
echo 再使用 cacls  修改访问控制权限
echo 然后再 rd 就不会遇到什么拒绝访问这个东西了
set path=G:\WindowsApps
Takeown /F %path% /r /d y
cacls %path% /t /e /g Administrators:F
echo rd /s /q %path%
pause