require 'test_helper'

class Seatbelt::AssertMailTest < Minitest::Test

  def test_assert_mail
    deliver

    assert_mail :to => 'test@seatbelt.co.nz'
    assert_mail :cc => 'cc@seatbelt.co.nz'
    assert_mail :bcc => 'bcc@seatbelt.co.nz'
    assert_mail :from => 'from@seatbelt.co.nz'
    assert_mail :subject => 'mail subject'
    assert_mail :subject => /subject/
    assert_mail :body => 'mail body text'
    assert_mail :body => /body text/
    assert_mail :body => ['mail body', 'body text']

    assert_mail :to => 'test@seatbelt.co.nz', :subject => /subject/, :body => 'body'
  end
  def test_assert_mail_crosscheck
    deliver

    assert_assertion_fails { assert_mail :to => 'unknown@seatbelt.co.nz' }
    assert_assertion_fails { assert_mail :cc => 'unknown@seatbelt.co.nz' }
    assert_assertion_fails { assert_mail :bcc => 'unknown@seatbelt.co.nz' }
    assert_assertion_fails { assert_mail :from => 'unknown@seatbelt.co.nz' }
    assert_assertion_fails { assert_mail :subject => 'unknown' }
    assert_assertion_fails { assert_mail :body => 'unknown' }
    assert_assertion_fails { assert_mail :to => 'unknown@seatbelt.co.nz', :subject => 'unknown', :body => 'unknown' }
  end

  def test_assert_mail_with_multiple_mails
    deliver
    Mailer.test(:to => 'another@seatbelt.co.nz').deliver_now

    assert_mail :to => 'test@seatbelt.co.nz'
    assert_mail :to => 'another@seatbelt.co.nz'
  end

  def test_assert_mail_with_block
    assert_mail :to => 'test@seatbelt.co.nz', :subject => /subject/, :body => 'body' do
      deliver
    end
  end
  def test_assert_mail_with_block_crosscheck
    assert_assertion_fails do
      assert_mail :to => 'unknown@seatbelt.co.nz' do
        deliver
      end
    end
  end

  def test_assert_no_mail
    assert_no_mail do
      # do something
      abc = 1 + 1
    end

    refute_mail { 3 }

    assert_no_mail :to => 'another@seatbelt.co.nz' do
      deliver
    end
    assert_no_mail :subject => 'my other subject' do
      deliver
    end
    assert_no_mail :body => 'my other body text' do
      deliver
    end
  end

  def test_assert_no_mail_crosscheck
    assert_assertion_fails do
      assert_no_mail :to => 'test@seatbelt.co.nz' do
        deliver
      end
    end
  end

  private

  def deliver
    ActionMailer::VERSION::MAJOR > 3 ? Mailer.test.deliver_now : Mailer.test.deliver
  end

end
