#!/usr/bin/env ruby

require 'RubyROOT'

random = Root::TRandom3.new

Root::TFile.open("tree.root", "RECREATE") do
  tree = Root::TTree.create("tree", "tree")
  row = tree.define(event_id: 'I', position: 'F', energy: 'F')
  10.times do |i|
    row["event_id"] = i+1
    row["position"] = random.Uniform(-12.8, +12.8)
    row["energy"] = random.Gaus(511.0, 2.5)
    tree.Fill
  end
  tree.GetEntries.times{|i| tree.Show i }
  tree.Write
end
