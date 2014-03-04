#!/usr/bin/env ruby

require 'RubyROOT'
include RootApp

Root::TFile.open('hist.root') do |f|
  c1 = Root::TCanvas.create("c1", "canvas1", 640, 480)
  h = f.Get('hist')
  h.Draw
  h.SetLineColor(2)
  h.GetXaxis.SetTitle("values")
  h.GetXaxis.SetTitleOffset(1.2)
  h.GetXaxis.CenterTitle
  h.GetYaxis.SetTitle("counts")
  h.GetYaxis.CenterTitle
  h.GetYaxis.SetTitleOffset(1.35)
  h.SetTitle("Histogram drawn by RubyROOT")
  c1.Update
  run_app
end
