#!/usr/bin/env ruby

require 'RubyROOT'
require 'json'

Root::TFile.open("json.root") do |tf|
  tf.GetListOfKeys.each do |dir_key|
    module_name = dir_key.GetName
    dir = tf.GetDirectory(module_name)
    dir.GetListOfKeys.each do |o|
      json = o.GetName
      puts "Module: #{module_name}"
      p JSON.parse(json)
    end
  end
end
