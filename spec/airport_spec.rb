require 'airport'

describe Airport do
  subject(:airport) { described_class.new(described_class::AIRPORT_CAPACITY)}
  let(:plane) { double :plane }

  context 'when weather is stormy' do
    before do
      allow(airport).to receive(:stormy?).and_return(true)
    end
    it "can't land - raises error" do
      expect { airport.land(plane) }.to raise_error "Stormy, can't land"
    end

    it 'prevents departing - raises error' do
      expect {airport.depart(plane)}.to raise_error "Stormy, can't depart"
    end
  end

  describe '#land' do
    before do
      allow(airport).to receive(:stormy?).and_return(false)
    end

    it 'confirms plane to be not flying' do
      airport.land(plane)
      expect(airport.at_airport).to include plane
    end

    it "can't land - raises error" do
      message = "Plane already landed"
      allow(airport).to receive(:flying?).and_return(false)
      expect { airport.land(plane) }.to raise_error message
    end

    it "airport full - raises error" do
      message = 'Airport full!'
      airport.capacity.times { airport.land(plane) }
      expect { airport.land(plane) }.to raise_error message
    end
  end

  describe '#depart' do
    before do
      allow(airport).to receive(:flying?).and_return(true)
    end
    it 'confirms plane not in the airport' do
      expect(airport.at_airport).not_to include plane
    end
    it "can't depart - raises error" do
      expect {airport.depart(plane)}.to raise_error "Plane already flying"
    end
  end
end
