require './lib/task1'

describe Array do
	
	let(:test_array) {(1..10).to_a}


	it "should throw an error if block or sym is not given" do
		expect { test_array.fake_inject }.to raise_error
	end

	it "should return 55 because of the block" do
		expect(test_array.fake_inject {|sum, n| sum + n}).to eq(55)
	end

	it "should take an initial value" do
		expect(test_array.fake_inject(1) {|sum, n| sum + n}).to eq(56)
	end

	it "should allow symbols intead of block" do
		expect(test_array.fake_inject(:-)).to eq(-53)
	end

	it "should take an initial value and sym" do
		expect(test_array.fake_inject(2, :*)).to eq(7257600)
	end

end