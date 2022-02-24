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

module RootUtil
  def gDirectory(); Root::TDirectory.CurrentDirectory(); end
  def gPad(); Root::TVirtualPad.Pad(); end
  def gROOT(); Root::GetROOT(); end
  def gStyle(); Root::GetStyle(); end

  def type_char(t)
    t = t.to_sym
    { :Char_t => 'B', :Short_t => 'S', :Int_t => 'I', :Long64_t => 'L',
      :UChar_t => 'b', :UShort_t => 's', :UInt_t => 'i', :ULong64_t => 'l',
      :Float_t => 'F', :Double_t => 'D', :Bool_t => 'O'}[t]
  end

  def func(&f)
    lambda {|x, p| f.(x[0]) }
  end

  module_function :gDirectory, :gPad, :gROOT, :gStyle, :type_char, :func
end


module RootApp
  @@app = nil

  def self.included(mod)
    unless @@app
      @@app = Root::TRint.new("App", nil, nil)
      # puts '@@app initialized'
    end
  end

  def get_app()
    @@app
  end

  def wait_root(run=false)
    if run
      puts 'To quit: please select "Quit ROOT" from the pulldown menu "File"'
      @@app.Run
    else
      puts "press <return> key to quit"
      dummy = STDIN.gets
    end
  end

  def run_app(run=true); wait_root(run); end

  module_function :wait_root, :get_app, :run_app
end


module Root
  module_function :GetROOT, :GetStyle

  include RootUtil
  module_function :gDirectory, :gPad, :gROOT, :gStyle, :type_char, :func

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
      Root::send(:"castInto#{class_name}", self)
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
        o = self.After(o)
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
      if obj = self.GetTObject(name)
        obj.auto_cast
      else
        nil
      end
    end
  end

  module TTree::Impl
    def read()
      reader = TreeIOHelper.new(self)
      branches = {}
      self.GetListOfBranches.each do |b|
        b.auto_cast.GetListOfLeaves.each do |l|
          leaf = l.cast_to(:TLeaf)
          name = leaf.GetBranch.auto_cast.GetName
          type = RootUtil::type_char(leaf.GetTypeName)
          if leaf.ClassName == "TLeafC"
            type = 'C'
          end
          len = leaf.GetLen
          if lc = leaf.GetLeafCount
            len = lc.GetMaximum
          end
          reader.register_branch(name, type, len)

          method = "get_value_of_#{name}".to_sym
          if len==1
            branches[name.to_sym] = type.to_s
            reader.singleton_class.send(:define_method, method) do
              send("get_value_#{type}".to_sym, name)
            end
          else
            branches[name.to_sym] = "#{type}[#{len}]"
            if type=='F' || type=='D'
              if lc
                reader.singleton_class.send(:define_method, method) do
                  a = DoubleArray.new(len)
                  send("get_array_#{type}".to_sym, name, a)
                  a.to_a(send("get_value_of_#{lc.GetName}"))
                end
              else
                reader.singleton_class.send(:define_method, method) do
                  a = DoubleArray.new(len)
                  send("get_array_#{type}".to_sym, name, a)
                  a.to_a(len)
                end
              end
            elsif type=='C'
              if lc
                reader.singleton_class.send(:define_method, method) do
                  a = IntArray.new(len)
                  send("get_array_#{type}".to_sym, name, a)
                  a.to_a(send("get_value_of_#{lc.GetName}")).take_while{|c| c!=0}.pack('c*')
                end
              else
                reader.singleton_class.send(:define_method, method) do
                  a = IntArray.new(len)
                  send("get_array_#{type}".to_sym, name, a)
                  a.to_a(len).take_while{|c| c!=0}.pack('c*')
                end
              end
            else
              if lc
                reader.singleton_class.send(:define_method, method) do
                  a = IntArray.new(len)
                  send("get_array_#{type}".to_sym, name, a)
                  a.to_a(send("get_value_of_#{lc.GetName}"))
                end
              else
                reader.singleton_class.send(:define_method, method) do
                  a = IntArray.new(len)
                  send("get_array_#{type}".to_sym, name, a)
                  a.to_a(len)
                end
              end
            end
          end

          short_method = name.to_sym
          unless reader.respond_to?(short_method)
            reader.singleton_class.class_eval do
              alias_method(short_method, method)
            end
          end
        end
      end
      reader.set_branches
      reader.branches = branches
      reader
    end

    def define(**branches)
      writer = TreeIOHelper.new(self)
      writer.branches = branches
      branches.each do |k, v|
        name = k.to_s
        type = v[0]
        len = 1
        if v =~ /\[(\d+)\]/
          len = $1.to_i
          len = 1 if len <= 1
          writer.register_branch(name, type, len)
        elsif v =~ /\[(.+)\=(\d+)\]/
          ref = $1
          len = $2.to_i
          writer.register_branch(name, type, len, ref)
        else
          writer.register_branch(name, type)
        end

        method = "set_value_of_#{name}".to_sym
        if len==1
          writer.singleton_class.send(:define_method, method) do |value|
            send("set_value_#{type}".to_sym, name, value)
          end
        else
          if type=='F' || type=='D'
            writer.singleton_class.send(:define_method, method) do |value|
              send("set_array_#{type}".to_sym,
                   name, DoubleArray.from_list(value), value.size)
            end
          elsif type=='C'
            writer.singleton_class.send(:define_method, method) do |value|
              list = value.unpack('c*') << 0
              send("set_array_#{type}".to_sym,
                   name, IntArray.from_list(list), list.size)
            end
          else
            writer.singleton_class.send(:define_method, method) do |value|
              send("set_array_#{type}".to_sym,
                   name, IntArray.from_list(value), value.size)
            end
          end
        end

        short_method = "#{name}=".to_sym
        unless writer.respond_to?(short_method)
          writer.singleton_class.class_eval do
            alias_method(short_method, method)
          end
        end
      end
      writer.construct_branches()
      writer
    end
  end

  module TreeIOHelper::Impl
    attr_writer :branches

    def size()
      get_entries()
    end

    def move_to(i)
      if i<0; i+=size(); end
      get_entry(i)
      self
    end

    def each()
      get_entries().times do |i|
        get_entry(i)
        yield self
      end
    end

    def set(name, value)
      shape = @branches[name.to_sym]
      type = shape[0]
      is_array = shape.include?('[')

      if !is_array
        send("set_value_#{type}".to_sym, name.to_s, value)
      else
        if type=='F' || type=='D'
          send("set_array_#{type}".to_sym,
               name.to_s, DoubleArray.from_list(value), value.size)
        elsif type=='C'
          list = value.unpack('c*') << 0
          send("set_array_#{type}".to_sym,
               name.to_s, IntArray.from_list(list), list.size)
        else
          send("set_array_#{type}".to_sym,
               name.to_s, IntArray.from_list(value), value.size)
        end
      end
    end

    def get(name)
      shape = @branches[name.to_sym]
      type = shape[0]
      is_array = shape.include?('[')

      if !is_array
        send("get_value_#{type}".to_sym, name.to_s)
      else
        leaf = get_tree.GetLeaf(name)
        len = leaf.GetLen
        if lc = leaf.GetLeafCount
          len = lc.GetMaximum
        end

        if type=='F' || type=='D'
          a = DoubleArray.new(len)
          send("get_array_#{type}".to_sym, name.to_s, a)
          if lc
            a.to_a(send("get_value_of_#{lc.GetName}"))
          else
            a.to_a(len)
          end
        elsif type=='C'
          a = IntArray.new(len)
          send("get_array_#{type}".to_sym, name.to_s, a)
          if lc
            a.to_a(send("get_value_of_#{lc.GetName}")).take_while{|c| c!=0}.pack('c*')
          else
            a.to_a(len).take_while{|c| c!=0}.pack('c*')
          end
        else
          a = IntArray.new(len)
          send("get_array_#{type}".to_sym, name.to_s, a)
          if lc
            a.to_a(send("get_value_of_#{lc.GetName}"))
          else
            a.to_a(len)
          end
        end
      end
    end

    def [](index)
      if index.is_a? Integer
        move_to(index)
      else
        get(index)
      end
    end

    def []=(name, value)
      set(name, value)
    end
  end

  class TreeIOHelper
    include Enumerable
  end

  Module.class_eval do
    def define_from_list()
      def self.from_list(list)
        n = list.length
        array = self.new(n)
        n.times{|i| array[i] = list[i] }
        array
      end
      self.singleton_class.class_eval do
        alias_method(:from_array, :from_list)
      end
    end

    def define_to_a()
      define_method :to_a do |len=nil|
        len = self.length unless len
        a = Array.new(len)
        len.times {|i| a[i] = self[i] }
        a
      end
    end
  end

  class IntArray
    define_from_list
    define_to_a
  end

  class DoubleArray
    define_from_list
    define_to_a
    def to_double_array(); self; end
  end

  class TGraph
    def self.create(x, y)
      n = x.length
      ax = DoubleArray.from_list(x)
      ay = DoubleArray.from_list(y)
      TGraph.new(x.size, ax, ay)
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

    module TObjString::Impl
      def to_s()
        self.String.Data()
      end
    end
  end

  class TMultiGraph
    def self.create(name=nil, title=nil)
      if(name and title)
        TMultiGraph.new(name,title)
      else
        TMultiGraph.new()
      end
    end
  end

  class TStyle
    def set_my_style()
      SetOptStat(0)
      SetOptTitle(0)
      SetDrawBorder(0)
      SetCanvasBorderMode(0)
      SetCanvasBorderSize(0)
      SetCanvasColor(10)
      SetPadBorderMode(0)
      SetPadBorderSize(0)
      SetPadColor(10)
      SetFrameBorderMode(0)
      SetFrameBorderSize(0)
      SetFrameFillColor(10)
      SetLabelFont(42, "XYZ")
      SetTitleFont(42, "XYZ")
      SetEndErrorSize(0)
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

      TColor::CreateGradientColorTable(s.length,
                                       DoubleArray.from_array(s),
                                       DoubleArray.from_array(r),
                                       DoubleArray.from_array(g),
                                       DoubleArray.from_array(b),
                                       num)
      SetNumberContours(num)
    end
  end

  class TVirtualPad
    def get_palette()
      self.GetPrimitive("palette").auto_cast
    end
  end

  class TCanvas
    def self.create_square(size=600, name='c1', title='c1')
      wx = size+4
      wy = size+4+24
      self.create(name, title, wx, wy)
    end
  end

  class Minuit2FunctionMinimizer
    def function(func=nil, &block)
      f = func || (block_given? ? block : nil)
      if f
        @function = lambda{|x| f.(*x)}
        nx = f.arity
        SetFunctionObject(@function, nx)
      end
    end

    def get_fcn(); @function; end
  end
end


module RootUtil
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
      @canvas = Root::TCanvas.create(name, '', wx, canvasHeight)
      RootUtil::gStyle.set_my_style()
      small = 1e-5
      @canvas.Divide(1, numPlot, small, small)

      padHeight = wy.to_f/canvasHeight.to_f
      padMargin = margin.to_f/canvasHeight.to_f
      padY2 = 1.0
      padY1 = 1.0-padMargin-padHeight

      numPlot.times{|i|
        pad = @canvas.cd(i+1)
        padY1 = 0.0 if i==numPlot-1
        pad.SetPad(0.0, padY1, 1.0, padY2)
        # pad.SetFillStyle(4000)
        pad.SetFillColor(0)
        pad.SetFrameFillColor(0)

        graph = @graph_list[i][0]
        option = @graph_list[i][1]
        title = @graph_list[i][2]
        yRange = @graph_list[i][3]
        if i==0
          pad.SetTopMargin(margin.to_f/(margin+wy).to_f)
          pad.SetBottomMargin(small)
          graph.GetYaxis.SetLabelSize(@font_size)
          graph.GetYaxis.SetTitleSize(@font_size)
          graph.GetXaxis.SetLabelColor(0)
          graph.GetYaxis.SetTitleOffset(@title_offset*(margin+wy).to_f/wy.to_f)
          graph.GetYaxis.SetTickLength(@ytick_length*(margin+wy).to_f/wy.to_f)
        elsif i==numPlot-1
          pad.SetTopMargin(small)
          pad.SetBottomMargin(margin.to_f/(margin+wy).to_f)
          graph.GetYaxis.SetLabelSize(@font_size)
          graph.GetYaxis.SetTitleSize(@font_size)
          graph.GetXaxis.SetLabelSize(@font_size)
          graph.GetXaxis.SetTitleSize(@font_size)
          graph.GetYaxis.SetTitleOffset(@title_offset*(margin+wy).to_f/wy.to_f)
          graph.GetYaxis.SetTickLength(@ytick_length*(margin+wy).to_f/wy.to_f)
        else
          pad.SetTopMargin(small)
          pad.SetBottomMargin(small)
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
        pad.SetTickx
        pad.SetTicky

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
end

class Array
  def to_double_array(); Root::DoubleArray::from_array(self); end
end
