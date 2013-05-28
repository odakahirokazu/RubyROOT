#!/usr/bin/env ruby

require 'RubyROOT'

Root::TFile.open("tree_basic.root") do |f|
  tree = f.Get("tree")
  tree.SetDirectory Root.gDirectory
  io = Root::TreeIOHelper.new(tree)
  io.register_branch("eventid", "I")
  io.register_branch("energy", "D")
  io.set_branches

  tree.GetEntries.times do |i|
    tree.GetEntry i
    puts io.get_value_I("eventid")
    puts io.get_value_D("energy")
  end
end
