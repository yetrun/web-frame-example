# Web API 示例项目

## 快速试用

### 克隆项目

    $ git clone https://github.com/yetrun/web-frame-example.git

### 安装 Gems

    $ bundle install

### 准备数据库

    $ bundle exec rake db:setup

### 执行单元测试

    $ bundle exec rspec

### 启动服务器

    $ bundle exec rackup

启动服务器后通过以下路径访问资源：

- API: `http://localhost:9292`.
- OpenAPI 文档：`http://localhost:9292/api_spec`.

## 开发

开发环境支持常量自动重载，修改代码后无需重启服务器。

此外，开发环境支持 API 文档实时预览，以下是操作步骤：

1. 启动服务器：`$ bundle exec rackup`.
2. 浏览器中输入：[http://openapi.maikeji.cn/playground?url=ws%3A%2F%2Flocalhost%3A9292%2Fapi_spec](http://openapi.maikeji.cn/playground?url=ws%3A%2F%2Flocalhost%3A9292%2Fapi_spec).

即可启动 API 文档实时预览工作。

> Chrome 浏览器下默认会禁用 localhost 地址的连接，需要调整相关的设置以解除限制。在 Chrome 浏览器中打开以下地址：
>
> [chrome://flags/#block-insecure-private-network-requests](chrome://flags/#block-insecure-private-network-requests)
>
> 将其设置为 `Disabled`，然后重启浏览器即可。

## 部署

> 如果需要配置生产环境的变量，可以复制 `examples/settings.local.yml` 到 `config` 目录，再针对需要修改。

使用 Docker 部署

    $ docker build -t <image-name> .
    $ docker run --rm --name <container-name> --network my-net -v <host-db-dir>:/myapp/db/sqlite3 -p <host-port>:9292 <image-name>

### 执行脚本

一般来讲，可以使用如下方式进入容器：

    # 进入 Docker 容器
    $ docker exec -it <container-name> bash
    
    # 在容器内执行脚本
    $ RACK_ENV=production bin/run scripts/xxx.rb

以上方式是进入已经运行的容器，但有时候需要在容器运行前执行脚本，这个时候可以创建容器并执行脚本：

    # 创建容器并进入交互式终端
    $ docker run -it <image-name> bash
    
    # 在容器内执行脚本
    $ RACK_ENV=production bin/run scripts/xxx.rb

## 其他命令

### 创建迁移文件

    $ bundle exec rake 'db:create_migration[<migration_name>]'
