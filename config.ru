require './app'
use Rack::Static, :urls => ['/images', '/jquery', 'bootstrap'], :root => 'public'
run Sinatra::Application
