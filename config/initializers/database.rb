# frozen_string_literal: true

require 'otr-activerecord'

OTR::ActiveRecord.configure_from_file! 'config/database.yml'
OTR::ActiveRecord.establish_connection!
