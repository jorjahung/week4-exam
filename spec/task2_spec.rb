require './lib/task2'

describe Takeaway do
	let(:my_order) { Takeaway.new }
	
	it "should not throw an error if ordering something on the menu" do
		expect{my_order.take_order("chicken curry", 1, 5.50)}.to_not raise_error
	end

	it "should throw an error if ordering something not on the menu" do
		expect{my_order.take_order("banana", 1, 1)}.to raise_error
	end

	it "should not raise an error if the price given is correct" do
		expect{my_order.take_order("Rice", 2, 5)}.to_not raise_error
	end

	it "should not raise error if the price given is incorrect" do
		expect{my_order.take_order("Rice", 2, 4)}.to raise_error
	end

	it "should have the correct order" do
		my_order.take_order("Rice", 2, 5)
		expect(my_order.order).to eq(["Rice"])
	end
end