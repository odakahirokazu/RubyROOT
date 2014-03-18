#!/usr/bin/env ruby

require 'RubyROOT'
include RootApp

c1 = Root::TCanvas.create("c1", "c1", 600, 400)
f = Root::TF1.new("func", "(x-1)^2-2", -3.0, +4.0)
puts "f(x)=#{f.Eval(0.0)} for x=0.0"
puts "f(x)=#{f.Eval(1.0)} for x=1.0"
puts "f(x)=#{f.Eval(2.0)} for x=2.0"
f.Draw
c1.Update

run_app
