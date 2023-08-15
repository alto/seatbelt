ActionMailer::Base.delivery_method = :test
class Mailer < ActionMailer::Base

  def test(options={})
    mail({:from     => 'from@seatbelt.co.nz',
          :to       => 'test@seatbelt.co.nz',
          :cc       => 'cc@seatbelt.co.nz',
          :bcc      => 'bcc@seatbelt.co.nz',
          :subject  => 'mail subject'}.merge(options)) do |format|
      format.text { render :plain => options[:body] || 'mail body text' }
    end
  end

end
