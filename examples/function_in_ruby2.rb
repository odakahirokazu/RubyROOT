#!/usr/bin/env ruby

require 'RubyROOT'
include RootApp

acos_extended = lambda{|xs, ps|
  x = xs[0]
  n = ((x+1.0)/2.0)
  cycle = (n>0.0) ? n.to_i : -(n.abs.to_i)-1
  Math::acos(x-cycle*2.0)-Math::PI*cycle
}

c1 = Root::TCanvas.create("c1", "c1", 600, 400)
f = Root::TF1.create("func", acos_extended, -5.0, 5.0, 1)
f.Draw
c1.Update

run_app
