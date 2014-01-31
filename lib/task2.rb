class Takeaway
	
	MENU = [
		{ food: "Rice", price: 2.50 },
		{ food: "Spring rolls", price: 3.50 },
		{ food: "Dumplings", price: 4.00 },
		{ food: "Roast duck", price: 6.50 },
		{ food: "Chicken curry", price: 5.50 }
	]

	attr_accessor :order, :total
	
	def initialize
		@order = []
		@total = []
	end
	
	# Not sure if I want to print the menu or not...
	# def print_menu
	# 	MENU.each do |item|
	# 		puts "#{item[:food]} - #{item[:price]}"
	# 	end
	# end

	def take_order(item, quantity, subtotal)
		raise "We do not have that item" if !correct_item?(item)
		raise "Wrong subtotal given" if !correct_calculation?(item, quantity, subtotal)
		order << item
		total << quantity*subtotal
	end

	def correct_calculation?(item, quantity, subtotal)
		subtotal == MENU.select {|menu| menu[:food] == item.capitalize}.map { |menu| menu[:price]}[0]*quantity
	end

	def correct_item?(item)
		MENU.any? {|menu| menu[:food] == item.capitalize}
	end

end