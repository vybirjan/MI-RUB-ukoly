class Graph
  
  attr_reader :nodes, :queries
  
  def initialize(num_n)
    @nodes = Array.new()
    1.upto(num_n) { |i|
      nodes[i] = Node.new(i)
    }
    @queries = Array.new()
  end
end

class Node
  attr_reader :neighbors, :number, :state
  attr_writer :state
  
  def initialize(num)
    @number = num
    @neighbors = Array.new()
    @state = :fresh
  end
end

class Query
  
  attr_reader :startNode, :type
  
  def initialize(startNode, type)
    @startNode = startNode;
    @type = type
  end
end

def print_graph(graph, query)
  if(query.type == 0)
    print_dfs(graph, graph.nodes[query.startNode])
  else
    print_bfs(graph, graph.nodes[query.startNode])
  end
end

def print_dfs(graph, startNode)
  #initialize states
  1.upto(graph.nodes.length - 1) {|i|
    graph.nodes[i].state = :fresh
  }
  
  print_dfs_x(startNode)
  
end

def print_dfs_x(node)
  if(node.state == :fresh) 
    print node.number.to_s + " "
    node.state = :open
    
    node.neighbors.each{|neighbor|
      print_dfs_x(neighbor)
    }
    
    node.state = :closed
  end
end

def print_bfs(graph, startNode)
   1.upto(graph.nodes.length - 1) {|i|
     graph.nodes[i].state = :fresh
   }
   
   stack = Array.new
   startNode.state = :open
   stack.push(startNode)
   
   while(not stack.empty?)
     node = stack.pop()
     
     node.neighbors.each {|neighbor|
       if(neighbor.state == :fresh)
         neighbor.state = :open
         stack.insert(0, neighbor)
       end
     }
     node.state = :closed
     print node.number.to_s + " "
   end
end

graphs = Array.new



#read number of graphs
numOfGraphs = STDIN.gets.to_i

numOfGraphs.times {|g|
  numOfNodes = STDIN.gets.to_i
  #create new graph
  graphs[g] = Graph.new(numOfNodes)
  
  #add nodes to graph
  numOfNodes.times {|node|
    line = STDIN.gets.split(" ")
    nodeNum = line[0].to_i
    currentNode = graphs[g].nodes[nodeNum]
    numOfNeighbors = line[1].to_i
    
    numOfNeighbors.times {|i|
      neighborNum = line[i + 2].to_i
      currentNode.neighbors[i] = graphs[g].nodes[neighborNum]
    }
  }
  
  #read queries for current graph
  i = 0
  while(true)
    line = STDIN.gets.split(" ")
    #stop at line 0 0
    if(line[0].eql?("0") & line[1].eql?("0"))
      break
    end 
    graphs[g].queries[i] = Query.new(line[0].to_i, line[1].to_i)
    i = i + 1
  end
}


grNum = 1
graphs.each{|graph|
  print "graph " + grNum.to_s + "\n"
  graph.queries.each {|query|
    print_graph(graph,query)
    print "\n"
  }
  
  grNum  = grNum + 1
}

