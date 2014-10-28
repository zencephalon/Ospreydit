before '/comment/:id' do |id|
  @comment = Comment.find(id)
end

get '/comments' do
  @comments = Comment.all
  erb :'comment/all'
end

get '/comment/:id' do |id|
  erb :'comment/single', locals: {comment: @comment}
end

post '/comment' do
  Comment.create(params[:comment])

  redirect to('/comments')
end

delete '/comment/:id' do |id|
  @comment.destroy

  redirect to('/comments')
end

get '/comment/:id/edit' do |id|
  @comment = Comment.find(id)

  erb :'comment/_update_form', locals: {comment: @comment}
end

put '/comment/:id' do |id|
  @comment.update(params[:comment])

  redirect to("/comment/#{id}")
end