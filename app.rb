require 'sinatra'
require 'sinatra/base'
require 'stripe'

class MyApp < Sinatra::Base
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
    @amount = 500

    customer = Stripe::Customer.create(
      :email => 'customer@example.com',
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
