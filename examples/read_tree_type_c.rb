#!/usr/bin/env ruby

require 'RubyROOT'

Root::TFile.open("tree_type_c.root") do |f|
  tree = f.Get("tree")
  tree.read.each do |t|
    puts "%4d  %s" % [t.number, t.name]
  end
end
