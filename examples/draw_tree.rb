#!/usr/bin/env ruby

require 'RubyROOT'

Root::TFile.open("tree.root") do |f|
  c1 = Root::TCanvas.create
  tree = f.Get("tree")
  tree.Draw('event_id', '')
  c1.Update
  Root::wait_root true
end
