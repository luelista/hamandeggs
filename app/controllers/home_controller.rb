class HomeController < ApplicationController
  def index
    if current_user then
      redirect_to "/dashboard"
      return
    end
    @newUser = User.new
    
  end
  
  
  def signup
    @newUser = User.new(params[:user])
    if request.post?  
      if @newUser.save
        session[:user] = User.authenticate(@newUser.username, @newUser.password)
        flash[:message] = "Signup successful"
        redirect_to "/dashboard"
        return
      else
        flash[:warning] = "Signup unsuccessful"
      end
    end
    render "index"
  end
  
  def dashboard
  end
  
end
