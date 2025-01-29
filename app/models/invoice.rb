class Invoice < ApplicationRecord
  before_save :cal_total
  has_one_attached :pdf
  after_create_commit :enqueue_pdf_generation

  private

  def enqueue_pdf_generation
    GenerateInvoicePdfJob.perform_later(self.id)
  end

  def cal_total
    self.total = price * quantity
  end
end
