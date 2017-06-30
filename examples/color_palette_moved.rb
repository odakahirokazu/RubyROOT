#!/usr/bin/env ruby

require 'RubyROOT'
include RootApp

Root::gStyle.SetOptStat(0)

Root::gStyle.set_palette 'cool'
c1 = Root::TCanvas.create_square()
n = 64
size = 20.0
hsize = 0.5*size
h = Root::TH2F.create('image', 'Image', n, -hsize, +hsize, n, -hsize, +hsize)

random = Root::TRandom3.new
radii = [4.0, 8.0, 12.0]
radii.each do |radius|
  60000.times do |i|
    theta = random.Uniform(0.0, 2.0*Math::PI)
    r = random.Gaus(radius, 1.0)
    x = r * Math::cos(theta)
    y = r * Math::sin(theta)
    h.Fill(x, y)
  end
end

h.Draw 'colz'
c1.Update

# Move color palette
palette = Root::gPad.get_palette()
palette.SetX1NDC(0.7)
palette.SetY1NDC(0.5)
palette.SetX2NDC(0.9)
palette.SetY2NDC(0.9)
h.Draw 'colz'
c1.Update

run_app
