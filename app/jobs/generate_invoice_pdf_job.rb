class GenerateInvoicePdfJob < ApplicationJob
  queue_as :default

  def perform(invoice_id)
    invoice = Invoice.find(invoice_id)
    return unless invoice

    url = Rails.application.routes.url_helpers.invoice_url(invoice)
    tmp = Tempfile.new
    browser = Ferrum::Browser.new

    begin
      browser.go_to(url)
      sleep(0.3) # Allow time for rendering
      browser.pdf(path: tmp.path)
    ensure
      browser.quit
    end

    invoice.pdf.attach(io: File.open(tmp.path), filename: "invoice_#{invoice.id}.pdf")
    tmp.close
    tmp.unlink
  end
end
