# frozen_string_literal : true

class Node
  attr_accessor :data, :left_child, :right_child

  def initialize(data)
    @data = data
    @left_child = nil
    @right_child = nil
  end
end

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array.uniq.sort)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

  def build_tree(array)
    return nil if array[0] >= array[-1]
    middle = array.length / 2
    root = Node.new(array[middle])
    root.left_child = build_tree(array.slice(0...middle))
    root.right_child = build_tree(array.slice(middle..array.length))
    return root
  end

  def insert(value, node = @root)
    return puts "...value already exists..." if value_exists?(value, node)
    return Node.new(value) if node.nil?
    if value < node.data 
      node.left_child = insert(value, node.left_child)
    elsif value > node.data
      node.right_child = insert(value, node.right_child)
    end
    return node
  end

  def value_exists?(value, root_node = @root)
    node = find(value, root_node)
    if node.nil?
      return false
    else
      return true
    end
  end

  def delete(value, node = @root)
    return puts "...value could not be found..." if !value_exists?(value, node) 
    return node if node.nil?
    if value < node.data
      node.left_child = delete(value, node.left_child)
    elsif value > node.data
      node.right_child = delete(value, node.right_child)
    else
      if node.left_child.nil?
        temp = node.right_child
        node = nil
        return temp
      elsif node.right_child.nil?
        temp = node.left_child
        node = nil
        return temp
      else
        temp = min_value_leaf(node.right_child)
        node.data = temp.data
        node.right_child = delete(temp.data, node.right_child)
      end
    end
    return node
  end

  def min_value_leaf(starting_node = @root)
    node = starting_node
    while node && node.left_child != nil 
      node = node.left_child
    end
    return node
  end

  def find(value, node = @root)
    begin
      if value == node.data
        return node
      elsif value < node.data
        find(value, node.left_child)
      elsif value > node.data
        find(value, node.right_child)
      end
    rescue
      return nil
    end
  end

  def traverse_level_order(node, array = [], queue = [])
    array.push(node.data) unless node.nil?
    queue.push(node.left_child) unless node.left_child.nil?
    queue.push(node.right_child) unless node.right_child.nil?
    traverse_level_order(queue.shift, array, queue) unless queue.empty?
    return array
  end

  def traverse_in_order(node, array = [])
    return if node.nil?
    traverse_in_order(node.left_child, array)
    array.push(node.data)
    traverse_in_order(node.right_child, array)
    return array
  end

  def traverse_preorder(node, array = [])
    return if node.nil?
    array.push(node.data)
    traverse_preorder(node.left_child, array)
    traverse_preorder(node.right_child, array)
    return array
  end
  
  def traverse_postorder(node, array = [])
    return if node.nil?
    traverse_preorder(node.left_child, array)
    traverse_preorder(node.right_child, array)
    array.push(node.data)
    return array
  end

  def find_height(node)
    return -1 if node.nil?
    left_height = find_height(node.left_child)
    right_height = find_height(node.right_child)
    return left_height > right_height ? left_height + 1 : right_height + 1
  end

  def find_depth(node, root = @root)
    return 0 if root.nil? || root == node
    return 1 if node == root.left_child || node == root.right_child 
    left_depth = find_depth(node, root.left_child)
    right_depth = find_depth(node, root.right_child)
    return left_depth < right_depth ? left_depth + 1 : right_depth + 1
  end

  def balanced?
    left_height = find_height(@root.left_child)
    right_height = find_height(@root.right_child)
    return (left_height - right_height).abs <= 1 ? true : false
  end

  def rebalance
    array = traverse_in_order(@root)
    @root = build_tree(array)
    puts "...rebalancing tree..."
  end
end

bst = Tree.new(Array.new(15) { rand(1..100) } )
puts "Level order: #{bst.traverse_level_order(bst.root)}"
puts "In order: #{bst.traverse_in_order(bst.root)}"
puts "Preorder: #{bst.traverse_preorder(bst.root)}"
puts "Postorder: #{bst.traverse_postorder(bst.root)}"
bst.pretty_print
puts "Tree balanced: #{bst.balanced?}"
7.times do 
  bst.insert(rand(40))
end
bst.pretty_print
puts "Tree balanced: #{bst.balanced?}"
bst.rebalance
puts "Tree balanced: #{bst.balanced?}"
bst.pretty_print
puts "Level order: #{bst.traverse_level_order(bst.root)}"
puts "In order: #{bst.traverse_in_order(bst.root)}"
puts "Preorder: #{bst.traverse_preorder(bst.root)}"
puts "Postorder: #{bst.traverse_postorder(bst.root)}"
