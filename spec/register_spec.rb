require_relative '../register'

describe Register do 
	let(:register) {Register.new}
	
	it "a register can have money added to its total" do
		expect{register.payRegister([20, 20, 10, 10, 10, 10, 5, 5, 5, 5, 5, 5, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])}.to change{register.total}.by(128)
	end

	it "a register contains individual bills that were given to it" do
		register.payRegister([20, 20, 10, 10, 10, 10, 5, 5, 5, 5, 5, 5, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])
		expect(register.currentBills).to eq([20, 20, 10, 10, 10, 10, 5, 5, 5, 5, 5, 5, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])
	end

	it "a register's total changes when a customer is paid" do
		register.payRegister([20, 20, 10, 10, 10, 10, 5, 5, 5, 5, 5, 5, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])
		register.payCustomer([20, 10, 10, 10, 10, 5, 5, 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])
		expect(register.total).to eq(43)
	end

	it "a register's bills are updated when a customer is paid" do
		register.payRegister([20, 20, 10, 10, 10, 10, 5, 5, 5, 5, 5, 5, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])
		register.payCustomer([20, 10, 10, 10, 10, 5, 5, 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])
		expect(register.currentBills).to eq([20, 5, 5, 5, 2, 2, 2, 2])
	end

	it "makes change with ideal amount of bills" do
		register.payRegister([20, 20, 10, 10, 10, 10, 5, 5, 5, 5, 5, 5, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])
		register.payCustomer([20, 10, 10, 10, 10, 5, 5, 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])
		expect{register.makeChange(11)}.to change{register.total}.by(-11)
	end

	it "won't give change it bill combinations are not available" do 
		register.payRegister([20, 20, 10, 10, 10, 10, 5, 5, 5, 5, 5, 5, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])
		register.payCustomer([20, 10, 10, 10, 10, 5, 5, 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])
		register.makeChange(11)
		expect(register.makeChange(14)).to be false
	end

	it "can give change even if currency denominations are changed" do
		register.payRegister([10, 7, 7, 5, 2])
		expect{register.makeChange(14)}.to change{register.total}.by(-14)
	end

	it "knows if an array of numbers can add up to a specific number or not" do
		expect(register.sum_up?(4, [7, 2, 2, 1])).to be true
	end


end