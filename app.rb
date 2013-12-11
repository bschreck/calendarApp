require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'stripe'
require 'uri'
require 'httparty'
require 'json'

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
    @amount = 1500
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

  get '/bitcoin' do
    secret = ENV['SECRET_KEY']
    my_address = '1Ecc2z3FtS19qddCBQHqcoSHns3ghMZRMc';
    my_callback_url = 'https://benschreckshits.com/receivebtc/?secret='+secret
    root_url = 'https://blockchain.info/api/receive'
    parameters = 'method=create&address='+ my_address + '&callback=' + URI.escape(my_callback_url)
    response = HTTParty.get(root_url + '?' + parameters)
    input_address = 0
    response.each do |item|
      if item[0] == 'input_address'
        input_address = item[1]
      end
    end
    if input_address != 0
      p 'Send Payment To : ' + input_address;
    end
  end

  invoice_id = 0
  transaction_hash = 0
  input_transaction_hash = 0
  input_address = 0
  value_in_btc = 0

  get '/receivebtc/:secret/*' do
    if ENV['SECRET_KEY'] != params[:secret]
      p "bad secret: #{params[:secret]}"
    end

    #invoice_id = params[:invoice_id]
    #transaction_hash = params[:transaction_hash]
    #input_transaction_hash = params[:input_transaction_hash]
    #input_address = params[:input_address]
    #value_in_satoshi = params[:value]
    #value_in_btc = value_in_satoshi / 100000000
    if params[:test] == true
      return
    end
    p '*ok*'
  end

  get '/value' do
    p invoice_id, transaction_hash, input_transaction_hash, input_address, value_in_btc
  end

  error Stripe::CardError do
    env['sinatra.error'].message
  end

end
