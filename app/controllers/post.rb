get '/posts/all' do
  @comments = Comment.all
  @comments.map {|comment| comment.text}.join("<br>")
end

get '/posts/:id' do |id|
  @comment = Comment.find(id)
  @comment.text
end
