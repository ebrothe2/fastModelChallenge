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
				raise ArgumentError.new('Please only enter valid bills, not accepting #{bill}')			
			end
		end
	end

	def payCustomer(arrayOfBills)
		arrayOfBills.each do |bill|
			if bill == 20 && twenties?
				self.twenties.delete_at(0) 
				self.total -= 20
			elsif bill == 10 && tens?
				self.tens.delete_at(0)
				self.total -= 10
			elsif bill == 5 && fives?
				self.fives.delete_at(0)
				self.total -= 5
			elsif bill == 2 && twos?
				self.twos.delete_at(0)
				self.total -= 2
			elsif bill == 1 && ones?
				self.ones.delete_at(0)
				self.total -= 1
			else
				raise ArgumentError.new('sorry do not currently have #{bill}\'s in the cash register') 
			end
		end 
	end

	def makeChange(number)
		if number > self.total
			raise ArgumentError.new('Not enough money in register to accomodate change for that amount')
		end
		billsToMakeChange = []
		changeLeftToGive = number
		if changeLeftToGive/20 >= 1
			if twenties?
				idealnumberoftwenties = changeLeftToGive/20
				if idealnumberoftwenties <= billsInRegister(20)
					billsToMakeChange += Array.new(billsInRegister(20), 20)
					changeLeftToGive -= 20 * billsInRegister(20)
				elsif idealnumberoftwenties > billsInRegister(20)
					billsToMakeChange += Array.new(billsInRegister(20), 20)
					changeLeftToGive -= 20 * billsInRegister(20)
				end
			end
		end
		if changeLeftToGive/10 >= 1
			if tens?
				idealnumberoftens = changeLeftToGive/10
				if idealnumberoftens <= billsInRegister(10)
					billsToMakeChange += Array.new(billsInRegister(10), 10)
					changeLeftToGive -= 10 * idealnumberoftens 
				elsif idealnumberoftens > billsInRegister(10)
					billsToMakeChange += Array.new(billsInRegister(10), 10)
					changeLeftToGive -= 10 *billsInRegister(10)
				end
			end
		end
		if changeLeftToGive/5 >= 1
			if fives?
				idealnumberoffives = changeLeftToGive/5
				if billsInRegister(1) == 0 && changeLeftToGive - (idealnumberoffives*5) == 1 && idealnumberoffives-1 <= billsInRegister(5)
					billsToMakeChange += Array.new(idealnumberoffives-1, 5)
					changeLeftToGive -= 5 * (idealnumberoffives-1)
				elsif idealnumberoffives <= billsInRegister(5)
					billsToMakeChange += Array.new(idealnumberoffives, 5)
					changeLeftToGive -= 5 * idealnumberoffives 
				elsif idealnumberoffives > billsInRegister(5)
					billsToMakeChange += Array.new(billsInRegister(5), 5)
					changeLeftToGive -= 5 * billsInRegister(5)
				end
			end
		end
		if changeLeftToGive/2 >= 1
			if twos?
				idealnumberoftwos = changeLeftToGive/2
				if idealnumberoftwos <= billsInRegister(2)
					billsToMakeChange += Array.new(idealnumberoftwos, 2)
					changeLeftToGive -= 2 * idealnumberoftwos
				elsif idealnumberoftwos > billsInRegister(2)
					billsToMakeChange += Array.new(billsInRegister(2), 2)
					changeLeftToGive -= 2 * billsInRegister(2)
				end
			end
		end
		if changeLeftToGive/1 >= 1
			if ones?
				idealnumberofones = changeLeftToGive/1
				if idealnumberofones <= billsInRegister(1)
					billsToMakeChange += Array.new(idealnumberofones, 1)
					changeLeftToGive -= 1 * idealnumberofones
				elsif idealnumberofones > billsInRegister(1)
					billsToMakeChange += Array.new(billsInRegister(1), 1)
					changeLeftToGive -= 1 * billsInRegister(1)
				end
			end
		end

		if changeLeftToGive == 0 
			payCustomer(billsToMakeChange)
		else 
			raise ArgumentError.new('We cannot accomodate change for that amount at this time')
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

	def billsInRegister(bill)
		if bill == 20
			return self.twenties.length
		elsif bill == 10
			return self.tens.length
		elsif bill == 5
			return self.fives.length
		elsif bill == 2
			return self.twos.length
		elsif bill == 1
			return self.ones.length
		else
			raise ArgumentError.new('Not a valid bill increment')
		end
	end
end


