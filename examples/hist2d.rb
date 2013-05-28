#!/usr/bin/env ruby

require 'RubyROOT'

Root::gStyle.set_palette 'g'

c1 = Root::TCanvas.create_square
h = Root::TH2F.create('hist', 'Histogram',
                      32, -10.0, +10.0,
                      32, -10.0, +10.0)

random = Root::TRandom3.new
radius = 5.0
100.times do |i|
  theta = random.Uniform(0.0, 2.0*Math::PI)
  x = radius * Math::cos(theta)
  y = radius * Math::sin(theta)
  h.Fill(x, y)
end

h.Draw 'colz'
c1.Update

Root::wait_root true
