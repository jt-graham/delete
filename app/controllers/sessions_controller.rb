class SessionsController < ApplicationController
  def create
  	user = Lender.find_by_email(params[:email])

  	if user
  		session[:user_id] = user.id
  		session[:user_type] = 'lender'
  		redirect_to lender_path user

  	else
  		user = Borrower.find_by_email(params[:email])
  			if user
  				session[:user_id] = user.id
  				session[:user_type] = 'borrower'
  				redirect_to borrower_path user

  			else
  				flash[:errors] = ["Invalid combination"]
  				redirect_to :back
  			end
  	end
  end

  def destroy
  	session[:user_id] = nil
  	session[:user_type] = nil
  	redirect_to '/'
  end
end
