get '/' do
  redirect to '/subs'
end

get '/login' do
  erb :'auth/login'
end

get '/signup' do
  erb :'auth/signup'
end

post '/signup' do
  user = User.new(params[:user])

  if user.save
    session[:user_id] = user.id
    redirect to('/')
  else
    # display an error message and have them try again
  end
end