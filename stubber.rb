require 'minitest/autorun'

module Stubber

  def stub(object, options={})
    options.each do |method_name, return_value|
      eigenclass_of(object).send(:define_method, method_name) do |*params|
        return_value
      end
    end
  end

  def eigenclass_of(obj)
    class << obj; self; end
  end

end

MiniTest::Unit::TestCase.send(:include, Stubber)

class StubberTest < MiniTest::Unit::TestCase

  def setup
    @my_class = Class.new
  end

  def test_stub_a_new_method
    stub(@my_class, :james => "brown")

    assert_equal @my_class.james, "brown"
  end

  def test_stub_several_methods_for_an_object
    stub(@my_class, :sly => "stone", :birth => 1943)

    assert_equal @my_class.sly, "stone"
    assert_equal @my_class.birth, 1943
  end

end
