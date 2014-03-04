#!/usr/bin/env ruby

require 'RubyROOT'
include RootApp

sin = lambda{|x, p| Math::sin(x[0]) }

c1 = Root::TCanvas.create("c1", "c1", 600, 400)
f = Root::TF1.create("func", sin, 0, 2*Math::PI, 1)
f.Draw
c1.Update

run_app
