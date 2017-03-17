class Register
	attr_accessor :total, :currentBills

	def initialize
		@total = 0
		@currentBills = []
	end

	def payRegister(arrayOfBills)
		arrayOfBills.each do |bill|
			@total += bill 
			@currentBills << bill
		end
	end

	def payCustomer(arrayOfBills)
		arrayOfBills.each do |bill|
			@total -= bill
			@currentBills.delete_at(@currentBills.find_index(bill))
		end
	end

	def makeChange(number)
		changeLeftToMake = number
		billsForChange = []
		billsAvailableToMakeChange = @currentBills
		i = 0
		while i < billsAvailableToMakeChange.length do 
		 	if changeLeftToMake == 0
		 		payCustomer(billsForChange)
		 		return true
			elsif changeLeftToMake/billsAvailableToMakeChange[i] >= 1
				remainder = changeLeftToMake - billsAvailableToMakeChange[i] 
				if sum_up?(remainder, billsAvailableToMakeChange[i..-1]) == true
					changeLeftToMake -= billsAvailableToMakeChange[i]
				 	billsForChange << billsAvailableToMakeChange[i]
				end
				i += 1
			else
				i += 1
			end
			
		end

		if changeLeftToMake > 0 
			return false
		end 
	end

	def sum_up?(targetSum, allNums, partialArrayOfNums=[], containerArray=[])
		sum = 0
		partialArrayOfNums.each do |x|
			sum += x
		end
		if sum == targetSum
			containerArray << sum
			return true
		elsif sum > targetSum
			return false
		else
			(0..(allNums.length-1)).each do |i|
				n = allNums[i]
				remainingNums = allNums.drop(i+1)
				sum_up?(targetSum, remainingNums, partialArrayOfNums + [n], containerArray )
			end
		end

		if containerArray.include?(targetSum)
			return true
		end

	end
end