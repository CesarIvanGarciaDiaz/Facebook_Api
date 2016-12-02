get '/' do
  if session[:user_id]
    @user = User.find_by(id:session[:user_id])
    @user_facebook = @user.facebook
    erb :index
  else
    erb :login
  end
end

get '/auth/:provider/callback' do
  user = User.from_omniauth(env["omniauth.auth"])
  if user
    session[:user_id] = user.id
  end
  # Redirige a su perfil
  redirect to "/"
end

get "/logout" do
  session.clear
  redirect to "/"
end
