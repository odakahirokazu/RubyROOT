#!/usr/bin/env ruby

require 'RubyROOT'
include RootApp

c1 = Root::TCanvas.create("c1", "c1", 600, 400)

### extend acos(x)
acos_extended = Root::func{|x|
  n = ((x+1.0)/2.0)
  cycle = (n>0.0) ? n.to_i : -(n.abs.to_i)-1
  Math::acos(x-cycle*2.0)-Math::PI*cycle
}
f = Root::TF1.create("func", acos_extended, -5.0, 5.0, 1)
f.Draw

### normal acos(x)
f2 = Root::TF1.new("func2", "acos(x)", -1.0, 1.0)
f2.Draw("same")
f2.SetLineColor(4)

c1.Update
run_app
