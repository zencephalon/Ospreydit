before '/sub/:id' do |id|
  @sub = sub.find(id)
end

get '/subs' do
  @subs = sub.all
  erb :'sub/all'
end

get '/sub/:id' do |id|
  erb :'sub/single', locals: {sub: @sub}
end

post '/sub' do
  sub.create(params[:sub])

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