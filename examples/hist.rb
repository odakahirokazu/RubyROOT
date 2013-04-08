#!/usr/bin/env ruby

require 'RubyROOT'

Root::TFile.open('test.root', 'RECREATE') do
  h = Root::TH1D.create('hist', 'Histogram', 100, 0.0, 100.0)
  h.SetBinContent(12, 4.2)
  1.upto(h.GetNbinsX) {|i| h.SetBinContent(i, i*10.0) }
  1000.times {|i| h.Fill(12.5) }
  h.Write
end
