#!/usr/bin/env ruby

require 'RubyROOT'
include RootApp

Root::TFile.open("tree.root") do |f|
  c1 = Root::TCanvas.create
  tree = f.Get("tree")
  tree.Draw('event_id', '')
  c1.Update
  run_app
end
