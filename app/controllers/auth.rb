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
    set_error "Username or password incorrect"
    redirect to ('/login')
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
    set_error "Passwords do not match"
    redirect to ("/signup?name=#{params[:user][:name]}")
  end
end