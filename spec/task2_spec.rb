require './lib/task2'

describe Takeaway do
	let(:my_order) { Takeaway.new }

	before (:each) do	
		my_order.stub(:sms) 
	end
	
	context "Menu checking" do
		it "should not throw an error if ordering something on the menu" do
			expect{my_order.place_order(["chicken curry"], [1], 5.50)}.to_not raise_error
		end

		it "should throw an error if ordering something not on the menu" do
			expect{my_order.place_order(["banana"], [1], 1)}.to raise_error "We do not have banana"
		end
	end

	context "Price checking" do
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
	end

	context "Placing orders" do
		it "should have the correct order" do
			my_order.place_order(["Rice"], [2], 5)
			expect(my_order.order).to eq(["2 Rice"])
		end

		it "should return the correct message for an order" do
			my_order.place_order(["Rice"], [2], 5)
      expect(my_order.message()).to eq "Thank you! You ordered:\n  2 rice \nYour total is 5.0. \nYour order will be delivered before 14:35."
    end

	  it "should send an SMS if calculation is correct" do
	    my_order.should_receive(:sms).once
	    my_order.place_order(["Rice"], [2], 5)
	  end
	end

end