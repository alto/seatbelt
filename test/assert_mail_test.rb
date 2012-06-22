require 'test_helper'

class Seatbelt::AssertMailTest < Test::Unit::TestCase

  def test_assert_mail
    Mailer.test.deliver

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
    Mailer.test.deliver

    assert_assertion_fails { assert_mail :to => 'unknown@seatbelt.co.nz' }
    assert_assertion_fails { assert_mail :cc => 'unknown@seatbelt.co.nz' }
    assert_assertion_fails { assert_mail :bcc => 'unknown@seatbelt.co.nz' }
    assert_assertion_fails { assert_mail :from => 'unknown@seatbelt.co.nz' }
    assert_assertion_fails { assert_mail :subject => 'unknown' }
    assert_assertion_fails { assert_mail :body => 'unknown' }
    assert_assertion_fails { assert_mail :to => 'unknown@seatbelt.co.nz', :subject => 'unknown', :body => 'unknown' }
  end

  def test_assert_mail_with_multiple_mails
    Mailer.test.deliver
    Mailer.test(:to => 'another@seatbelt.co.nz').deliver

    assert_mail :to => 'test@seatbelt.co.nz'
    assert_mail :to => 'another@seatbelt.co.nz'
  end

  def test_assert_mail_with_block
    assert_mail :to => 'test@seatbelt.co.nz', :subject => /subject/, :body => 'body' do
      Mailer.test.deliver
    end
  end
  def test_assert_mail_with_block_crosscheck
    assert_assertion_fails do
      assert_mail :to => 'unknown@seatbelt.co.nz' do
        Mailer.test.deliver
      end
    end
  end

  def test_assert_no_mail
    assert_no_mail do
      # do something
      abc = 1 + 1
    end

    assert_no_mail :to => 'another@seatbelt.co.nz' do
      Mailer.test.deliver
    end
    assert_no_mail :subject => 'my other subject' do
      Mailer.test.deliver
    end
    assert_no_mail :body => 'my other body text' do
      Mailer.test.deliver
    end
  end

  def test_assert_no_mail_crosscheck
    assert_assertion_fails do
      assert_no_mail :to => 'test@seatbelt.co.nz' do
        Mailer.test.deliver
      end
    end
  end

end
