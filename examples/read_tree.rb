#!/usr/bin/env ruby

require 'RubyROOT'
include Root

TFile.open("data.root") do |f|
  tree = f.Get("tree")
  tree.read.each do |t|
    puts "%4d  %6.1f  %6.1f" % [t.event_id, t.position, t.energy]
  end
end
