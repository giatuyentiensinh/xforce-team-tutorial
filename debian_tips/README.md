# Debian tips

## Gập màn hình nhưng laptop vẫn hoạt động

Sửa file `/etc/systemd/logind.conf` và xóa comment của `HandleLidSwitch` và sửa thành `ignore` thay vì `suspend`.
Sau đó gõ lệnh `# service systemd-logind restart` để apply

## Thêm certificate trong Linux

Copy file `.crt` vào thư mục `/usr/local/share/ca-certificates` và sau đó gõ lệnh `$ sudo update-ca-certificates`

## Thay đổi ảnh background boot `grub2`

Copy ảnh background vào trong folder `/boot/grub` sau đõ gõ lệnh `$ sudo update-grub2` để apply. [Background hiện tại đang dùng](./media/debian-default.png)

## Thay đổi theme loading plymouth với `debian 9 (stretch)`

- Copy folder theme vào trong folder `/usr/share/plymouth/themes`
- Sau đó gõ lệnh `$ plymouth-set-default-theme <theme_name>` để chọn theme (dùng lệnh `$ plymouth-set-default-theme -l` để xem danh sách các theme available)
- Cuối cùng gõ lệnh `$ update-initramfs -u` để apply

[Theme hiện tại đang dùng](./media/softwaves/)
