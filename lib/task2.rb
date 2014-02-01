require 'twilio-ruby'
require 'time'

class Takeaway
	
	MENU = [
		{ food: "Rice", price: 2.50 },
		{ food: "Spring rolls", price: 3.50 },
		{ food: "Dumplings", price: 4.00 },
		{ food: "Roast duck", price: 6.50 },
		{ food: "Chicken curry", price: 5.50 }
	]

	TIME = (Time.now+1*60*60).strftime("%H:%M") 

	attr_accessor :order, :total
	
	def initialize
		@order = []
		@total = []
	end

	def place_order(items, quantities, client_calculation)
		client_order = Hash[items.zip(quantities)]
		check_item(client_order)
		check_calculation(client_calculation)
	end

	def sms
		@account_sid = ENV['TWILIO_ACCOUNT_SID']
		@auth_token = ENV['TWILIO_AUTH_TOKEN']

		@client = Twilio::REST::Client.new @account_sid, @auth_token
		@client.account.sms.messages.create(
	  :from => '+441985250028',
	  :to => ENV['PHONE_NUMBER'],
	  :body => message)
	end

	def message
		"Thank you! You ordered:\n  #{order.join(", ").capitalize} \nYour total is #{correct_calculation}. \nYour order will be delivered before #{TIME}."
	end

	def check_calculation(client_calculation)
		if client_calculation != correct_calculation
			raise "Wrong calculation given" 
		else 
		 sms
		end	
	end

	def correct_calculation	
		total.flatten.inject(:+)
	end

	def check_item(client_order)
		client_order.each_pair do |item, quantity|
			raise "We do not have #{item}" if !MENU.any? {|menu| menu[:food] == item.capitalize}
			order << "#{quantity} #{item}"
			subtotal = MENU.select {|menu| menu[:food] == item.capitalize}.map { |menu| menu[:price]}*quantity
			total << subtotal
		end
		order.flatten!
	end
end
