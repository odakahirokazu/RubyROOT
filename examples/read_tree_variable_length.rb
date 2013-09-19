#!/usr/bin/env ruby

require 'RubyROOT'

Root::TFile.open("var_tree.root") do |f|
  tree = f.Get("tree")
  tree.read.each do |row|
    puts "Event %d => %d hits" % [row.event_id, row.num]
    puts row.energy
    puts ""
  end
end
