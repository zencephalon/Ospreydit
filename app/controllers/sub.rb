before '/sub/:id' do |id|
  @sub = Sub.find(id)
end

get '/subs' do
  @subs = Sub.all
  erb :'sub/all'
end

get '/sub/:id' do |id|
  @comments = @sub.comments
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

get '/sub/:id/edit' do |id|
  @sub = sub.find(id)

  erb :'sub/_update_form', locals: {sub: @sub}
end

put '/sub/:id' do |id|
  @sub.update(params[:sub])

  redirect to("/sub/#{id}")
end