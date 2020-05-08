echo on
echo 重置网络
echo 以管理员身份运行
echo 完成后重启计算机

ipconfig /flushdns
nbtstat –r
netsh int ip reset
netsh winsock reset
