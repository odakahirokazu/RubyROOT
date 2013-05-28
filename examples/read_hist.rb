#!/usr/bin/env ruby

require 'RubyROOT'

Root::TFile.open('hist.root') do |f|
  h = f.Get('hist')
  for i in 1..h.GetNbinsX
    puts "%4d %6.1f" % [i, h.GetBinContent(i)]
  end
end
