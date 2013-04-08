#!/usr/bin/env ruby

require 'RubyROOT'
include Root

TFile.open("data.root", "RECREATE") do
  tree = TTree.create("tree", "tree")
  row = tree.define(event_id: 'I', position: 'F', energy: 'F')
  30.times {|i|
    row.event_id = i+1
    row.position = 30.0*i
    row.energy = (10.0*i)**1.8
    tree.Fill
  }
  tree.GetEntries.times{|i| tree.Show i }
  tree.Write
end
