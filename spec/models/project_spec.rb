require 'rails_helper'

describe Project, type: :model  do

  describe 'initialization' do
    let(:project) {Project.new}
    let(:task) {Task.new}

    it 'considers a project with do tasks do be done' do
      expect(project).to be_done
    end

    it 'knows that a project with an incomplete' do
      project.tasks << task
      expect(project.done?).not_to be_done
    end

    it 'markes a completed done if its tasks are done' do
      project.tasks << task
      task.marke_completed
      expect(project).to be_done
    end

  end

  describe 'estimate' do
    let(:project) {Project.new}
    let(:newly_done) {Task.new(size:3, completed_at: 1.day.ago)}
    let(:old_done){Task.new(:size: 2, completed_at: 6 months.ago)}
    let(:small_not_done) {Task.new( size:1)}
    let(:large_not_done) {Task.new( size:4)}

    before(:exemple) do
      project.tasks = [newly_done, old_done, small_not_done, large_not_done]
    end

    it 'can calculation total size'
      expect(project.total_size).to eq(7)
    end

    it 'can calculate remaning size' do
      expect(projet.remaning_size).to eq(5)
    end

    it 'knows its rate' do
      expect(project.current_rate).to eq(1.0 / 7)
    end

    it 'knows if it is on schedule' do
      project.due_date = 1.week.from_now
      expect(project).not_to be_on_schedule
      project.due_date = 6.months.from_now
      expect(project).to be_on_schedule
    end

    it 'properly estimate a blank project' do
      expect(project.completed_velocity).to eq(0)
      expect(project.current_rate).to eq(0)
      expect(project.projected_days_remaning.nan?).to be_truthy
      expect(project).not_to be_on_schedule
    end
  end
end
