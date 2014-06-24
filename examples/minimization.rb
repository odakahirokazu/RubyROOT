#!/usr/bin/env ruby

require 'RubyROOT'

sin = lambda{|x| Math::sin(x[0]) }
minuit = Root::Minuit2FunctionMinimizer.new
minuit.SetFunctionObject sin, 1
minuit.SetLimitedVariable(0, 'x', 0, 0.01, -Math::PI, +Math::PI)
minuit.Minimize
minuit.PrintResults
x = minuit.GetParameter(0); err = minuit.GetError(0)
puts "x: %.4f +/- %.4f" % [x, err]
puts ""

minuit.Clear
x2 = lambda{|x| (x[0]-2.0)**2+(x[1]-3.0)**4 }
minuit.SetFunctionObject x2, 2
minuit.SetVariable(0, 'x', 0, 0.001)
minuit.SetVariable(1, 'y', 0, 0.001)
minuit.Minimize
minuit.PrintResults
puts ""

minuit.Clear
f1 = lambda{|x, y| x**2+(y-2)**2 }
minuit.function(f1)
minuit.SetVariable(0, 'x', 0, 0.001)
minuit.SetVariable(1, 'y', 0, 0.001)
minuit.Minimize
minuit.PrintResults
puts ""

minuit.Clear
minuit.function do |x, y, z|
  (x-2.0)**2 ++ (y-3.0)**4 + (z-2.5)**2
end
minuit.SetVariable(0, 'x', 0.0, 0.0001)
minuit.SetVariable(1, 'y', 0.0, 0.0001)
minuit.SetVariable(2, 'z', 0.0, 0.0001)
minuit.Minimize
minuit.PrintResults
puts ""
