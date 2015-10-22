# Bower tutorial

## Giới thiệu
[bower](http://bower.io/) là công cụ quản lý thư viện phía **front end** do [Twitter](https://twitter.com) xây dựng. Sử dụng `bower` sẽ quản lý thư viện được tốt hơn. Ví dụ nếu có xung đột giữa các gói thư viện thì nó sẽ báo cho dev biết để xử lý, và khi dùng `bower` để tải các thư viện về thì bower tự động giải nén và đưa tất cả các gói tải vào một thư mục gọi là `bower_components` điều này làm cho project được phân tầng hơn và dễ quản lý hơn. Và khi download các thư viện bằng `bower` thì nó sẽ download tất cả những gì liên quan đến việc phát triển gói thư viện đó như là mã nguồn của thư viện, bản nén, ..., và file hướng dẫn sử dụng (README)

## Cài đặt

```command

$ sudo npm install -g bower
```

## Sử dụng
* Init. Tạo các file sau trong project phía **front end**

1. package.json (chứa thông tin cấu hình của toàn project)
2. bower.json (quản lý các thư viện)
3. index.html

* Setup
```command

# tạo file index.html
$ touch index.html

# tạo file package.json
$ npm init

# tạo file bower.json (ghi các thông tin mô tả về project theo hướng dẫn)
$ bower init
```

* Sử dụng

Sau khi cài đặt các gói thì các gói tải về sẽ nằm trong thư mục `bower_components`

```command

# tải angularJs về (option --save để ghi lại các gói đã cài đặt vào trong file bower.json) mặc định nó sẽ chọn version mới nhất
$ bower install angular --save

# tải gói với version cụ thể (sử dụng ký tự `#` đằng sau tên gói)
$ bower install jquery#1.9

# gỡ materialize
$ bower uninstall materialize --save

# sử dụng bower để tìm kiếm 
$ bower search bootstrap-angular
```

# Auth: Tuyen-ng