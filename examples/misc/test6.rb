#!/usr/bin/env ruby

require 'RubyROOT'
include Root

TFile.open("test5.root") do |f|
  tree = f.Get("tree")
  tree.SetDirectory gDirectory
  io = TreeIOHelper.new(tree)
  io.register_branch("eventid", "I")
  io.register_branch("energy", "D")
  io.set_branches

  tree.GetEntries.times do |i|
    tree.GetEntry i
    puts io.get_value_I("eventid")
    puts io.get_value_D("energy")
  end
end
