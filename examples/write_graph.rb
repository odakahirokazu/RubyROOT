#!/usr/bin/env ruby

require 'RubyROOT'

### data definition
x = [1.0, 2.3, 3.1, 4.0, 5.0]
y = [1.2, 2.1, 10.2, 3.2, 4.0]
xe = [0.05, 0.05, 0.05, 0.07, 0.05]
ye = y.map{|z| z*0.2 }

### make a graph and save it
f = Root::TFile.open("graph.root", "RECREATE")
graph = Root::TGraphErrors.create(x, y, xe, ye)
graph.SetName("graph1")
graph.SetTitle("graph with error bars")
f.Write
f.Close
