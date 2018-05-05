RSpec.describe CoinTracking do
  it "has a version number" do
    expect(CoinTracking::VERSION).not_to be nil
  end

  812.times do |i|
    it "#{i}" do
      # Pretend to be running a bunch of complex specs.
      sleep Random.new.rand(5) / 1000.to_f
      expect(true).to eq(true)
    end
  end
end
