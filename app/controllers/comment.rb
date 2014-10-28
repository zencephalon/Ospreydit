get '/comments/all' do
  @comments = Comment.all
  erb :'comment/all'
end

get '/comments/:id' do |id|
  @comment = Comment.find(id)
  erb :'comment/single', locals: {comment: @comment}
end

post '/comments' do
  Comment.create(params[:comment])

  redirect to('/comments/all')
end

delete '/comments/:id' do |id|
  @comment = Comment.find(id)
  @comment.destroy

  redirect to('/comments/all')
end

get '/comments/:id/edit' do |id|
  @comment = Comment.find(id)

  erb :'comment/_update_form', locals: {comment: @comment}
end

put '/comments/:id' do |id|
  @comment = Comment.find(id)
  @comment.update(params[:comment])

  redirect to("/comments/#{id}")
end