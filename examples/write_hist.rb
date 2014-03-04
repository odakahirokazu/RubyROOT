#!/usr/bin/env ruby

require 'RubyROOT'

Root::TFile.open('hist.root', 'RECREATE') do
  h = Root::TH1D.create('hist', 'Histogram', 100, -5.0, 5.0)
  1.upto(h.GetNbinsX){|i| h.SetBinContent(i, i*4.0) }
  h.SetBinContent(32, 547.2)
  h.FillRandom("gaus", 15000)
  h.Write
end
