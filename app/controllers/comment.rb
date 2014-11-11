['/comment/:id', '/comment/:id/edit', '/comment/:id/vote'].each do |route|
  before route do |id|
    @comment = Comment.find(id)
  end
end

get '/comments/new' do
  erb :'comment/_new_form', locals: {parent_id: params[:parent_id], sub: Sub.find(params[:sub_id])}
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
  @comment = Comment.create(params[:comment])

  if request.xhr?
    erb :'comment/single', locals: {comment: @comment}, layout: false
  else
    redirect to("/sub/#{params[:comment][:sub_id]}")
  end
end

delete '/comment/:id', auth: :user do |id|
  @comment.destroy

  if request.xhr?
    return {deleted: true}.to_json
  else
    redirect to('/comments')
  end
end

get '/comment/:id/edit', auth: :user do |id|
  redirect to '/subs' unless current_user.may_edit(@comment)
  erb :'comment/_update_form', locals: {comment: @comment}
end

put '/comment/:id', auth: :user do |id|
  if current_user.may_edit(@comment)
    @comment.update(params[:comment])
  else
    set_error("U may not edit this.")
  end

  if request.xhr?
    return {comment_text: @comment.text}.to_json
  else
    redirect to("/comment/#{id}")
  end
end

# Voting!
post '/comment/:id/vote', auth: :user do |id|
  unless @comment.vote(current_user)
    set_error "U've already voted on this, cheater."
  end

  if request.xhr?
    return {score: @comment.score}.to_json
  else
    redirect to("/comment/#{@comment.id}")
  end
end
