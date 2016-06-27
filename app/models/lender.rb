class Lender < ActiveRecord::Base
	has_many :histories

	email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

	attr_accessor :password_confirmation

	validates :first_name, :presence => true, length: { :minimum => 2 }
	validates :last_name, :presence => true, length: { :minimum => 2 }
	validates :email, :presence => true, :format => { :with => email_regex}, :uniqueness => { :case_sensitive => false }, :confirmation => true
	validates :password, :length => { :minimum => 8 }
	validates :money, presence: true, numericality: { greater_than_or_equal_to: 1 }


end
