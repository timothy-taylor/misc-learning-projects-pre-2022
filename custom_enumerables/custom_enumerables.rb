# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?
    for item in self
      yield item
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?
    i = -1
    for item in self
      yield item, i += 1
    end
  end

  def my_select
    return to_enum(:my_select) unless block_given?
    arr = []
    self.my_each{ |e| arr << e if yield(e) }
    arr
  end

  def my_all?
    return to_enum(:my_all?) unless block_given?
    a = self.my_select{ |item| yield(item) or !yield(item) }
    a.length.eql?(self.length) ? true : false
  end

  def my_any?
    return to_enum(:my_any?) unless block_given?
    any = false
    self.my_each{ |e| any = true if yield(e) }
    any
  end

  def my_none?
    return to_enum(:my_none?) unless block_given?
    none = true
    self.my_each{ |e| none = false if yield(e) }
    none
  end

  def my_count
    count = 0
    block_given? ? self.my_each{ |e| count += 1 if yield(e) } : self.my_each{ |_e| count += 1 }
    count
  end

  def my_map(proc=nil)
    arr = []
    if proc
      self.my_each{ |e| arr << proc.call(e) } 
    elsif block_given? 
      self.my_each{ |e| arr << yield(e) }
    else 
      return to_enum(:my_map)
    end
    arr
  end

  def my_inject(initial=nil)
    acc = initial ? initial : self.first
    self.my_each{ |e| acc = yield(acc,e) }
    acc
  end
end
