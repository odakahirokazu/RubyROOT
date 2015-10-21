#!/usr/bin/env ruby

require 'RubyROOT'

random = Root::TRandom3.new

Root::TFile.open("tree_type_c.root", "RECREATE") do
  tree = Root::TTree.create("tree", "tree")
  row = tree.define(number: 'I', name: 'C[12]')
  names = ["Newton", "Lagrange", "Einstein", "Dirac"]
  4.times do |i|
    row.number = i+1
    row.name = names[i]
    tree.Fill
  end
  tree.GetEntries.times{|i| tree.Show i }
  tree.Write
end
