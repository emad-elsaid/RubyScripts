#!/usr/bin/env ruby
# Author : Emad Elsaid (https://github.com/blazeeboy)
# 
# Output example : 
# http://imgur.com/Z1LfLn1
# 
# install ruby-graphviz then install graphviz from 
# http://graphviz.org/
require 'graphviz' # gem install ruby-graphviz --no-document

# get all constants in namespace
# then convert them from symbols
# to their objects and select 
# the classes out of them, 
# you may include modules if you wish
classes = Class.constants
                      .map { |c| Class.const_get c }
                      .select { |c| c.is_a? Class }
g = GraphViz.new( :G, :type => :digraph )

# Create nodes
nodes = Hash[classes.map {|c| [c, g.add_nodes( c.to_s )] }]
nodes.each do |klass,node|
  begin
    g.add_edges node, nodes[klass.superclass]
  rescue # do nothing
  end
end

# Generate output image
g.output( :png => "/Users/blaze/Desktop/classes_graph.png" )
# you can output PDF with small modification
g.output( :pdf => "/Users/blaze/Desktop/classes_graph.pdf" )