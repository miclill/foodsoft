class Invoice < ActiveRecord::Base

  belongs_to :supplier, :with_deleted => true
  belongs_to :delivery
  belongs_to :order

  validates_presence_of :supplier_id
  validates_numericality_of :amount, :deposit, :deposit_credit

  scope :unpaid, :conditions => { :paid_on => nil }

  # Replace numeric seperator with database format
  localize_input_of :amount, :deposit, :deposit_credit

  # Amount without deposit
  def net_amount
    amount - deposit + deposit_credit
  end
end


