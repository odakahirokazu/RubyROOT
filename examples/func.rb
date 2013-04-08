#!/usr/bin/env ruby

require 'RubyROOT'
include Root

sin = lambda{|x, p| Math::sin(x[0]) }

ROOTApp do
  c1 = TCanvas.create("c1", "c1", 600, 400)
  f = TF1.create("func", sin, 0, 2*Math::PI, 1)
  f.Draw
  c1.Update
end
