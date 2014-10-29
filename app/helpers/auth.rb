def current_user
  if session[:user_id]
    return User.find(session[:user_id])
  else
    return nil
  end
end

def display_error
  return !params[:error].blank? ? "<p>Error: #{params[:error]}</p>" : ""
end