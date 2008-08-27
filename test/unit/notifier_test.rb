require File.dirname(__FILE__) + '/../test_helper'

class NotifierTest < ActionMailer::TestCase
  tests Notifier
  def test_confirm
    @expected.subject = 'Notifier#confirm'
    @expected.body    = read_fixture('confirm')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Notifier.create_confirm(@expected.date).encoded
  end

  def test_sent
    @expected.subject = 'Notifier#sent'
    @expected.body    = read_fixture('sent')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Notifier.create_sent(@expected.date).encoded
  end

end
