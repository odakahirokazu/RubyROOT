#!/usr/bin/env ruby

require 'RubyROOT'
include Root

ROOTApp(init: true, run: false, nowait: false) do
  f = TFile.new("test4.root", "RECREATE")
  x = [100.0, 200.0, 300.0]
  y = x.map{|z|z*2}
  xe = x.map{|z|Math.sqrt(z)}
  ye = y.map{|z|Math.sqrt(z)}
  h = TGraphErrors.create(x, y, xe, ye)
  h.SetName "graph1"
  c1 = TCanvas.create("c1", "c1", 600, 400)
  h.Draw 'A*'
  h.Write
  c1.Update
  f.Write
  f.Close
end
