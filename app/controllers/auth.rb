get '/' do
  redirect to '/subs'
end

get '/login' do
  erb :'auth/login'
end

post '/login' do
  user = User.find_by(name: params[:name]).try(:authenticate, params[:password])

  if user
    session[:user_id] = user.id
    redirect to('/')
  else
    redirect to ('/login?error=Username or password incorrect')
  end
end

get '/signup' do
  erb :'auth/signup'
end

get '/logout' do
  session[:user_id] = nil
  redirect to('/')
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