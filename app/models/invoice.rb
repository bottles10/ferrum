class Invoice < ApplicationRecord

  before_save :cal_total


  private

  def cal_total
    self.total = price * quantity
  end
end
