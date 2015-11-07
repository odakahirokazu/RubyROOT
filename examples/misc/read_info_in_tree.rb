#!/usr/bin/env ruby

require 'RubyROOT'

Root::TFile.open("parameters.root") do |tf|
  tf.GetListOfKeys.each do |dir_key|
    module_name = dir_key.GetName
    puts "Module: #{module_name}"
    dir = tf.GetDirectory(module_name)
    tree = dir.Get("parameters")
    row = tree.read
    row.move_to 0
    tree.GetListOfLeaves.each do |leaf|
      name = leaf.GetName
      value = row.get(name)
      puts "#{name}: #{value}"
    end
  end
end
