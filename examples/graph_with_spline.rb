#!/usr/bin/env ruby

require 'RubyROOT'
include RootApp

### data definition
x = [1.0, 2.3, 3.1, 4.0, 5.0]
y = [1.2, 2.1, 10.2, 3.2, 4.0]

### make a graph and draw it
graph = Root::TGraph.create(x, y)
c1 = Root::TCanvas.create
graph.Draw("APL")

spline = Root::TSpline3.new("spline", graph)
spline.Draw("same")

c1.Update
run_app
