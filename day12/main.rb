class Node
  attr_accessor :val, :neighbors

  def initialize(val)
    @val = val
    @neighbors = []
  end

  def add_neighbor(n)
    @neighbors << n
  end

  def small_cave?
    return false if end?
    @val.downcase == @val
  end

  def end?
    @val == "end"
  end

  def start?
    @val == "start"
  end
end

def cave_nav
  nodes = {}
  File.open("input.txt").each_line do |line|
    c1, c2 = line.split("-").map(&:strip)

    nodes[c1] = Node.new(c1) if !nodes[c1]
    nodes[c2] = Node.new(c2) if !nodes[c2]

    nodes[c1].add_neighbor(nodes[c2]) unless nodes[c2].start?
    nodes[c2].add_neighbor(nodes[c1]) unless nodes[c1].start?
  end

  paths = []

  visit_node = ->(root, path="", visited={}, revisited=false){
    if visited[root.val]
      if revisited
        return
      else
        revisited = true
      end
    end

    if root.end?
      path << root.val
      paths << path
      return
    end

    if root.small_cave?
      visited[root.val] = true
    end

    path << "#{root.val},"

    root.neighbors.each do |node|
      visit_node.call(node, path.clone, visited.clone, revisited)
    end
  }

  visit_node.call(nodes['start'])
  paths.count
end


puts cave_nav
