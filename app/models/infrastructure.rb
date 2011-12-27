class Infrastructure < ActiveRecord::Base
  acts_as_tree
  has_many :nodes
  
  def self.find_by_name(name)
    find(:all, :conditions=>["label=?",name]).first
  end

  def self.all_branches
    find(:all, :conditions=>["id > 1"])
  end
end
