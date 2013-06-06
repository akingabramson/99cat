class CatRentalRequest < ActiveRecord::Base
  attr_accessible :begin_date, :cat_id, :end_date, :status


  validates :begin_date, :presence => true  
  validates :end_date, :presence => true
  validates :cat_id, {:presence => true}
  validate :in_cats?
  validate :date_valid?

  belongs_to :cat

# CatRentalRequest.new(:begin_date => "2010-02-24", :end_date => "2012-02-25", :cat_id => 3)


  def approve
    self.status = "approved"
    self.save

    start_d, end_d = DateTime.parse(begin_date.to_s), DateTime.parse(end_date.to_s)

    other_requests = CatRentalRequest.where(:cat_id => cat_id).where("id != ?", id).all
    other_requests.each do |request|
      b_date, e_date = parse_dates(request.begin_date, request.end_date)

      if (b_date..e_date).any?{|d| (start_d..end_d).include?(d)}
        CatRentalRequest.find(request.id).update_attributes(:status => "denied")
        CatRentalRequest.find(request.id).save!(:validate => false)
      end
    end
  end

  def date_valid?

    start_d, end_d = parse_dates(begin_date, end_date)

    if start_d > end_d
      p "GOT HERE NOT VALID RANGE"
      errors.add(:begin_date, "not valid range")
    end

    other_dates = CatRentalRequest.select("begin_date, end_date, status")
                                  .where(:cat_id => cat_id, :status => "approved").where("id != ?", id).all

    return unless other_dates
    other_dates.each do |date|
      p "GOT HERE"
      b_date, e_date = parse_dates(date.begin_date, date.end_date)
      if (b_date..e_date).any?{|d| (start_d..end_d).include?(d)}
        errors.add(:begin_date, "already booked")
      end
    end
    true
  end


  def parse_dates(first_date, last_date)
    [DateTime.parse(first_date.to_s), DateTime.parse(last_date.to_s)]
  end

  def in_cats?
    exists = Cat.where(:id => cat_id)
    if exists.empty?
      errors.add(:cat_id, "not in valid cats")
      return false
    else
      true
    end
  end



end
