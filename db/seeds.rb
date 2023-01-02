# frozen_string_literal: true

# 根据 RACK_ENV 环境的不同加载种子文件，请在当前目录下添加 `seeds.development`、`seeds.production` 等文件。
# 同时 `rake db:seed` 命令已经加载 config/environment 环境，请放心使用。

seeds_file = File.join(__dir__, "seeds.#{Application.env}.rb")
require seeds_file if File.exist?(seeds_file)
