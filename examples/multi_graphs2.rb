#!/usr/bin/env ruby

require 'RubyROOT'
include RootApp

def make_data(seed, sigma, xs)
  r = Root::TRandom3.new(seed)
  xs.map{|x| r.Gaus(Math.sin(x), sigma) }
end

### data definition
xs = (0..100).map{|i| 0.1*i }
ys1 = make_data(1, 0.05, xs)
ys2 = make_data(2, 0.2, xs)

### make a graph and draw it
curve = Root::TF1.new("func", "sin(x)", -1.0, 11.0)
graph1 = Root::TGraph.create(xs, ys1)
graph2 = Root::TGraph.create(xs, ys2)

graph1.SetMarkerStyle 2
graph2.SetMarkerStyle 4
graph1.SetMarkerColor Root::KBlue
graph2.SetMarkerColor Root::KGreen+1

### add graph1 and graph2 to a TMultiGraph
multi = Root::TMultiGraph.create
[graph1,graph2].each{ |graph| multi.Add graph }

mg = Root::MultiGraph.new
mg.add(curve, '', 'Function', [-1.5, 1.5])
mg.add(multi, 'AP', 'Graphs 1 and 2', [-1.5, 1.5])

c1 = mg.draw('c1', 800, 200)
mg.setXRange(-1.0, 11.0, 'x')

c1.Update
run_app
