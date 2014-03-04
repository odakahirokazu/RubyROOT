#!/usr/bin/env ruby

require 'RubyROOT'

Root::TFile.open("tree.root") do |f|
  tree = f.Get("tree")
  tree.read.each do |t|
    puts "%4d  %7.2f  %7.2f" % [t.event_id, t.position, t.energy]
  end
end
