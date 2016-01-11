class AccountsController < ApplicationController

  before_action :find_account, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @accounts = Account.all
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

  def account_params
    params.require(:account).permit(:title, :login)
  end

end
