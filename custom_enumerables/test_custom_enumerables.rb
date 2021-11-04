# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'custom_enumerables'

class CustomEnumerableTest < MiniTest::Test
  def numbers
    [1,2,3,4,5]
  end
  def test_my_each
    assert_equal numbers.my_each{|e| puts e}, numbers.each{|e| puts e}
  end
  def test_my_each_with_index
    assert_equal numbers.my_each_with_index{|e,i| puts "#{i}:#{e}"}, 
      numbers.each_with_index{|e,i| puts "#{i}:#{e}"}
  end
  def test_my_select
    a = numbers.my_select{|e| e.odd?}
    b = numbers.select{|e| e.odd?}
    puts a
    puts b
    assert_equal a,b 
  end
  def test_my_all?
    a = numbers.my_all?{|e| e.is_a? Integer}
    b = numbers.all?{|e| e.is_a? Integer}
    puts a
    puts b
    assert_equal a,b 
  end
  def test_my_any?
    a = numbers.my_any?{|e| e.eql?(1)}
    b = numbers.any?{|e| e.eql?(1)}
    puts a
    puts b
    assert_equal a,b
  end
  def test_my_none?
    a = numbers.my_none?{|e| e.is_a? Integer}
    b = numbers.none?{|e| e.is_a? Integer}
    puts a
    puts b
    assert_equal a,b
  end
  def test_my_count_no_block
    a = numbers.my_count
    b = numbers.count
    puts a
    puts b
    assert_equal a,b
  end
  def test_my_count_with_block
    a = numbers.my_count{|e| e.odd?}
    b = numbers.count{|e| e.odd?}
    puts a
    puts b
    assert_equal a,b
  end
  def test_my_map
    a = numbers.my_map{|e| e + 1}
    b = numbers.map{|e| e + 1}
    puts a 
    puts b
    assert_equal a,b
  end
  def test_my_inject_given_initial
    a = numbers.my_inject(3){|product, e| product*e}
    b = numbers.inject(3){|product,e| product*e}
    puts a
    puts b
    assert_equal a,b
  end
  def test_my_inject_without_initial
    a = numbers.my_inject{|product, e| product*e}
    b = numbers.inject{|product,e| product*e}
    puts a
    puts b
    assert_equal a,b
  end
  def test_my_map_with_proc
    proc_a = Proc.new{|e| e + 1}
    a = numbers.my_map(proc_a)
    b = numbers.map{|e| e + 1}
    puts a
    puts b
    assert_equal a,b
  end
end
