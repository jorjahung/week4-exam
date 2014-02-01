require './lib/task2'

describe Takeaway do
	let(:my_order) { Takeaway.new }
	
	it "should not throw an error if ordering something on the menu" do
		expect{my_order.place_order(["chicken curry"], [1], 5.50)}.to_not raise_error
	end

	it "should throw an error if ordering something not on the menu" do
		expect{my_order.place_order(["banana"], [1], 1)}.to raise_error
	end

	it "should be able to calculate the correct total" do
		my_order.place_order(["Rice", "chicken curry"], [2, 1], 10.50)
		expect(my_order.correct_calculation).to eq(10.50)
	end

	it "should not raise an error if the price given is correct" do
		expect{my_order.place_order(["Rice", "chicken curry"], [2, 1], 10.50)}.to_not raise_error
	end

	it "should raise error if the price given is incorrect" do
		expect{my_order.place_order(["Rice"], [2], 4)}.to raise_error
	end

	it "should have the correct order" do
		my_order.place_order(["Rice"], [2], 5)
		expect(my_order.order).to eq(["2 Rice"])
	end

end