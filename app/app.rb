require 'sinatra'
require 'sinatra/flash'
require_relative '../lib/peep'
require_relative '../lib/user'
require_relative 'database_connection_setup'

class Chitter < Sinatra::Base

  enable :sessions
  register Sinatra::Flash

  get '/' do
    redirect '/peeps'
  end

  get '/peeps' do
    @name = User.find_by(id: session[:user_id]).name if session[:user_id]
    @peeps = Peep.all.order(created_at: :desc)
    erb :'peeps/index'
  end

  post '/peeps' do
    Peep.create(message: params['peep'], user_id: session[:user_id])
    redirect '/peeps'
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    new_user = User.create(name: params['name'], username: params['username'], email: params['email'],
                password: params['password'])
    session[:user_id] = new_user.id
    redirect '/peeps'
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    user = User.find_by(username: params['username'], password: params['password'])
    session[:user_id] = user.id if user
    redirect '/peeps'
  end

  post '/sessions/destroy' do
    session.clear
    flash[:notice] = 'You have logged out.'
    redirect '/peeps'
  end



end