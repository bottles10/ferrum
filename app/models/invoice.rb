class Invoice < ApplicationRecord

  before_save :cal_total
  has_one_attached :pdf
  after_create_commit :generate_pdf

  private

  def generate_pdf
    url = Rails.application.routes.url_helpers.invoice_url(self)
    tmp = Tempfile.new(process_timeout: 30, timeout: 200, pending_connection_errors: true)
    browser = Ferrum::Browser.new
    browser.go_to(url)
    sleep(0.3)
    browser.pdf(path: tmp)
    browser.quit
    pdf.attach(io: File.open(tmp), filename: "invoice_#{id}.pdf")
  end

  def cal_total
    self.total = price * quantity
  end
end
