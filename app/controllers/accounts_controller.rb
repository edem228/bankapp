class AccountsController < ApplicationController

  before_action :find_account, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :account_owner?, only: [:show]

  def index
    @user = current_user
    if @user.is_admin?
      @accounts = Account.all
    else
      @accounts = @user.accounts
    end
  end

  def new
    @account = current_user.accounts.build
  end

  def show
    
  end

  def create
    @account = current_user.accounts.build(account_params)
    if @account.save
      redirect_to @account, notice: "Le compte bancaire été bien créé"
    else
      render "new"
    end
  end

  def edit
    
  end

  def update
    if @account.update(account_params)
      redirect_to :account, notice: "Votre compte bancaire a été bien mis à jour"
    else
      render "edit"
    end
  end

  def destroy
    @account.destroy
    redirect_to root_path
  end

  private

  def find_account
    @account = Account.find(params[:id])
  end

  def account_owner?
    if current_user.id != @account.user_id && !current_user.is_admin?
      redirect_to root_path, notice: "Action interdite !"
    end
  end

  def account_params
    params.require(:account).permit(:title, :login)
  end

end
