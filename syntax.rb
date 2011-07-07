require 'minitest/autorun'

module Syntax

  def test(method_name, &block)
    method_name = "test_#{method_name.gsub(/\s+/,'_')}".to_sym
    raise "#{self.name}#test_#{method_name} is already defined" if method_exists?(method_name)

    block ||= lambda { skip("No test implementation ready yet..") }
    define_method(method_name, &block)
  end

  def method_exists?(name)
    true if instance_method(name)
  rescue
    false
  end

end

MiniTest::Unit::TestCase.send(:extend, Syntax)

class SyntaxTest < MiniTest::Unit::TestCase

  test "the new test method syntax" do
    warning = "fire in the hole!"

    assert_equal warning, "fire in the hole!"
  end

  test "this one should skip"

end
