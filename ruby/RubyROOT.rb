###########################################################################
#                                                                         #
#   Copyright (c) 2013 Hirokazu Odaka                                     #
#                                                                         #
#   This file is part of RubyROOT.                                        #
#                                                                         #
#   RubyROOT is free software: you can redistribute it and/or modify      #
#   it under the terms of the GNU General Public License as published by  #
#   the Free Software Foundation, either version 3 of the License, or     #
#   (at your option) any later version.                                   #
#                                                                         #
#   RubyROOT is distributed in the hope that it will be useful,           #
#   but WITHOUT ANY WARRANTY; without even the implied warranty of        #
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         #
#   GNU General Public License for more details.                          #
#                                                                         #
#   You should have received a copy of the GNU General Public License     #
#   along with RubyROOT.  If not, see <http://www.gnu.org/licenses/>.     #
#                                                                         #
###########################################################################
#                                                                         #
#   RubyROOT                                                              #
#   Author: Hirokazu Odaka                                                #
#   Date: 2013-04-01                                                      #
#                                                                         #
###########################################################################
require 'root'

module Root
  def ROOTApp(init: true, run: false, nowait: false, &block)
    app = TApplication.new("App", nil, nil) if init
    yield app if block_given?
    if run
      app.Run
    else
      say_wait() unless nowait
    end
  end

  def gDirectory(); TDirectory.CurrentDirectory(); end
  def gPad(); TVirtualPad.Pad(); end
  def gROOT(); GetROOT(); end

  def type_char(t)
    t = t.to_sym
    { :Char_t => 'B', :Short_t => 'S', :Int_t => 'I', :Long64_t => 'L',
      :UChar_t => 'b', :UShort_t => 's', :UInt_t => 'i', :ULong64_t => 'l',
      :Float_t => 'F', :Double_t => 'D', :Bool_t => 'O'}[t]
  end

  def func(&f)
    lambda {|x, p| f.(x[0]) }
  end

  class TFile
    def self.open(name, option="", &block)
      f = self.new(name, option)
      if block_given?
        yield f
        f.Close
        return nil
      else
        return f
      end
    end
  end

  module TObject::Impl
    def cast_to(class_name)
      send(:"castInto#{class_name}", self)
    end

    def auto_cast()
      cast_to(self.ClassName)
    end
  end

  module TList::Impl
    def each()
      o = self.First
      while o
        yield o
        o = self.After
      end
    end
  end

  class TList
    include Enumerable
  end

  module TObjArray::Impl
    def each()
      self.GetEntries.times do |i|
        yield self.At(i)
      end
    end
  end

  class TObjArray
    include Enumerable
  end

  module TDirectory::Impl
    def Get(name)
      obj = self.GetTObject(name).auto_cast
      obj.SetDirectory(nil) if obj.respond_to?(:SetDirectory)
      obj
    end
  end

  module TTree::Impl
    def read()
      self.SetDirectory Root::TDirectory.CurrentDirectory()
      reader = TreeIOHelper.new(self)
      self.GetListOfBranches.each do |b|
        b.auto_cast.GetListOfLeaves.each do |l|
          leaf = l.cast_to(:TLeaf)
          name = leaf.GetName
          type = type_char(leaf.GetTypeName)
          reader.register_branch(name, type)
          reader.singleton_class.send(:define_method, name.to_sym) do
            send("get_value_#{type}".to_sym, name)
          end
        end
      end
      reader.set_branches
      reader
    end
    
    def define(**branches)
      writer = TreeIOHelper.new(self)
      branches.each do |k, v|
        name = k.to_s
        type = v[0]
        if v =~ /\[(\d)\]/
          l = $1
          l = 1 if l <= 1
          writer.register_branch(name, type, l)
        else
          writer.register_branch(name, type)
        end
        writer.singleton_class.send(:define_method, "#{name}=") do |value|
          self.send("set_value_#{type}", name, value)
        end
      end
      writer.construct_branches()
      writer
    end
  end
  
  module TreeIOHelper::Impl
    def each()
      get_entries().times do |i|
        get_entry(i)
        yield self
      end
    end
  end
  
  class TreeIOHelper
    include Enumerable
  end
  
  def self.define_from_list()
    def from_list(list)
      n = list.length
      array = self.new(n)
      n.times{|i| array[i] = list[i] }
      array
    end
  end

  class IntArray
    Root::define_from_list
  end

  class DoubleArray
    Root::define_from_list
  end

  class TGraph
    def self.create(x, y)
      n = x.length
      ax = DoubleArray.from_list(x)
      ay = DoubleArray.from_list(y)
      TGraphErrors.new(x.size, ax, ay)
    end
  end

  class TGraphErrors
    def self.create(x, y, xerr=nil, yerr=nil)
      n = x.length
      ax = DoubleArray.from_list(x)
      ay = DoubleArray.from_list(y)
      if xerr
        axerr = DoubleArray.from_list(xerr)
        ayerr = DoubleArray.from_list(yerr)
        TGraphErrors.new(x.size, ax, ay, axerr, ayerr)
      else
        TGraphErrors.new(x.size, ax, ay)
      end
    end
  end
  
  class TGraphAsymmErrors
    def self.create(x, y, xerrl=nil, xerrh=nil, yerrl=nil, yerrh=nil)
      n = x.length
      ax = DoubleArray.from_list(x)
      ay = DoubleArray.from_list(y)
      if xerrl
        axerrl = DoubleArray.from_list(xerrl)
        axerrh = DoubleArray.from_list(xerrh)
        ayerrl = DoubleArray.from_list(yerrl)
        ayerrh = DoubleArray.from_list(yerrh)
        TGraphAsymmErrors.new(x.size, ax, ay, axerrl, axerrh, ayerrl, ayerrh)
      else
        TGraphAsymmErrors.new(x.size, ax, ay)
      end
    end
  end

  ### style, utility graphs

  alias gStyle getStyle

  PlotColor = [1, 2, 3, 4, 6, 7, 15]

  def set_root_style()
    gStyle.SetOptStat(0)
    gStyle.SetOptTitle(0)
    gStyle.SetDrawBorder(0)
    gStyle.SetCanvasBorderMode(0)
    gStyle.SetCanvasBorderSize(0)
    gStyle.SetCanvasColor(10)
    gStyle.SetPadBorderMode(0)
    gStyle.SetPadBorderSize(0)
    gStyle.SetPadColor(10)
    gStyle.SetFrameBorderMode(0)
    gStyle.SetFrameBorderSize(0)
    gStyle.SetFrameFillColor(10)
    gStyle.SetLabelFont(42, "XYZ")
    gStyle.SetTitleFont(42, "XYZ")
    gStyle.SetEndErrorSize(0)
  end

  def set_palette(name, reverse=false)
    num = 999
    
    if name == 'b'
      s = [0.0, 0.25, 0.5, 0.75, 1.0]
      r = [0.0, 0.0,  1.0, 1.0,  1.0]
      g = [0.0, 0.0,  0.0, 1.0,  1.0]
      b = [0.0, 1.0,  0.0, 0.0,  1.0]
    elsif name == 'heat'
      s = [0.0, 1.0/3.0, 2.0/3.0, 1.0]
      r = [0.0, 1.0,   1.0,   1.0]
      g = [0.0, 1.0/3.0, 2.0/3.0, 1.0]
      b = [0.0, 0.0,   0.0,   1.0]
    elsif name == 'cool'
      s = [0.0, 1.0/3.0, 2.0/3.0, 1.0]
      r = [0.0, 0.0,   0.0,   1.0]
      g = [0.0, 1.0/3.0, 2.0/3.0, 1.0]
      b = [0.0, 1.0,   1.0,   1.0]
    elsif name == 'red'
      s = [0.0, 1.0]
      r = [0.0, 1.0]
      g = [0.0, 0.0]
      b = [0.0, 0.0]
    elsif name == 'green'
      s = [0.0, 1.0]
      r = [0.0, 0.0]
      g = [0.0, 1.0]
      b = [0.0, 0.0]
    elsif name == 'blue'
      s = [0.0, 1.0]
      r = [0.0, 0.0]
      g = [0.0, 0.0]
      b = [0.0, 1.0]
    elsif name == 'wred'
      s = [0.0, 1.0]
      r = [1.0, 1.0]
      g = [1.0, 0.0]
      b = [1.0, 0.0]
    elsif name == 'wgreen'
      s = [0.0, 1.0]
      r = [1.0, 0.0]
      g = [1.0, 1.0]
      b = [1.0, 0.0]
    elsif name == 'wblue'
      s = [0.0, 1.0]
      r = [1.0, 0.0]
      g = [1.0, 0.0]
      b = [1.0, 1.0]
    elsif name == 'gray' || name == 'g'
      s = [0.0, 1.0]
      r = [1.0, 0.0]
      g = [1.0, 0.0]
      b = [1.0, 0.0]
    elsif name == 'rg'
      s = [0.0, 1.0]
      r = [0.0, 1.0]
      g = [0.0, 1.0]
      b = [0.0, 1.0]
    else
      return
    end
    
    if reverse
      r.reverse!
      g.reverse!
      b.reverse!
    end
    
    TColor::CreateGradientColorTable(s.length, s, r, g, b, num)
    gStyle.SetNumberContours(num)
  end
  
  class MultiGraph
    def initialize()
      @graph_list = []
      @same_graph_list = []
      @font_size = 0.1
      @title_offset = 0.33
      @ytick_length = 0.01
    end
    attr_reader :canvas
    attr_accessor :font_size, :title_offset
    
    def add(graph, draw_option='', title='', yRange=nil)
      @graph_list << [graph, draw_option, title, yRange]
    end
    
    def add_same(graph, draw_option, i)
      @same_graph_list << [graph, draw_option, i]
    end
    
    def draw(name, wx, wy, margin=50)
      numPlot = @graph_list.size
      canvasHeight = wy*numPlot+2*margin
      @canvas = TCanvas.create(name, '', wx, canvasHeight)
      set_root_style()
      small = 1e-5
      @canvas.Divide(1, numPlot, small, small)
      
      padHeight = wy.to_f/canvasHeight.to_f
      padMargin = margin.to_f/canvasHeight.to_f
      padY2 = 1.0
      padY1 = 1.0-padMargin-padHeight
      
      numPlot.times{|i|
        @canvas.cd(i+1)
        padY1 = 0.0 if i==numPlot-1
        gPad.SetPad(0.0, padY1, 1.0, padY2)
        # gPad.SetFillStyle(4000)
        gPad.SetFillColor(0)
        gPad.SetFrameFillColor(0)
        
        graph = @graph_list[i][0]
        option = @graph_list[i][1]
        title = @graph_list[i][2]
        yRange = @graph_list[i][3]
        if i==0
          gPad.SetTopMargin(margin.to_f/(margin+wy).to_f)
          gPad.SetBottomMargin(small)
          graph.GetYaxis.SetLabelSize(@font_size)
          graph.GetYaxis.SetTitleSize(@font_size)
          graph.GetXaxis.SetLabelColor(0)
          graph.GetYaxis.SetTitleOffset(@title_offset*(margin+wy).to_f/wy.to_f)
          graph.GetYaxis.SetTickLength(@ytick_length*(margin+wy).to_f/wy.to_f)
        elsif i==numPlot-1
          gPad.SetTopMargin(small)
          gPad.SetBottomMargin(margin.to_f/(margin+wy).to_f)
          graph.GetYaxis.SetLabelSize(@font_size)
          graph.GetYaxis.SetTitleSize(@font_size)
          graph.GetXaxis.SetLabelSize(@font_size)
          graph.GetXaxis.SetTitleSize(@font_size)
          graph.GetYaxis.SetTitleOffset(@title_offset*(margin+wy).to_f/wy.to_f)
          graph.GetYaxis.SetTickLength(@ytick_length*(margin+wy).to_f/wy.to_f)
        else
          gPad.SetTopMargin(small)
          gPad.SetBottomMargin(small)
          graph.GetYaxis.SetLabelSize(@font_size*(margin+wy).to_f/wy.to_f)
          graph.GetYaxis.SetTitleSize(@font_size*(margin+wy).to_f/wy.to_f)
          graph.GetXaxis.SetLabelColor(0)
          graph.GetYaxis.SetTitleOffset(@title_offset)
          graph.GetYaxis.SetTickLength(@ytick_length)
        end
        
        # graph.GetXaxis.SetLabelFont(42)
        # graph.GetYaxis.SetLabelFont(42)
        # graph.GetXaxis.SetTitleFont(42)
        # graph.GetYaxis.SetTitleFont(42)
        graph.GetYaxis.SetNdivisions(205)
        # graph.GetYaxis.SetTickLength(0.01)
        
        graph.Draw(option)
        graph.GetYaxis.SetTitle(title)
        graph.GetYaxis.CenterTitle
        # graph.GetYaxis.SetTitleOffset(@title_offset)
        if yRange
          yRangeWidth = yRange[1]-yRange[0]
          offset = yRangeWidth*0.005
          yRange0 = yRange[0]+offset
          yRange1 = yRange[1]-offset
          yRange0 = 0.0 if yRange[0]==0.0
          yRange1 = 0.0 if yRange[1]==0.0
          graph.GetYaxis.SetRangeUser(yRange0, yRange1) 
        end
        gPad.SetTickx
        gPad.SetTicky
        
        padY2 = padY1
        padY1 -= padHeight
      }
      return @canvas
    end
    
    def setXRange(x0, x1, title='')
      @graph_list.last[0].GetXaxis.SetTitle(title)
      @graph_list.last[0].GetXaxis.CenterTitle
      @graph_list.each{|gr|
        gr[0].GetXaxis.SetLimits(x0, x1)
      }
      return @canvas
    end
    
    def draw_same()
      @same_graph_list.each {|gl|
        graph = gl[0]
        option = gl[1]
        i = gl[2]
        @canvas.cd(i+1)
        graph.Draw('SAME '+option)
      }
      return @canvas
    end
  end

  def say_wait()
    puts "press <return> key to quit"
    dummy = STDIN.gets
  end
  
  def create_square_canvas(name, size=600, title='')
    wx = size+4
    wy = size+4+24
    TCanvas.create(name, title, wx, wy)
  end
end
