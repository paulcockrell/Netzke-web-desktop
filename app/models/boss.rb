class Boss < ActiveRecord::Base
  has_many :clerks

  def name
    "#{first_name} #{last_name}"
  end

end
