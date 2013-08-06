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

MiniTest::Test.send(:include, Stubber)

class StubberTest < MiniTest::Test

  def setup
    @object = Class.new
  end

  def test_stub_a_new_method
    stub(@object, :james => "brown")

    assert_equal @object.james, "brown"
  end

  def test_stub_several_methods_for_an_object
    stub(@object, :sly => "stone", :birth => 1943)

    assert_equal @object.sly, "stone"
    assert_equal @object.birth, 1943
  end

end
