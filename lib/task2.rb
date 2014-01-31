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

	def place_order(item, quantity, subtotal)
		raise "We do not have that item" if !correct_item?(item)
		raise "Wrong subtotal given" if !correct_calculation?(item, quantity, subtotal)
		order << item
		total << quantity*subtotal
		sms		
	end

	def sms
		@account_sid = 'ACe6c81d48df21f8af97caad2e7f7b4f9a'
		@auth_token = 'c335c900163fb2da27b139fe89de544b'

		@client = Twilio::REST::Client.new @account_sid, @auth_token
		@client.account.sms.messages.create(
	  :from => '+441985250028',
	  :to => '+447765645760',
	  :body => "Thank you! Your order was placed and will be delivered before #{TIME}")
	end
	
	def correct_calculation?(item, quantity, subtotal)
		subtotal == MENU.select {|menu| menu[:food] == item.capitalize}.map { |menu| menu[:price]}[0]*quantity
	end

	def correct_item?(item)
		MENU.any? {|menu| menu[:food] == item.capitalize}
	end

end