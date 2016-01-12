class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :transaction_owner, except: [:create]
  before_action :is_admin?, only: [:create]
  def create
    @account = Account.find(params[:account_id])
    @transaction = @account.transactions.create(transaction_params)
    @transaction.user_id = current_user.id if current_user
    @transaction.save
    if @transaction.save
      redirect_to account_path(@account), notice: "Votre transaction a été bien ajoutée"
    else
      render "transactions/form"
    end
  end

  def edit
    @account = Account.find_by(params[:account_id])
    @transaction = @account.transactions.find_by(params[:id])
  end

  def update
    @account = Account.find(params[:account_id])
    @transaction = @account.transactions.find(params[:id])
    if @transaction.update(transaction_params)
      redirect_to account_path(@account), notice: "Votre transaction a été bien mise à jour"
    else
      render "edit"
    end
  end

  def destroy
    @account = Account.find(params[:account_id])
    @transaction = @account.transactions.find(params[:id])
    @transaction.destroy
    redirect_to account_path(@account), notice: "La transaction à été supprimée avec succès"
  end

  private

  def transaction_owner
    @account = Account.find_by(params[:account_id])
    @transaction = @account.transactions.find_by(params[:id])
    if current_user.id != @transaction.user_id
      redirect_to account_path(@account), notice: "Action interdite!"
    end
  end

  def transaction_params
    params.require(:transaction).permit(:title, :amount, :outgoing)
  end
end
