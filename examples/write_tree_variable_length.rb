#!/usr/bin/env ruby

require 'RubyROOT'

Root::TFile.open("var_tree.root", "RECREATE") do
  tree = Root::TTree.create("tree", "tree")
  row = tree.define(event_id: 'I',
                    num: 'I',
                    energy: 'D[num=256]') # type[lengthLeaf=bufferSize]

  num_events = 1000
  max_hits = 100
  num_events.times do |i|
    num_hits = Random.rand(max_hits)
    energies = []
    num_hits.times { energies << Random.rand(0.0..600.0) }
    
    row.event_id = i
    row.num = num_hits
    row.energy = energies
    tree.Fill
  end

  tree.Write
end
