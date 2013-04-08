/**************************************************************************
 *                                                                        *
 *  Copyright (c) 2013 Hirokazu Odaka                                     *
 *                                                                        *
 *  This file is part of RubyROOT.                                        *
 *                                                                        *
 *  RubyROOT is free software: you can redistribute it and/or modify      *
 *  it under the terms of the GNU General Public License as published by  *
 *  the Free Software Foundation, either version 3 of the License, or     *
 *  (at your option) any later version.                                   *
 *                                                                        *
 *  RubyROOT is distributed in the hope that it will be useful,           *
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *  GNU General Public License for more details.                          *
 *                                                                        *
 *  You should have received a copy of the GNU General Public License     *
 *  along with RubyROOT.  If not, see <http://www.gnu.org/licenses/>.     *
 *                                                                        *
 **************************************************************************/

/**
 * @author Hirokazu Odaka
 * @date 2013-04-03
 **/

#ifndef RUBYROOT_TreeIOHelper_H
#define RUBYROOT_TreeIOHelper_H 1

#include <iostream>
#include <sstream>
#include <map>
#include <Rtypes.h>
#include <TTree.h>

namespace rubyroot {

template<typename T> char type_symbol() { return '_'; }
template<> char type_symbol<Char_t>() { return 'B'; }
template<> char type_symbol<Short_t>() { return 'S'; }
template<> char type_symbol<Int_t>() { return 'I'; }
template<> char type_symbol<Long64_t>() { return 'L'; }
template<> char type_symbol<UChar_t>() { return 'b'; }
template<> char type_symbol<UShort_t>() { return 's'; }
template<> char type_symbol<UInt_t>() { return 'i'; }
template<> char type_symbol<ULong64_t>() { return 'l'; }
template<> char type_symbol<Float_t>() { return 'F'; }
template<> char type_symbol<Double_t>() { return 'D'; }
template<> char type_symbol<Bool_t>() { return 'O'; }


struct BranchData
{
  void* pointer;
  size_t length;
  char type;

public:
  BranchData() : pointer(0), length(1), type('_') {}
  ~BranchData() {}

  void finalize()
  {
    if (type=='B') __delete_data<Char_t>();
    else if (type=='S') __delete_data<Short_t>();
    else if (type=='I') __delete_data<Int_t>();
    else if (type=='L') __delete_data<Long64_t>();
    else if (type=='b') __delete_data<UChar_t>();
    else if (type=='s') __delete_data<UShort_t>();
    else if (type=='i') __delete_data<UInt_t>();
    else if (type=='l') __delete_data<ULong64_t>();
    else if (type=='F') __delete_data<Float_t>();
    else if (type=='D') __delete_data<Double_t>();
    else if (type=='O') __delete_data<Bool_t>();
  }

private:
  template <typename T> void __delete_data()
  {
    T* p = static_cast<T*>(pointer);
    if (length>1) { delete[] p; }
    else { delete p; }
  }
};


class TreeIOHelper
{
  typedef std::map<std::string, BranchData> BMap;
  typedef std::map<std::string, BranchData>::iterator BIter;

public:
  explicit TreeIOHelper(TTree* t) : tree(t) {}
  ~TreeIOHelper()
  {
    for (BIter it=data.begin(); it!=data.end(); ++it) {
      (*it).second.finalize();
    }
  }

  Int_t get_entry(Long64_t entry=0, Int_t getall=0) { return tree->GetEntry(entry, getall); }
  Long64_t get_entries() { return tree->GetEntries(); }

  template <typename T> void set_value(const std::string& name, T v)
  {
    T* ptr = static_cast<T*>(data[name].pointer);
    *ptr = v;
  }

  void set_value_B(const std::string& name, Char_t v) { set_value(name, v); }
  void set_value_S(const std::string& name, Short_t v) { set_value(name, v); }
  void set_value_I(const std::string& name, Int_t v) { set_value(name, v); }
  void set_value_L(const std::string& name, Long64_t v) { set_value(name, v); }
  void set_value_b(const std::string& name, UChar_t v) { set_value(name, v); }
  void set_value_s(const std::string& name, UShort_t v) { set_value(name, v); }
  void set_value_i(const std::string& name, UInt_t v) { set_value(name, v); }
  void set_value_l(const std::string& name, ULong64_t v) { set_value(name, v); }
  void set_value_F(const std::string& name, Float_t v) { set_value(name, v); }
  void set_value_D(const std::string& name, Double_t v) { set_value(name, v); }
  void set_value_O(const std::string& name, Bool_t v) { set_value(name, v); }

  template <typename T> T get_value(const std::string& name)
  {
    T* ptr = static_cast<T*>(data[name].pointer);
    return *ptr;
  }

  Char_t get_value_B(const std::string& name) { return get_value<Char_t>(name); }
  Short_t get_value_S(const std::string& name) { return get_value<Short_t>(name); }
  Int_t get_value_I(const std::string& name) { return get_value<Int_t>(name); }
  Long64_t get_value_L(const std::string& name) { return get_value<Long64_t>(name); }
  UChar_t get_value_b(const std::string& name) { return get_value<UChar_t>(name); }
  UShort_t get_value_s(const std::string& name) { return get_value<UShort_t>(name); }
  UInt_t get_value_i(const std::string& name) { return get_value<UInt_t>(name); }
  ULong64_t get_value_l(const std::string& name) { return get_value<ULong64_t>(name); }
  Float_t get_value_F(const std::string& name) { return get_value<Float_t>(name); }
  Double_t get_value_D(const std::string& name) { return get_value<Double_t>(name); }
  Bool_t get_value_O(const std::string& name) { return get_value<Bool_t>(name); }

  void set_branches()
  {
    for (BIter it=data.begin(); it!=data.end(); ++it) {
      const std::string& name = (*it).first;
      void* ptr = (*it).second.pointer;
      tree->SetBranchAddress(name.c_str(), ptr);
    }
  }

  void construct_branches()
  {
    for (BIter it=data.begin(); it!=data.end(); ++it) {
      const std::string& name = (*it).first;
      void* ptr = (*it).second.pointer;
      size_t length = (*it).second.length;
      char type = (*it).second.type;
      std::ostringstream leaf;
      leaf << name << '/' << type;
      if (length>1) { leaf << '[' << length << ']'; }
      tree->Branch(name.c_str(), ptr, leaf.str().c_str());
    }
  }

  void register_branch(const std::string& name, const std::string& type, size_t length=1)
  {
    if (type=="B") __register_branch<Char_t>(name, length);
    else if (type=="S") __register_branch<Short_t>(name, length);
    else if (type=="I") __register_branch<Int_t>(name, length);
    else if (type=="L") __register_branch<Long64_t>(name, length);
    else if (type=="b") __register_branch<UChar_t>(name, length);
    else if (type=="s") __register_branch<UShort_t>(name, length);
    else if (type=="i") __register_branch<UInt_t>(name, length);
    else if (type=="l") __register_branch<ULong64_t>(name, length);
    else if (type=="F") __register_branch<Float_t>(name, length);
    else if (type=="D") __register_branch<Double_t>(name, length);
    else if (type=="O") __register_branch<Bool_t>(name, length);
  }

private:
  template <typename T>
  void __register_branch(const std::string& name, size_t length)
  {
    BIter it = data.find(name);
    if (it != data.end()) {
      std::cout << "cannot replace Branch " << name << std::endl;
      return;
    }

    BranchData info;
    if (length == 1) {
      T* p = new T;
      *p = 0;
      info.pointer  = static_cast<void*>(p);
    }
    else if (length>1) {
      info.pointer = static_cast<void*>(new T[length]);
    }

    info.length = length;
    info.type = type_symbol<T>();
    data.insert(std::make_pair(name, info));
  }

private:
  TTree* tree;
  BMap data;

private:
  TreeIOHelper& operator=(const TreeIOHelper&);
  TreeIOHelper(const TreeIOHelper&);
};

}

#endif // RUBYROOT_TreeIOHelper_H
