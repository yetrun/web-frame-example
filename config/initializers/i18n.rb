# frozen_string_literal: true

glob_path = Pathname.new(__dir__).join('../locales/*.yml')
I18n.load_path += Dir[glob_path]
