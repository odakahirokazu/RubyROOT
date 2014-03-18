#!/usr/bin/env ruby

require 'RubyROOT'
include RootApp

### data definition
x = [1.0, 2.3, 3.1, 4.0, 5.0]
y = [1.2, 2.1, 10.2, 3.2, 4.0]
xe1 = [0.10, 0.10, 0.10, 0.07, 0.10]
xe2 = [0.05, 0.05, 0.05, 0.07, 0.05]
ye1 = y.map{|z| z*0.1 }
ye2 = y.map{|z| z*0.3 }

### make a graph and draw it
graph = Root::TGraphAsymmErrors.create(x, y, xe1, xe2, ye1, ye2)
c1 = Root::TCanvas.create
graph.Draw("APL")
c1.Update
run_app
