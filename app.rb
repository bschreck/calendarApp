require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'stripe'

##db = URI.parse('postgres://user:pass@localhost/dbname')
#db = URI.parse(ENV['DATABASE_URL'])

#ActiveRecord::Base.establish_connection(
  #:adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  #:host     => db.host,
  #:username => db.user,
  #:password => db.password,
  #:database => db.path[1..-1],
  #:encoding => 'utf8'
#)

#class User < ActiveRecord::Base
#end

class MyApp < Sinatra::Base
  configure :development, :test do
    set :host, 'localhost:5000'
    set :force_ssl, false
  end
  configure :production do
    set :host, 'benschreckshits.com'
    set :force_ssl, true
  end

  #before do
    #content_type :json
    #ssl_whitelist = ['/calendar.ics']
    #if settings.force_ssl && !request.secure? && !ssl_whitelist.include?(request.path_info)
      #halt json_status 400, "Please use SSL at https://#{settings.host}"
    #end
  #end
  set :publishable_key, ENV['PUBLISHABLE_KEY']
  set :secret_key, ENV['SECRET_KEY']

  Stripe.api_key = settings.secret_key

  get '/' do
    erb :index
  end

  get '/order' do
    erb :order
  end

  get '/info' do
    erb :info
  end

  get '/creators' do
    erb :creators
  end

  get '/mailinglist' do
    erb :mailinglist
  end

  post '/charge' do
    # Amount in cents
    @amount = 1000
    customer = Stripe::Customer.create(
      :email => params[:email],
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :amount      => @amount,
      :description => 'Sinatra Charge',
      :currency    => 'usd',
      :customer    => customer.id
    )

    erb :charge
  end

  error Stripe::CardError do
    env['sinatra.error'].message
  end

end
