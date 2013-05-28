#!/usr/bin/env ruby

require 'RubyROOT'

Root::TFile.open("tree_basic.root", "RECREATE") do
  tree = Root::TTree.create("tree", "tree")
  io = Root::TreeIOHelper.new(tree)
  
  io.register_branch("eventid", "I")
  io.register_branch("energy", "D")
  io.construct_branches
  
  l = [120.0, 23.4, 45.0, 567.0, 32.0]
  l.each_with_index do |v, i|
    io.set_value_I("eventid", i)
    io.set_value_D("energy", v)
    tree.Fill
  end

  tree.GetEntries.times{|i| tree.Show i }
  
  tree.Write
end
