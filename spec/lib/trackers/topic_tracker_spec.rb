require 'visitors_counter/trackers/topic_tracker'

RSpec.describe VisitorsCounter::Trackers::TopicTracker do
  let(:valid_instance) { described_class.new(1) }
  describe '#initialize' do
    it 'requires an integer as topic_id parameters' do
      expect {
        described_class.new
      }.to raise_error(ArgumentError)

      expect {
        described_class.new(1)
      }.to_not raise_error
    end
  end

  describe '#valid?' do
    it 'returns true if topic_id is positive integer' do
      valid_instance.topic_id = rand(1000)
      expect(valid_instance.valid?).to be_truthy

      [0, -3, '-2'].each do |i|
        valid_instance.topic_id = i
        expect(valid_instance.valid?).to be_falsey
      end
    end
  end
end
