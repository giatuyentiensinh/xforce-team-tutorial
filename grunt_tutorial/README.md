# Grunt tutorial

## Giới thiệu
`grunt` là công cụ được xây dựa trên `nodejs` để quản lý các file script của project, giúp cho việc đóng gói angular, test controller, ...

## Cài đặt

```shell

# cài đặt nodejs
$ sudo apt-get install nodejs

# cài đặt công cụ quản lý các package trong nodejs
$ sudo apt-get install npm

# cài đặt grunt
$ sudo npm install -g grunt-cli
```

## Sử dụng
* Init. Trong một project client sử dụng `grunt`, ban đầu tạo ra thì cần có các file sau: 

1. package.json (chứa thông tin cấu hình của toàn project)
2. bower.json (quản lý các thư viện **nói trong phần Bower tutorial**)
3. index.html
4. Gruntfile.js (chứa thông tin cấu hình của `grunt`)

* Setup
```shell

# tạo file index.html (cái này có thể tạo file bằng các tool hoặc có thể sử dụng lệnh trên termial như sau)
$ touch index.html

# tương tự tạo file Gruntfile.js
$ touch Gruntfile.js

# tạo file package.json (ghi các thông tin mô tả về project theo hướng dẫn)
$ npm init

# tạo file bower.json (ghi các thông tin mô tả về project theo hướng dẫn)
$ bower init
```

* Ví dụ sử dụng grunt để nén các file js, css

```shell
# cài đặt gói grunt (option --save-dev để nói cho hệ thống biết rằng các package cài đặt sẽ được ghi vào file package.json, sau khi cài đặt các gói sẽ lưu vào thư mục node_modules)
$ npm install grunt --save-dev

# cài đặt gói nén file js
$ npm install grunt-contrib-uglify --save-dev

# cài đặt gói nén file css
$ npm install grunt-contrib-cssmin --save-dev
```

Trong file Gruntfile.js

```js

module.exports = function (grunt) {

	// Phần 1 
	// load các gói grunt cần dùng
	grunt.loadNpmTasks('grunt-contrib-uglify');
	grunt.loadNpmTasks('grunt-contrib-cssmin');

	// Phần 2
    // câu hình cài đặt
	grunt.initConfig({ 

		// đọc thông tin cấu hình trong package.json
	    pkg: grunt.file.readJSON('package.json'),

	    // nén javacript
	    uglify: {
			options: {
				banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
			},
			build: {
				// tạo thư mục `js` (không tạo thì báo lỗi) và để các file .js vào trong đó
				src: 'js/*.js',
				// tạo thư mục `distjs` (không tạo thì báo lỗi) và sau khi build thì các file .js đã nén sẽ để vào trong thư mục này
				dest: 'distjs/*.min.js'
			}
		},

		// nén css
		cssmin: {
			options: {
				banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
			},
			build: {
				// tạo thư mục `css` (không tạo thì báo lỗi) và để các file .css vào trong đó
				src: 'css/*.css',
				// tạo thư mục `distcss` (không tạo thì báo lỗi) và sau khi build thì các file .css đã nén sẽ để vào trong thư mục này
				dest: 'distcss/*.min.css'
			}
		}
	});

	// Phần 3
	// Đăng ký các chức năng cấu hình ở trên trong trường hợp mặc định khi chạy mỗi lệnh `$ grunt`
	grunt.registerTask('default', ['uglify', 'cssmin']);
	// Có thể đăng ký chức năng khác với tên khác, ví dụ: `$ grunt nenjs`
	grunt.registerTask('nenjs', 'uglify');
 
};
```

Execute, trước khi chạy hãy tạo các folder và các file theo cấu trúc như sau

![grunt create init](/images/grunt create init.PNG)

Các file .css và .js chứa một số nội dung


```shell

# sử dụng grunt (vào folder distjs và distcss để xem kết quả)
$ grunt

# trong trường hợp chỉ dùng 1 chức năng đã được chỉ định trong phần grunt config (trường hợp này thì ko cần phải có phần 3 trong Gruntfile.js)
$ grunt uglify
$ grunt cssmin
```

# Bounus: Sử dụng grunt để tự động import các thư viện mà bower kéo về [REF](https://github.com/stephenplusplus/grunt-wiredep)

tool [wiredep](https://github.com/taptapship/wiredep)

* cài đặt wiredep

```shell
$ npm install --save-dev wiredep
$ npm install --save-dev grunt-wiredep
```

* cấu hình trong Gruntfile.js

```javascript
module.exports = function (grunt) {

	grunt.loadNpmTasks('grunt-wiredep');

	grunt.initConfig({ 
		wiredep: {
			task: {
				src: [
					'app/views/**/*.html',   // .html support...
					'app/views/**/*.jade',   // .jade support...
					'app/styles/main.scss',  // .scss & .sass support...
					'app/config.yml'         // and .yml & .yaml support out of the box!
				],
				options: {
					// See wiredep's configuration documentation for the options
					// you may pass:

					// https://github.com/taptapship/wiredep#configuration
				}
			}
		}
	});
}
```

* cấu hình file cần import

  Thêm dòng sau vào file cần import
```shell
<!-- bower:css -->
<!-- endbower -->
<!-- bower:js -->
<!-- endbower -->
```

* Test

```shell
$ bower install --save jquery
$ grunt wiredep

# kiểm tra trong file index.html
```

# Auth: Tuyen-ng