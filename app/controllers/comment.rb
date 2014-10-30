['/comment/:id', '/comment/:id/edit', '/comment/:id/vote'].each do |route|
  before route do |id|
    @comment = Comment.find(id)
  end
end

get '/comments' do
  @comments = Comment.all
  erb :'comment/all'
end

get '/comment/:id' do |id|
  erb :'comment/single', locals: {comment: @comment}
end

post '/comment', auth: :user do
  params[:comment][:user_id] = current_user.id
  Comment.create(params[:comment])

  redirect to("/sub/#{params[:comment][:sub_id]}")
end

delete '/comment/:id', auth: :user do |id|
  @comment.destroy

  redirect to('/comments')
end

get '/comment/:id/edit', auth: :user do |id|
  erb :'comment/_update_form', locals: {comment: @comment}
end

put '/comment/:id', auth: :user do |id|
  @comment.update(params[:comment])

  redirect to("/comment/#{id}")
end

# Voting!
post '/comment/:id/vote', auth: :user do |id|
  error = ""
  unless @comment.vote(current_user)
    error = "U've already voted on this, cheater."
  end

  redirect to("/comment/#{@comment.id}?error=#{error}")
end
