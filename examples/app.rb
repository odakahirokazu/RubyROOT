#!/usr/bin/env ruby

require 'RubyROOT'
include Root

ROOTApp(run: true) do
  f = TFile.new('test.root')
  c1 = TCanvas.create("c1", "c1", 600, 400)
  h = f.Get('hist')
  h.Draw
  c1.Update
  f.Close
end
