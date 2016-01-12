require 'docking_station'
require 'pry'

describe DockingStation do

  describe '#release_bike' do
    it 'releases a bike' do
      bike = Bike.new
      subject.dock(bike)
      expect(subject.release_bike).to eq bike
    end

    it 'raises an error when there are no bikes available' do
      expect { subject.release_bike }.to raise_error 'No bikes available'
    end

    it 'responds to release_bike' do
      expect(subject).to respond_to :release_bike
    end
  end


  describe '#dock' do
    it 'raises an error when full' do
      subject.capacity.times {subject.dock Bike.new }
      expect { subject.dock Bike.new }.to raise_error 'Docking station is full'
    end
    it 'releases working bikes' do
      bike = Bike.new
      subject.dock(bike)
      subject.release_bike
      expect(bike).to be_working
    end

    it 'allows bikes to be docked' do
      bike = Bike.new
      expect(subject.dock(bike)).to eq [bike]
    end
  end

  describe 'initialization' do
    it 'has a variable capacity' do
      docking_station = DockingStation.new(50)
      50.times {docking_station.dock Bike.new }
      expect{ docking_station.dock Bike.new }.to raise_error 'Docking station is full'
    end
  end

  it 'has a default capacity' do
    expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY

  end



end
