class OnlineLendingController < ApplicationController

  def register
    session[:user_id] = nil
    session[:user_type] = nil
  end

  def login
    session[:user_id] = nil
    session[:user_type] = nil
  end

  def create_lender
    @lender = Lender.create(lender_params)
    if @lender.save
      session[:user_id] = @lender.id
      session[:user_type] = 'lender'
      redirect_to lender_path @lender
    else
      flash[:errors] = @lender.errors.full_messages
      redirect_to :back
    end
  end

  def create_borrower
    @borrower = Borrower.create(borrower_params)
    if @borrower.save
      session[:user_id] = @borrower.id
      session[:user_type] = 'borrower'
      redirect_to borrower_path @borrower
    else
      flash[:errors] = @borrower.errors.full_messages
      redirect_to :back
    end
  end

  def lender
    @lender = Lender.find(params[:id])
    @borrowers = Borrower.all 
    @history = History.new
    @lendees = History.joins(:borrower).select('*').where(lender:Lender.find(params[:id]))

  end

  def borrower
    @borrower = Borrower.find(params[:id])
    @lenders = History.joins(:lender).select('*').where(borrower:Borrower.find(params[:id]))

  end

  def lend_money
    @lender = Lender.find(session[:user_id])
    amount = (@lender.money - params[:amount].to_i)
    @lender.update(money:amount)
    @borrower = Borrower.find(params[:id])
    amount2 = (@borrower.money + params[:amount].to_i)
    @borrower.update(money:amount2)
    @history = History.create(amount:params[:amount].to_i, lender:@lender, borrower:@borrower)
    redirect_to :back
  end

  def lender_params
    params.require(:lender).permit(:first_name, :last_name, :email, :password, :money)
  end

  def borrower_params
    params.require(:borrower).permit(:first_name, :last_name, :email, :password, :money, :purpose, :description, :need)
  end
end
