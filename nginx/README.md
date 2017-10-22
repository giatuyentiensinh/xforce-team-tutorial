# Cấu hình Proxy [Nginx](https://kipalog.com/posts/Cau-hinh-nginx-co-ban---Phan-1)

## Giới thiệu

NGINX is a free, open-source, high-performance HTTP server and reverse proxy, as well as an IMAP/POP3 proxy server. NGINX is known for its high performance, stability, rich feature set, simple configuration, and low resource consumption.
NGINX is one of a handful of servers written to address the C10K problem. Unlike traditional servers, NGINX doesn’t rely on threads to handle requests. Instead it uses a much more scalable event-driven (asynchronous) architecture. This architecture uses small, but more importantly, predictable amounts of memory under load. Even if you don’t expect to handle thousands of simultaneous requests, you can still benefit from NGINX’s high-performance and small memory footprint. NGINX scales in all directions: from the smallest VPS all the way up to large clusters of servers.

## Cài đặt

```shell
$ sudo apt-get install nginx
```

## Nginx script

Thư mục mặc định khi cài đặt nginx `/etc/nginx` trong đó có folder `sites-available` là folder chứa các mã script cấu hình cho các server.

Mặc định trong folder `sites-available` có file `default` có nội dung như sau

```
# cấu hình host
server {
	# cổng sẽ lắng nghe và default_server có nghĩa server này được chọn mặc định trong trường hợp có nhiều server khác cũng dùng cổng 80
	listen 80 default_server;
	listen [::]:80 default_server;
	# đường dẫn chỉ đến thư mục của server (nếu cấu hình forward thì không cần phải định nghĩa root và index)
	root /var/www/html;

	# định nghĩa file index.html
	index index.html index.htm index.nginx-debian.html;

	# định nghĩa tên của server (thường là domain), _ nghĩa là all.
	server_name _;

	# cấu hình đường dẫn. vd với đường dẫn là `/` mà không có thì sẽ trả response 404.
	location / {
		try_files $uri $uri/ =404;
	}

}
```

Trong folder [sites-available](./sites-available) có các file script mẫu và có thể download về và đặt trong thư mục `/etc/nginx/sites-enabled` sau đó restart nginx bằng lệnh `$ sudo service nginx restart`

Chú ý

- Với mỗi đoạn script có `server_name` khác nhau và mỗi server đó cần phải được khai báo trong file `/etc/hosts`
- File script `giatuyen.menu.conf` có biến `root` cần phải chỉ đến folder [menu-server-nginx](./menu-server-nginx)
- Với những script cấu hình https như `giatuyen.es.conf` và `giatuyen.menus.conf` thì cần phải sinh certificate, key và khai báo trong biến `ssl_certificate` và `ssl_certificate_key` để sinh certificate và key thì làm theo các lệnh sau

  ```shell
  # Tạo private key
  $ openssl genrsa -des3 -out server.key 1024
  # Tạo certificate signing request
  $ openssl req -new -key server.key -out server.csr
  # Tạo certificate từ certificate signing request và tự ký dùng private key
  $ openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt

  # Tuy sử dụng passphrase sẽ an toàn hơn nhưng lại kém tiện dụng nên ta có thể loại bỏ passphrase đi bằng cách:
  # backup private key:
  $ cp server.key server.key.org
  # Loại bỏ passphrase khỏi private key:
  $ openssl rsa -in server.key.org -out server.key
  ```

- Với những file `giatuyen.mongodb.conf`, `giatuyen.neo4j.conf` có kiểm soát truy cập sử dụng basic authentication do khai báo biến `auth_basic` và `auth_basic_user_file` trong đó biến `auth_basic_user_file` chỉ đến đường dẫn account của user được tạo ra bằng lệnh `htpasswd` (`# apt-get install apache2-utils`), để tạo 1 user sử dụng lệnh `$ htpasswd -c <file> <username>`, để add 1 user sử dụng lệnh `$ htpasswd <file> <username>`, để xóa 1 user sử dụng lệnh `$ htpasswd -D <file> <username>`
