# frozen_string_literal: true

Config.load_and_set_settings(
  'config/settings.yml',
  "config/settings/#{ENV['RACK_ENV']}.yml",
  'config/settings.local.yml',
  "config/settings/#{ENV['RACK_ENV']}.local.yml"
) # 顺序很重要，后者会覆盖前者
