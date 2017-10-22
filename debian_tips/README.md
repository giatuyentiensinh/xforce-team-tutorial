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

## Lệnh chỉnh touchpad `synclient`

```shell
# Xem danh sách các tham số
$ synclient
# Chỉnh scroll 2 ngón nằm ngang
$ synclient HorizTwoFingerScroll=1
```

## Các alias trong file `.bashrc`

```
if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1="\[\e[01;33m\]\u\[\e[0m\]\[\e[00;37m\]@\[\e[0m\]\[\e[01;36m\]\h\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\e[01;35m\]\w\[\e[0m\]\[\e[01;37m\]\$(__git_ps1) >>> \[\e[0m\]"
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

export PYTHONSTARTUP=~/.pythonrc

alias rmd='rm -rf'
alias md='mkdir -p'
alias siz='du -hs'
alias cd..="cd .."

alias rleft='xrandr --output eDP-1 --rotate left'
alias rright='xrandr --output eDP-1 --rotate right'
alias rtop='xrandr --output eDP-1 --rotate normal'
alias fio='firefox --private-window'
alias jsv='python -m json.tool'
alias tuyen_scan='nmap -sP 192.168.1.1/24 | arp | grep -v incomplete | sort | uniq -c'
alias ipdocker='docker inspect -f "{{.Name}} - {{.NetworkSettings.IPAddress }}" $(docker ps -aq)'
alias listnode='npm list -g --depth=0'

alias piqemu='qemu-system-arm -kernel kernel-qemu-3.10.25-wheezy -cpu arm1176 -m 256 -M versatilepb -serial stdio -append "root=/dev/sda2 roofstype=ext4 rw" -hda 2015-02-16-raspbian-wheezy.img -redir tcp:2222::22'

alias ecgenkey='openssl ecparam -genkey -name secp256r1 -noout -out '
alias ecshowkey='openssl ec -text -noout -in '

addkeytls() {
    keytool -import -alias $1 -keystore /opt/jdk1.8.0_101/jre/lib/security/cacerts -storepass changeit -file $2
}

rmkeytls() {
    keytool -delete -alias $1 -keystore /opt/jdk1.8.0_101/jre/lib/security/cacerts -storepass changeit
}

playtemplate() {
  PLAYSTR='Playgenerated project:'
  PLAYBOLD='\033[1m'
  # PLAYCOLOR='\033[31m' #RED
  # PLAYCOLOR='\033[32m' #GREEN
  # PLAYCOLOR='\033[33m' #YELLOW
  # PLAYCOLOR='\033[34m' #BLUE
  # PLAYCOLOR='\033[35m' #PURPLE
  PLAYCOLOR='\033[36m' #CYAN
  # PLAYCOLOR='\033[37m' #WHITE
  PLAYNOCOLOR='\033[0m' # No Color
  case $1 in
    chatroom )
      cp -r /home/tuyenng/.playframework-store/play-java-chatroom-example $2
      echo -e "${PLAYBOLD}${PLAYCOLOR}${PLAYSTR} " $2 "done. ${PLAYNOCOLOR}"
      ;;
    compile-di )
      cp -r /home/tuyenng/.playframework-store/play-java-compile-di-example $2
      echo -e "${PLAYBOLD}${PLAYCOLOR}${PLAYSTR} " $2 "done. ${PLAYNOCOLOR}"
      ;;
    ebean )
      cp -r /home/tuyenng/.playframework-store/play-java-ebean-example $2
      echo -e "${PLAYBOLD}${PLAYCOLOR}${PLAYSTR} " $2 "done. ${PLAYNOCOLOR}"
      ;;
    fileupload )
      cp -r /home/tuyenng/.playframework-store/play-java-fileupload-example $2
      echo -e "${PLAYBOLD}${PLAYCOLOR}${PLAYSTR} " $2 "done. ${PLAYNOCOLOR}"
      ;;
    jpa )
      cp -r /home/tuyenng/.playframework-store/play-java-jpa-example $2
      echo -e "${PLAYBOLD}${PLAYCOLOR}${PLAYSTR} " $2 "done. ${PLAYNOCOLOR}"
      ;;
    rest )
      cp -r /home/tuyenng/.playframework-store/play-java-rest-api-example $2
      echo -e "${PLAYBOLD}${PLAYCOLOR}${PLAYSTR} " $2 "done. ${PLAYNOCOLOR}"
      ;;
    streaming )
      cp -r /home/tuyenng/.playframework-store/play-java-streaming-example $2
      echo -e "${PLAYBOLD}${PLAYCOLOR}${PLAYSTR} " $2 "done. ${PLAYNOCOLOR}"
      ;;
    websocket )
      cp -r /home/tuyenng/.playframework-store/play-java-websocket-example $2
      echo -e "${PLAYBOLD}${PLAYCOLOR}${PLAYSTR} " $2 "done. ${PLAYNOCOLOR}"
      ;;
    seed )
     cp -r /home/tuyenng/.playframework-store/play-java-seed $2
     echo -e "${PLAYBOLD}${PLAYCOLOR}${PLAYSTR} " $2 "done. ${PLAYNOCOLOR}"
      ;;
    angular2 )
     cp -r /home/tuyenng/.playframework-store/play-angular2 $2
     echo -e "${PLAYBOLD}${PLAYCOLOR}${PLAYSTR} " $2 "done. ${PLAYNOCOLOR}"
      ;;
    *)
      echo -e "${PLAYCOLOR} Usage: ${PLAYNOCOLOR}"
      echo -e "${PLAYBOLD}${PLAYCOLOR}$ playtemplate chatroom {name} ${PLAYNOCOLOR}"
      echo -e "${PLAYBOLD}${PLAYCOLOR}$ playtemplate compile-di {name} ${PLAYNOCOLOR}"
      echo -e "${PLAYBOLD}${PLAYCOLOR}$ playtemplate ebean {name} ${PLAYNOCOLOR}"
      echo -e "${PLAYBOLD}${PLAYCOLOR}$ playtemplate fileupload {name} ${PLAYNOCOLOR}"
      echo -e "${PLAYBOLD}${PLAYCOLOR}$ playtemplate jpa {name} ${PLAYNOCOLOR}"
      echo -e "${PLAYBOLD}${PLAYCOLOR}$ playtemplate rest {name} ${PLAYNOCOLOR}"
      echo -e "${PLAYBOLD}${PLAYCOLOR}$ playtemplate streaming {name} ${PLAYNOCOLOR}"
      echo -e "${PLAYBOLD}${PLAYCOLOR}$ playtemplate websocket {name} ${PLAYNOCOLOR}"
      echo -e "${PLAYBOLD}${PLAYCOLOR}$ playtemplate seed {name} ${PLAYNOCOLOR}"
      echo -e "${PLAYBOLD}${PLAYCOLOR}$ playtemplate angular2 {name} ${PLAYNOCOLOR}"
      ;;
  esac
}

export PATH=$PATH:/sbin:/usr/sbin
export PATH=$PATH:/opt/msp430/bin:/opt/msp430/include:/opt/msp430/lib:/opt/msp430/msp430:/opt/msp430/share

```

## Auto completion shell python

Tạo file `.pythonrc` ở home folder với nội dung như sau

```python
# ~/.pythonrc
# enable syntax completion
try:
    import readline
except ImportError:
    print("Module readline not available.")
else:
    import rlcompleter
    readline.parse_and_bind("tab: complete")
```

## Các bash_completion 

Copy các file [bash completion](./bash_completion) vào folder `/etc/bash_completion.d`

## Biến môi trường

Có thể set biến môi trường trong file `.bashrc` hoặc tạo 1 file trong folder `/etc/profile.d` sau đó reboot lại máy để apply.

[Biến môi trường hiện tại](./env/tuyen_profile.sh)
