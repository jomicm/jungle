class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    puts "email " + params[:email]
    puts "password " + params[:password]
    p user
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password])
      puts "Hits correct"
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      redirect_to '/'
    else
    # If user's login doesn't work, send them back to the login form.
      puts "Hits incorrect"
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end
end
