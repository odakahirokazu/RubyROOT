RubyROOT
================================================================

Ruby binding of ROOT (CERN)

- Version: 0.0
- Author: Hirokazu Odaka


 1. Introduction
---------------------------------------------------------------

RubyROOT is a Ruby binding of CERN ROOT Analysis Framework.
RubyROOT provides a minimun set of Ruby interface to useful
ROOT classes including histograms, tree, graphs, and canvases.


 2. Information
---------------------------------------------------------------

### (1) Contact

- Hirokazu Odaka 
- ISAS/JAXA
- odaka(AT)astro.isas.jaxa.jp

### (2) Documentation

http://www.astro.isas.jaxa.jp/~odaka/rubyroot/ (under construction)

### (3) Git Hub

https://github.com/odakahirokazu/RubyROOT/


 3. Supported System
---------------------------------------------------------------

- Mac OS X (the author's standard environment)
- Linux (probably)


 4. Required software
---------------------------------------------------------------

### (1) C++ compliler

### (2) [CMake] (http://www.cmake.org/) (Cross platform make)
[version 2.8 or later]  
For easy installation, this package uses CMake to generate building tools such as Makefile.

### (3) [Ruby] (http://www.ruby-lang.org/en/)
[version 2.0]  
Ruby 2.0 is required.

### (4) [SWIG] (http://www.swig.org/) (Simplified Wrapper and Interface Generator)
[version 2.0 or later]  
SWIG provides an easy way to generate extended libraries of various scripting languages.

### (5) [ROOT] (http://root.cern.ch/)
[version 5.34 or later]  
A data analysis framework.


 5. Installation
---------------------------------------------------------------

On Mac OS X with Homebrew, the easiest way is as follows:

### (1) Update Homebrew.

    unix> brew update

### (2) Install required software via Homebrew.

    unix> brew install cmake
    unix> brew install swig
    unix> brew install ruby-build
    unix> brew install rbenv

### (3) Install Ruby.

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

Then, you can select the latest stable version 2.0.0-p0, for example.

    unix> rbenv install 2.0.0-p0
    unix> rbenv rehash
    unix> rbenv global 2.0.0-p0

### (4) Install ROOT.

### (5) Obtain RubyROOT via GitHub.

    unix> git clone git://github.com/odakahirokazu/RubyROOT.git

### (6) Build & install.

    unix> ls
      RubyROOT ...
    
    unix> mkdir RubyROOT-build
    unix> cd RubyROOT-build
    unix> cmake ../RubyROOT -DCMAKE_INSTALL_PREFIX=<your_install_destination> (default: $HOME)
    unix> make
    unix> make install

### (7) Fun!

There are some example scripts using RubyROOT in `examples` directory.

#### NOTE for Linux users ####
It should be possible to install RubyROOT on Linux.
You need to install the same software descibed above and please try the same way.
It may be necessary to modify CMake files in this package.
