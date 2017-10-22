# GIT

## git config file

Git config được lưu trong file `.gitconfig` ở thư mục home folder.

Có thể thêm các alias hay các option sau vào file `.gitconfig` để làm việc được hiệu quả hơn.

```
[alias]
	co = checkout
	cob = checkout -b	# Checkout a new not yet existing branch
	ba  = branch -a		# List both remote-tracking branches and local branches.
	bd = branch -d		# Delete a branch only if it has been merged
	bD = branch -D		# Force delete a branch
	st = status
	sh = stash
	lg = log --graph --all --oneline --decorate
	ls = log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate
	ll = log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat
	lds = log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short
	r = reset
	r1 = reset HEAD^
	r2 = reset HEAD^^
	rh = reset --hard
	rh1 = reset HEAD^ --hard
	rh2 = reset HEAD^^ --hard
	rank = shortlog -sn --no-merges		# Contributors ordered by number of merges
[core]
	compression = 9
```

## Các lệnh git cơ bản

```shell

# Khởi tạo git
$ git init

# thêm tất cả các file trong repo
$ git add .

# ghi commend cho lần commit
$ git commit -m <msg>

# đưa repo lên server
$ git push <remote> <branch>
```

## Một số lệnh git nâng cao

```shell
# Sửa lại commend ở commit trước
$ git commit --amend

# Gộp các branch khác hoặc các branch ở remote khác vào branch hiện tại
$ git merge <branch_name> # Nếu conflict xảy ra thì sẽ được hiện ra thông báo ở console là bị conflict ở đâu hoặc auto merge

# Lưu các thay đổi vào stash (không gian thứ 3)
$ git stash save

# Các lệnh nâng cao về git rebase
```

## `.gitignore`

Là file định nghĩa các file or folder sẽ không được đẩy lên server cho dù đã commit và thường là những file thư mục có kích thước lớn và là kết quả của quá trình build souce code.

Template [gitignore](https://github.com/github/gitignore)
