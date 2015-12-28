class Project < ActiveRecord::Base
  attr_accessor :tasks

  def initialize
    @tasks = []
  end

  def incompleted_tasks
    tasks.reject(&:completed?)
  end

  def done?
    incompleted_tasks.empty?
  end

  def total_size
    tasks.sum(&:size)
  end

  def remaning_size
    tincompleted_tasks.sum(&:size)
  end

end
