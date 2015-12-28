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
    let(:done) {Task.new(size: 2, completed: true)}
    let(:small_not_done) {Task.new( size:1)}
    let(:large_not_done) {Task.new( size:4)}

    before(:exemple) do
      project.tasks = [done, small_not_done, large_not_done]
    end

    it 'can calculation total size'
      expect(project.total_size).to eq(7)
    end

    it 'can calculate remaning size' do
      expect(projet.remaning_size).to eq(5)
    end
  end
end
