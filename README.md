RubyROOT
================================================================

Ruby binding of ROOT (CERN)

- Version: 0.1.3
- Author: Hirokazu Odaka


 1. Introduction
----------------------------------------------------------------

RubyROOT is a Ruby binding of CERN ROOT Analysis Framework. RubyROOT provides a
minimun set of Ruby interface to useful ROOT classes including histograms,
tree, graphs, and canvases.

ROOT already has a well-designed Ruby binding, "RubyRoot", in the package. But
this seems not possible to be built with Ruby 2.0. Thus, we have started
developing of this library.

Currently, this Ruby wapper offers the following ROOT classes:  
TApplication, TAttAxis, TAttFill, TAttLine, TAttMarker, TAttPad, TAttText,
TAxis, TBranch, TCanvas, TChain, TCollection, TColor, TDirectory,
TDirectoryFile, TF1, TFile, TFormula, TGraph, TGraphAsymmErrors, TGraphErrors,
TH1, TH1C, TH1D, TH1F, TH1I, TH1S, TH2, TH2C, TH2D, TH2F, TH2I, TH2S, TH3,
TH3C, TH3D, TH3F, TH3I, TH3S, TKey, TLeaf, TList, TNamed, TObjArray,
TObjString, TObject, TPad, TROOT, TRandom, TRandom3, TSeqCollection, TString,
TStyle, TTree, TVirtualPad.


 2. Information
----------------------------------------------------------------

### (1) Contact

- Hirokazu Odaka 
- ISAS/JAXA
- odaka(AT)astro.isas.jaxa.jp

### (2) GitHub

https://github.com/odakahirokazu/RubyROOT/


 3. Supported System
----------------------------------------------------------------

- Mac OS X
- Linux (not tested; but probably OK)

### NOTE for Linux users

It should be possible to install RubyROOT on Linux. You need to install the
same software descibed below and please try the same way. It might be necessary
to modify CMake files in this package.


 4. Required Software
----------------------------------------------------------------

### (1) C++ compliler

### (2) [CMake](http://www.cmake.org/) (Cross platform make)
*version 2.8.11 or later*

For easy installation, this package uses CMake to generate building tools such
as Makefile.

### (3) [Ruby](http://www.ruby-lang.org/en/)
*version 2.0.0*

Ruby 2.0 is required.

### (4)[SWIG](http://www.swig.org/) (Simplified Wrapper and Interface Generator)
*version 2.0.9 or later*

SWIG provides an easy way to generate extended libraries of various scripting
languages.

### (5) [ROOT](http://root.cern.ch/)
*version 5.34.05 or later*

A data analysis framework.


 5. Installation
----------------------------------------------------------------

On Mac OS X with [Homebrew](http://mxcl.github.io/homebrew/), the easiest way
is as follows.

### (1) Update Homebrew.

    unix> brew update

### (2) Install required software via Homebrew.

    unix> brew install cmake
    unix> brew install swig

### (3) Install Ruby.

[Rbenv](https://github.com/sstephenson/rbenv/) provides nice Ruby environemt,
in which you can easily/safely select different Ruby versions. It can easily
introduced using Homebrew on OS X.

    unix> brew install ruby-build
    unix> brew install rbenv

To initialize rbenv, write the following line in `.bashrc` or `.zshrc`.

    eval "$(rbenv init -)"

Then, in a new shell, install Ruby as follows.

    unix> rbenv install -l

This will show like this => 

    Available versions:
      1.8.6-p383
      1.8.6-p420
      1.8.7-p249
      ...
      1.9.3-p392
      1.9.3-preview1
      1.9.3-rc1
      2.0.0-dev
      2.0.0-p0
      2.0.0-preview1
      2.0.0-preview2
      ...

Then, select the latest stable version: 2.0.0-p0, for example.
(You can select 2.0.0-p0 or later.)

    unix> rbenv install 2.0.0-p0
    unix> rbenv rehash
    unix> rbenv global 2.0.0-p0

### (4) Install ROOT.

    unix> brew install root

### (5) Obtain RubyROOT via GitHub.

    unix> git clone git://github.com/odakahirokazu/RubyROOT.git

### (6) Build & install.

    unix> ls
      RubyROOT ...
    
    unix> mkdir RubyROOT-build
    unix> cd RubyROOT-build
    unix> cmake ../RubyROOT -DCMAKE_INSTALL_PREFIX=<your_install_destination>

By default, `CMAKE_INSTALL_PREFIX` is set to `$HOME`; The ruby extention
library will be installed in `$HOME/lib/ruby`.

    unix> make
    unix> make install

### (7) Set environment variable.

    export RUBYLIB=<your_install_destination>/lib/ruby:$RUBYLIB

### (8) Fun!

You can find example scripts using RubyROOT in `examples` directory.

****************************************************************
