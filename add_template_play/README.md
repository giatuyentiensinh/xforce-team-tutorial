# Add angularJS của project `giasan` vào PlayFrameWord

## Sử dụng PlayFramework version `2.3.8` (do sử dụng [PlayAuthenticate](http://joscha.github.com/play-authenticate/) đầy đủ với 2.3.x)

```command
# tạo project
$ activator new `path/project_name` play-java
```

## Sửa một số file cấu hình sau khi tạo prject để đổi version Play `2.3.8`.

* build.sbt

```command

name := """project_name"""

version := "1.0-SNAPSHOT"

lazy val root = (project in file(".")).enablePlugins(PlayJava)

scalaVersion := "2.11.6"

libraryDependencies ++= Seq(
  javaJdbc,
  cache,
  javaWs
)
```

* project/plugins.sbt

```command

// The Play plugin
addSbtPlugin("com.typesafe.play" % "sbt-plugin" % "2.3.8")
```

* app/controllers/Application.java

```java

package controllers;

import play.*;
import play.mvc.*;

public class Application extends Controller {

    public static Result index() {
        return ok("Your new application is ready.");
    }

}

```

## Add Template angular `giasan` vào Play

### download template [giasan](https://drive.google.com/open?id=0B0uLgiGBCYCnUXhGWFlWRVlld1E) . Xóa thư mục `app/views`, các thư mục trong `public`, sau đó giải nén và copy thư mục `giasan/src/main/webapp` vào trong thưc mục `public` của Play. 

### trong file cấu hình `config/routes` sửa như sau

```command

# Trang chủ sẽ chỉ đến index.html trong project AngularJS
GET     /                           controllers.Assets.at(path="/public/webapp", file = "index.html")

# Cấu hình các file resource để trong file index.html có thể nhận được
GET     /api/*file               		controllers.Assets.versioned(path="/public/webapp/api", file: Asset)
GET     /assets/*file               	controllers.Assets.versioned(path="/public/webapp/assets", file: Asset)
GET     /bower_components/*file 		controllers.Assets.versioned(path="/public/webapp/bower_components", file: Asset)
GET     /css/*file               		controllers.Assets.versioned(path="/public/webapp/css", file: Asset)
GET     /fileMap/*file 					controllers.Assets.versioned(path="/public/webapp/fileMap", file: Asset)
GET     /fonts/*file               		controllers.Assets.versioned(path="/public/webapp/fonts", file: Asset)
GET     /fonts/sourcesanspro/*file 		controllers.Assets.versioned(path="/public/webapp/fonts/sourcesanspro", file: Asset)
GET     /i18n/*file               		controllers.Assets.versioned(path="/public/webapp/i18n", file: Asset)
GET     /img/*file               		controllers.Assets.versioned(path="/public/webapp/img", file: Asset)
GET     /js/*file               		controllers.Assets.versioned(path="/public/webapp/js", file: Asset)
GET     /l10n/*file               		controllers.Assets.versioned(path="/public/webapp/l10n", file: Asset)
GET     /scripts/*file               	controllers.Assets.versioned(path="/public/webapp/scripts", file: Asset)
GET     /swagger_ui/*file               controllers.Assets.versioned(path="/public/webapp/swagger_ui", file: Asset)
GET     /tpl/*file               		controllers.Assets.versioned(path="/public/webapp/tpl", file: Asset)
GET     /vendor/*file               	controllers.Assets.versioned(path="/public/webapp/vendor", file: Asset)

```

### Chạy project và mở trình duyệt [localhost:9000](http://localhost:9000)

![Image demo](/images/index.png)

# Auth: Tuyen-ng
