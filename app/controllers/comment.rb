get '/comments/all' do
  @comments = Comment.all
  erb :'comment/all'
end

get '/comments/:id' do |id|
  @comment = Comment.find(id)
  erb :'comment/single', locals: {comment: @comment}
end
