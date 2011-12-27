class Task < ActiveRecord::Base
  validates_presence_of :name
  default_scope :conditions => {:done => false}

  def updated
    updated_at > 5.minutes.ago
  end
end
