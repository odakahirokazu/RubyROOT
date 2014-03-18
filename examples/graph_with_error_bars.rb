#!/usr/bin/env ruby

require 'RubyROOT'
include RootApp

### data definition
x = [1.0, 2.3, 3.1, 4.0, 5.0]
y = [1.2, 2.1, 10.2, 3.2, 4.0]
xe = [0.05, 0.05, 0.05, 0.07, 0.05]
ye = y.map{|z| z*0.2 }

### make a graph and save it
graph = Root::TGraphErrors.create(x, y, xe, ye)
c1 = Root::TCanvas.create("c1", "c1", 600, 400)
graph.Draw("APL")
graph.SetTitle("graph with error bars")
c1.Update
run_app
