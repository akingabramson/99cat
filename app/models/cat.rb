class Cat < ActiveRecord::Base
  attr_accessible :age, :birth_date, :color, :name, :sex
  validates :color, :inclusion => { :in => %w(brown black orange),
    :message => "not a valid color"}

  has_many :cat_rental_requests, :dependent => :destroy

end
