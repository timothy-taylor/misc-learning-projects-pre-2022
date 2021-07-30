# frozen_string_literal = true

class LinkedList
  include Enumerable

  attr_reader :start, :end

  def initialize
    @start = nil
    @end = nil
  end

  def each
    return nil if @start.nil?
    node = @start
    until node.nil?
      yield node
      node = node.next
    end
  end
 
  def prepend(node)
    if @start.nil?
      puts "First node added."
      @start = node
      @end = node
    else
      puts "Prepending..."
      node.next = @start
      @start = node
    end
  end

  def append(node)
    if @start.nil?
      puts "First node added."
      @start = node
      @end = node
    else
      puts "Appending..."
      @end.next = node
      @end = node
    end
  end

  def size
    i = 0
    self.each { |e| i += 1 }
    return i
  end
  
  def at(index)
    i = 0
    self.each { |e| 
      i += 1
    return e if i == index
    }
  end

  def shift
    return nil if @start.nil?
    puts "Shifting..."
    node = @start
    @start = @start.next
    return node
  end

  def pop
    return nil if @start.nil?
    puts "Popping..."
    node = @end
    @end = at( size - 1 )
    @end.next = nil
    return node
  end
 
  def contains?(value)
    contains = false
    self.each{ |e| contains = true if e.value == value }
    return contains
  end

  def find(value)
    unless contains?(value)
      return nil
    else
      i = 0
      self.each{ |e|
        return i if e.value == value
        i += 1
      }
    end
  end

  def to_s
    self.each { |e|
      print "( #{e.value} ) -> "
      puts "nil" if e.next.nil?
    }
  end

  def insert_at(value, index)
    return nil if @start.nil?
    puts "Inserting at index #{index}..."
    old_node = at(index)
    new_node = Node.new(value)
    new_node.next = old_node.next
    old_node.next = new_node
  end

  def remove_at(index)
    return nil if @start.nil? || at(index).nil?
    puts "Removing index #{index}..."
    current_node = at(index)
    prev_node = at(index - 1)
    next_node = current_node.next
    prev_node.next = next_node
    current_node = nil
  end
end

class Node
  attr_accessor :value, :next

  def initialize(value)
    @value = value
    @next = nil
  end
end

# bunch of tests
list = LinkedList.new
item = 523
item2 = 999
list.append(Node.new(rand(100)))
list.prepend(Node.new(rand(100)))
puts "Current list start is #{list.start}."
puts "Current list size is #{list.size}."
list.prepend(Node.new(rand(111)))
puts "Current list start is #{list.start}."
puts "Current list end is #{list.end}."
puts "Current list size is #{list.size}."
puts "#{list.at(3)} is at index 3."
list.to_s
list.pop
list.shift
list.to_s
puts "Current list size is #{list.size}."
puts "Does the list contain the item? #{list.contains?(item)}."
list.append(Node.new(item))
puts "Does the list contain the item? #{list.contains?(item)}."
list.append(Node.new(rand(100)))
list.append(Node.new(rand(100)))
list.prepend(Node.new(rand(100)))
puts "Item was found at index #{list.find(item)}."
list.to_s
list.pop
list.to_s
list.append(Node.new(rand(100)))
list.append(Node.new(rand(100)))
puts "Current list end is #{list.end}."
list.insert_at(item2, list.size - 3 )
puts "Item was found at index #{list.find(item2)}."
list.to_s
list.remove_at(3)
list.to_s
