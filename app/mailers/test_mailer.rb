class TestMailer < ApplicationMailer

  def header_test(header)
    @header = header
    mail(to: "maxx1128@gmail.com", subject: "This is the test email!")
  end
end
