@echo off
echo ˳�������ʹ�� Takeown �޸��ļ�������
echo ��ʹ�� cacls  �޸ķ��ʿ���Ȩ��
echo Ȼ���� rd �Ͳ�������ʲô�ܾ��������������
set path=G:\WindowsApps
Takeown /F %path% /r /d y
cacls %path% /t /e /g Administrators:F
echo rd /s /q %path%
pause