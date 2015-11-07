#!/usr/bin/env ruby

require 'RubyROOT'
require 'json'

info = {
  Detector: { detector_id: 100, size: 5.12, comment: "Very good" },
  Source: { position: 3.2, energy: 511.0, isotope: "Na22" }
}

Root::TFile.open("json.root", "RECREATE") do |tf|
  info.each do |module_name, params|
    dir = tf.mkdir(module_name.to_s)
    dir.cd
    j = params.to_json
    puts j
    v = Root::TObjString.new(j)
    v.Write
  end
end
