require_relative'../register'

describe Register do 
	let(:register) {Register.new}

	it "a register can have money added to its total" do
		expect{register.payRegister([20, 20, 10, 10, 10, 10, 5, 5, 5, 5, 5, 5, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])}.to change{register.total}.by(128)
	end

	it "a register keeps track of different bill types" do
		expect{register.payRegister([20, 20, 10, 10, 10, 10, 5, 5, 5, 5, 5, 5, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])}.to change{register.twenties.length}.by(2)
	end
	
	it "a register can change the amount of bills it contains" do
		register.payRegister([20])
		expect{register.payCustomer([20])}.to change{register.twenties.length}.by(-1)
	end

	it "will not give bills unless there is that bill present in register" do
		register.payRegister([20, 10, 5])
		expect{register.payCustomer([2])}.to raise_error(ArgumentError)
	end

	it "makes change if available" do
		register.payRegister([20, 20, 10, 10, 10, 10, 5, 5, 5, 5, 5, 5, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])
		register.payCustomer([20, 10, 10, 10, 10, 5, 5, 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])
		expect{register.makeChange(11)}.to change{register.total}.by(-11)
	end

	it "raises an error if register doesn't have correct combination of bills to give change" do
		register.payRegister([20, 20, 10, 10, 10, 10, 5, 5, 5, 5, 5, 5, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])
		register.payCustomer([20, 10, 10, 10, 10, 5, 5, 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])
		register.makeChange(11)
		expect{register.makeChange(14)}.to raise_error(ArgumentError)
	end

end