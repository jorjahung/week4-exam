class Array

	def fake_inject(initial=nil, sym=nil, &block)
		sym, initial = initial, nil if initial.is_a?(Symbol) 
		raise "No block given" if sym==nil && !block_given?
		block = sym.to_proc if sym !=nil

		memo = initial || self.shift

		self.each do |element| 
			memo = block.call(memo, element)
		end
		memo
	end

end