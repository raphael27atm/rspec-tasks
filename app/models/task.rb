class Task < ActiveRecord::Base

  attr_accessor :size, :completd_at

  def initialize(options={})
    marke_completed(options[:completd_at]) if
      options[:completd_at]
      @size = options[:size]
  end

  def marke_completed(date = nil)
    @completed_at = (date || Time.current)
  end

  def complete?
    completed_at.present?
  end

  def part_of_velocity?
    return false unless complete?
    completed_at > 3.weeks.ago
  end

  def points_toward_velocity
    if part_of_velocity? then size else 0 end
  end
end
