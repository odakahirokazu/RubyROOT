#!/usr/bin/env ruby

require 'RubyROOT'

info = {
  Detector: { detector_id: 100, size: 5.12, comment: "Very good" },
  Source: { position: 3.2, energy: 511.0, isotope: "Na22" }
}

Root::TFile.open("parameters.root", "RECREATE") do |tf|
  info.each do |module_name, params|
    dir = tf.mkdir(module_name.to_s)
    dir.cd
    tree = Root::TTree.create("parameters", "Parameters")
    parameters_definition = {}
    params.each do |k, v|
      shape =
        if v.is_a? String
          len = v.size
          "C[#{len+1}]"
        elsif v.is_a? Integer
          "I"
        elsif v.is_a? Numeric
          "F"
        else
          raise "Not supported type: #{v.class.to_s}"
          nil
        end
      parameters_definition[k] = shape
    end
    puts "Tree \"#{dir.GetName}/#{tree.GetName}\" definition:"
    p parameters_definition
    row = tree.define(**parameters_definition)
    params.each do |k, v|
      row[k] = v
    end
    tree.Fill
    tree.Write
    tree.Show(0)
    puts ''
  end
end
