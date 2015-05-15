#!/usr/bin/env ruby

require 'RubyROOT'
include Root
include RootApp

filename = ARGV[0]
xs = []
ys = []

File::open(filename) do |fin|
  fin.each_line do |line|
    next if line[0] == '#'
    data = line.strip.split(/\s+/).map(&:to_f)
    xs << data[0]
    ys << data[1]
  end
end

c1 = TCanvas.create
graph = TGraph.create(xs, ys)
graph.Draw("APL")
c1.Update

run_app
