require './lib/task1'

describe Array do

	it "should throw an error if block or sym is not given" do
		expect { [1,2,3].fake_inject }.to raise_error
	end

	it "should return 45 because of the block" do
		expect([5,6,7,8,9,10].fake_inject {|sum, n| sum + n} ).to eq(45)
	end

	it "should take an initial value" do
		expect([1,2,3].fake_inject(1) {|sum, n| sum + n}).to eq(7)
	end

	it "should allow symbols intead of block" do
		expect([1,2,3].fake_inject(:+)).to eq(6)
	end

	it "should take an initial value and sym" do
		expect([4,5,6].fake_inject(1, :*)).to eq(120)
	end

end