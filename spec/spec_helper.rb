$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'shingoncoder'
require 'byebug'
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
