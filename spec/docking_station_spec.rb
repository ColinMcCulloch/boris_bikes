require 'docking_station'
require 'pry'

describe DockingStation do

  subject(:dockingstation) {described_class.new}
  let(:bike) {double :bike}

  describe '#release_bike' do
    it 'releases a bike' do
      allow(bike).to receive(:broken?).and_return(false)
      dockingstation.dock(bike)
      expect(dockingstation.release_bike).to eq bike
    end

    it 'raises an error when there are no bikes available' do
      expect { dockingstation.release_bike }.to raise_error 'No bikes available'
    end

    it 'responds to release_bike' do
      expect(dockingstation).to respond_to :release_bike
    end

    it 'will not release broken bikes' do
      allow(bike).to receive(:broken?).and_return(true)
      dockingstation.dock(bike)
      expect {dockingstation.release_bike }.to raise_error 'No bikes available'
    end
  end

  describe '#dock' do
    it 'raises an error when full' do
      dockingstation.capacity.times {dockingstation.dock :bike }
      expect { dockingstation.dock :bike }.to raise_error 'Docking station is full'
    end
    # it 'releases working bikes' do
    #   bike = Bike.new
    #   subject.dock(bike)
    #   subject.release_bike
    #   expect(bike).to be_working
    # end

    it 'allows bikes to be docked' do
      bike = :bike
      expect(dockingstation.dock(bike)).to eq [bike]
    end

    it 'allows broken bikes to be docked' do
      allow(bike).to receive(:broken?).and_return(true)
      expect(dockingstation.dock(bike)).to eq [bike]

    end
  end

  describe 'initialization' do
    it 'has a variable capacity' do
      docking_station = DockingStation.new(50)
      50.times {docking_station.dock :bike }
      expect{ docking_station.dock :bike }.to raise_error 'Docking station is full'
    end
  end



  it 'has a default capacity' do
    expect(dockingstation.capacity).to eq DockingStation::DEFAULT_CAPACITY
  end



end
