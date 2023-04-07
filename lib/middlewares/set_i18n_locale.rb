require 'i18n'

class SetI18nLocale
  def initialize(app, locale = :'zh-CN')
    @app = app
    @locale = locale
  end

  def call(env)
    I18n.locale = @locale
    @app.call(env)
  end
end
