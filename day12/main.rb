class Node
  attr_accessor :val, :neighbors

  def initialize(val)
    @val = val
    @neighbors = []
  end

  def add_neighbor(n)
    @neighbors << n
    self
  end

  def to_s
    "#{self.val} -> #{@neighbors.map(&:val)}"
  end
end

class Graph
  attr_accessor :nodes
  def initialize(root)
    @nodes = Set.new(root)
  end

  def insert(node)
    nodes << node
  end
end

def cave_nav
  nodes = {}
  caves = []; File.open("input.txt").each_line do |line|
    c1, c2 = line.split("-").map(&:strip)

    if !nodes[c1]
      nodes[c1] = Node.new(c1)
    end

    if !nodes[c2]
      nodes[c2] = Node.new(c2)
    end

    nodes[c1].add_neighbor(nodes[c2])
    nodes[c2].add_neighbor(nodes[c1])
  end

  root = nodes['start']
end

puts cave_nav
