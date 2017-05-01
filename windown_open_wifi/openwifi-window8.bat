echo off
cls
:begin
echo "************************************************"
echo "   ____ _         _____                         "
echo "  / ___(_) ____  |_   _|   _ _   _  ___ ____    "
echo " | |  _| |/ _  |   | || | | | | | |/ _ \  _ \   "
echo " | |_| | | (_| |   | || |_| | |_| |  __/ | | |  "
echo "  \____|_|\____|   |_| \____|\___ |\___|_| |_|  "
echo "                             |___/              "
echo "  _____ _              ____  _       _          "
echo " |_   _(_) ___ _ __   / ___|(_)_ __ | |__       "
echo "   | | | |/ _ \ |_ \  \___ \| | |_ \| |_ \      "
echo "   | | | |  __/ | | |  ___) | | | | | | | |     "
echo "   |_| |_|\___|_| |_| |____/|_|_| |_|_| |_|     "
echo "                                                "
echo "************************************************"

echo. Phat wifi:
echo. 1. Bat phat Wifi
echo. 2. Tat phat Wifi
echo. 3. Xem trang thai ket noi
echo. 4. Tao diem phat Wifi
echo. 5. Xoa diem phat Wifi vua tao
echo. 6. Thoat
echo. 7. Clean
echo. ...........................................
echo.
:chon
choice /c:1234567 /n /m "Chon chuc nang: "
echo.

If errorlevel==7 goto clean
If errorlevel==6 goto thoat
If errorlevel==5 goto xoa
If errorlevel==4 goto tao
If errorlevel==3 goto xem
If errorlevel==2 goto tat
If errorlevel==1 goto bat

:thoat
exit
:xoa
netsh wlan set hostednetwork mode=disallow ssid=tuyen-ng key=nguyengiatuyen
echo Da xoa diem phat Wifi ten: "tuyen-ng", mat khau: "nguyengiatuyen"!
echo.
goto chon
:tao
netsh wlan set hostednetwork mode=allow ssid=tuyen-ng key=nguyengiatuyen
echo Da tao diem phat Wifi ten: "tuyen-ng", mat khau: "nguyengiatuyen"!
echo.
goto chon
:xem
echo Trang thai ket noi:
netsh wlan show hostednetwork
echo.
goto chon
:tat
netsh wlan stop hostednetwork
echo Da tat Wifi!
echo.
goto chon
:bat
netsh wlan start hostednetwork
echo Da bat Wifi!
echo.
goto chon

:clean
cls
goto begin
