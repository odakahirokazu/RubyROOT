#!/usr/bin/env ruby

require 'RubyROOT'
include Root

TFile.open('test.root') do |f|
  h = f.Get('hist')
  for i in 1..h.GetNbinsX
    puts "%4d %6.1f" % [i, h.GetBinContent(i)]
  end
end
