before '/sub/:id' do |id|
  @sub = Sub.find(id)
end

get '/subs' do
  @subs = Sub.all
  erb :'sub/all'
end

get '/sub/:id' do |id|
  @comments = @sub.top_level_comments
  erb :'comment/all'
end

post '/sub' do
  Sub.create(params[:sub])

  redirect to('/subs')
end

delete '/sub/:id' do |id|
  @sub.destroy

  redirect to('/subs')
end
