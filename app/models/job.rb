class Job < ActiveRecord::Base
  belongs_to :infrastructure

  validates_presence_of  :label
  validates_inclusion_of :success, :in => [true, false]
end
