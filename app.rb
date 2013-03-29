require 'pathname'
require 'sqlite3'

APP_ROOT = Pathname.new(File.dirname(File.expand_path(__FILE__)))
require APP_ROOT.join('app', 'models', 'legislator')
require APP_ROOT.join('app', 'models', 'political_party')
require APP_ROOT.join('app', 'models', 'position')
require APP_ROOT.join('app', 'models', 'state')
require APP_ROOT.join('db', 'config')
