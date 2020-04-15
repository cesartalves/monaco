require_relative "../../spec_helper"

module Monaco
  describe Simulation do
    describe "#initialize" do
      it "accepts a number of trials" do
        expect(Simulation.new(trials: 500)).to be_a(Simulation)
      end

      it "accepts a block containing the trial" do
        expect(Simulation.new { puts "foo" }).to be_a(Simulation)
      end
    end

    describe "#run" do
      it "runs the block n times" do
        count = 0
        simulation = Simulation.run(trials: 50) { count += 1 }
        expect(count).to eq(50)
      end

      it "passes the trial number to the block" do
        trial_count = 0
        simulation = Simulation.run(trials: 50) { |n| trial_count = n }
        expect(trial_count).to eq(50)
      end

      it "returns a probability based on the block's return value" do
        probability = Simulation.run(trials: 100) { |n| true }
        expect(probability).to eq(Rational(100, 100))

        probability = Simulation.run(trials: 100) { |n| false }
        expect(probability).to eq(Rational(0, 100))

        probability = Simulation.run(trials: 100) { |n| n == 1 }
        expect(probability).to eq(Rational(1, 100))
      end
    end
  end
end
