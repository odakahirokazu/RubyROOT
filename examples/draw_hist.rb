#!/usr/bin/env ruby

require 'RubyROOT'
include RootApp

f = Root::TFile.new('hist.root')
c1 = Root::TCanvas.create("c1", "c1", 600, 400)
h = f.Get('hist')
h.Draw
c1.Update
wait_root true
f.Close
