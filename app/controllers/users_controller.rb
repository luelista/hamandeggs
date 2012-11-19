class UsersController < ApplicationController
  before_filter :admin_required, :only=>['index', 'show', 'new', 'edit', 'create', 'update', 'destroy']
  before_filter :login_required, :only=>['account', 'reset', 'change_password']
  
  def login
    if request.post?
      if session[:user] = User.authenticate(params[:user][:login], params[:user][:password])
        flash[:message]  = "Login successful"
        redirect_to_stored
      else
        flash[:warning] = "Login unsuccessful"
      end
    end
  end

  def logout
    session[:user] = nil
    flash[:message] = 'Logged out'
    redirect_to :controller => 'home', :action => 'index'
  end
  
  def account
  end
  
  def reset
    current_user.reset
    flash[:message] = 'All data cleared'
    redirect_to :action => 'account'
  end
  
  def change_password
  end
  
  # GET /users
  # GET /users.json
  def index
    
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    admin_required
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    admin_required
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    admin_required
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    admin_required
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    admin_required
    @user = User.find(params[:id])

    respond_to do |format|
      
      @user.username = params[:user][:username]
      @user.password = params[:user][:password] if not params[:user][:password].blank?
      @user.fullname = params[:user][:fullname]
      @user.email = params[:user][:email]
      @user.exam_type = params[:user][:exam_type]
      
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    admin_required
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
