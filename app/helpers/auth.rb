def current_user
  if session[:user_id]
    return User.find(session[:user_id])
  else
    return nil
  end
end

def user_can_edit?(comment)
  current_user && current_user.may_edit(comment)
end