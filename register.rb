class Register
	attr_accessor :total, :twenties, :tens, :fives, :twos, :ones

	def initialize
		@total = 0
		@twenties = []
		@tens = []
		@fives = []
		@twos = []
		@ones = []
	end

	def payRegister(arrayOfBills)
		arrayOfBills.each do |bill|
			if bill == 20 
				self.twenties << '20'
				self.total += 20
			elsif bill == 10
				self.tens << '10'
				self.total += 10
			elsif bill == 5
				self.fives << '5'
				self.total += 5
			elsif bill == 2
				self.twos << '2'
				self.total += 2
			elsif bill == 1
				self.ones << '1'
				self.total += 1
			else 
				puts "Sorry not currently accepting currency of the following amount >> #{bill}"
			end
		end
	end

	def payCustomer(arrayOfBills)
		arrayOfBills.each do |bill|
			if bill == 20 && twenties?
				p self.twenties
				self.twenties.delete_at(0) 
				p self.twenties
				self.total -= 20
			end
		end 
	end

	def twenties?
		if self.twenties.length >= 1
			return true
		end
	end

	def tens?
		if self.tens.length >= 1
			return true
		end
	end

	def fives?
		if self.fives.length >= 1
			return true
		end
	end

	def twos?
		if self.twos.length >= 1
			return true
		end
	end

	def ones?
		if self.ones.length >= 1
			return true
		end
	end
end


