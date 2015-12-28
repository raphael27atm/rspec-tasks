require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "initialize" do
    let(:task) {Task.new}

    it 'can distinguish a completed task' do
      expect(task).not_to be_complete
      task.marke_completed
      expect(task).to be_complete
    end
  end

  describe "velocity" do
    let(:task) {Task.new(size: 3)}

    it 'does not count an incomplete task toward velocity' do
      expect(task).not_to be_part_of_velocity
      expect(task.point_toward_velocity).to eq(0)
    end

    it 'does not count a long-ago task toward velocity' do
      task.marke_completed(6.months.ago)
      expect(task).not_to be_part_of_velocity
      expect(task.point_toward_velocity).to eq(0)
    end

    it 'counts a recenty completd task toward velocity' do
       task.marke_completed(1.day.ago)
       expect(task).to be_part_of_velocity
       expect(task.point_toward_velocity).to eq(3)
    end
  end
end
