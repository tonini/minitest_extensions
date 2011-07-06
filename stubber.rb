require 'minitest/autorun'

module Stubber

  def stub(method_name, options={})
    eigenclass_of(options[:for]).send(:define_method, method_name) do |*params|
      options[:returns]
    end
  end

  def eigenclass_of(obj)
    class << obj; self; end
  end

end

MiniTest::Unit::TestCase.send(:include, Stubber)

class StubberTest < MiniTest::Unit::TestCase

  def test_stub_a_new_method
    @other_class = Class.new

    stub(:james, :for => @other_class, :returns => "brown")
    assert_equal @other_class.james, "brown"
  end

end
