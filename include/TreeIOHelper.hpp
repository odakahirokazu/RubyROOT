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
 * @date 2015-10-20 | add type 'C'
 **/

#ifndef RUBYROOT_TreeIOHelper_H
#define RUBYROOT_TreeIOHelper_H 1

#include <cstddef>
#include <iostream>
#include <sstream>
#include <map>
#include <list>
#include <Rtypes.h>
#include <TTree.h>

namespace rubyroot {

template<typename T> char type_symbol()  { return '_'; }
template<> char type_symbol<Char_t>()    { return 'B'; }
template<> char type_symbol<Short_t>()   { return 'S'; }
template<> char type_symbol<Int_t>()     { return 'I'; }
template<> char type_symbol<Long64_t>()  { return 'L'; }
template<> char type_symbol<UChar_t>()   { return 'b'; }
template<> char type_symbol<UShort_t>()  { return 's'; }
template<> char type_symbol<UInt_t>()    { return 'i'; }
template<> char type_symbol<ULong64_t>() { return 'l'; }
template<> char type_symbol<Float_t>()   { return 'F'; }
template<> char type_symbol<Double_t>()  { return 'D'; }
template<> char type_symbol<Bool_t>()    { return 'O'; }


class BranchData
{
public:
  BranchData() : _pointer(0), _length(1), _type('_'),
                 _variable_length(false), _length_leaf("") {}
  ~BranchData() {}

  void set_pointer(void* p) { _pointer = p; }
  void* pointer() const { return _pointer; }

  void set_length(std::size_t len) { _length = len; }
  void set_variable_length(const std::string leaf)
  { 
    _length_leaf = leaf;
    if (leaf=="") { _variable_length = false; }
    else { _variable_length = true; }
  }

  bool variable_length() const { return _variable_length; }
  std::size_t length() const { return _length; }
  std::string length_leaf() const { return _length_leaf; }

  void set_type(char t) { _type = t; }
  char type() const { return _type; }

  void finalize()
  {
    if (_type=='C') __delete_data<Char_t>();
    else if (_type=='B') __delete_data<Char_t>();
    else if (_type=='S') __delete_data<Short_t>();
    else if (_type=='I') __delete_data<Int_t>();
    else if (_type=='L') __delete_data<Long64_t>();
    else if (_type=='b') __delete_data<UChar_t>();
    else if (_type=='s') __delete_data<UShort_t>();
    else if (_type=='i') __delete_data<UInt_t>();
    else if (_type=='l') __delete_data<ULong64_t>();
    else if (_type=='F') __delete_data<Float_t>();
    else if (_type=='D') __delete_data<Double_t>();
    else if (_type=='O') __delete_data<Bool_t>();
  }

private:
  void* _pointer;
  std::size_t _length;
  char _type;
  bool _variable_length;
  std::string _length_leaf;

private:
  template <typename T> void __delete_data()
  {
    T* p = static_cast<T*>(_pointer);
    if (_length>1) { delete[] p; }
    else { delete p; }
  }
};


class TreeIOHelper
{
  typedef std::map<std::string, BranchData> BMap;
  typedef std::map<std::string, BranchData>::iterator BIter;
  typedef std::list<std::string>::iterator NameIter;

public:
  explicit TreeIOHelper(TTree* t) : tree(t) {}
  ~TreeIOHelper()
  {
    for (BIter it=data.begin(); it!=data.end(); ++it) {
      (*it).second.finalize();
    }
  }

  const TTree* get_tree() { return tree; }

  Int_t get_entry(Long64_t entry=0, Int_t getall=0) { return tree->GetEntry(entry, getall); }
  Long64_t get_entries() { return tree->GetEntries(); }

  template <typename T> void set_value(const std::string& name, T v)
  {
    T* ptr = static_cast<T*>(data[name].pointer());
    *ptr = v;
  }

  void set_value_C(const std::string& name, Char_t v)    { set_value(name, v); }
  void set_value_B(const std::string& name, Char_t v)    { set_value(name, v); }
  void set_value_S(const std::string& name, Short_t v)   { set_value(name, v); }
  void set_value_I(const std::string& name, Int_t v)     { set_value(name, v); }
  void set_value_L(const std::string& name, Long64_t v)  { set_value(name, v); }
  void set_value_b(const std::string& name, UChar_t v)   { set_value(name, v); }
  void set_value_s(const std::string& name, UShort_t v)  { set_value(name, v); }
  void set_value_i(const std::string& name, UInt_t v)    { set_value(name, v); }
  void set_value_l(const std::string& name, ULong64_t v) { set_value(name, v); }
  void set_value_F(const std::string& name, Float_t v)   { set_value(name, v); }
  void set_value_D(const std::string& name, Double_t v)  { set_value(name, v); }
  void set_value_O(const std::string& name, Bool_t v)    { set_value(name, v); }

  template <typename T1, typename T2> void set_array(const std::string& name, const T2* a)
  {
    T1* ptr = static_cast<T1*>(data[name].pointer());
    const std::size_t len = data[name].length();
    for (std::size_t i=0; i<len; i++) { ptr[i] = a[i]; }
  }
  
  void set_array_C(const std::string& name, const int* a)    { set_array<Char_t, int>(name, a); }
  void set_array_B(const std::string& name, const int* a)    { set_array<Char_t, int>(name, a); }
  void set_array_S(const std::string& name, const int* a)    { set_array<Short_t, int>(name, a); }
  void set_array_I(const std::string& name, const int* a)    { set_array<Int_t, int>(name, a); }
  void set_array_L(const std::string& name, const int* a)    { set_array<Long64_t, int>(name, a); }
  void set_array_b(const std::string& name, const int* a)    { set_array<UChar_t, int>(name, a); }
  void set_array_s(const std::string& name, const int* a)    { set_array<UShort_t, int>(name, a); }
  void set_array_i(const std::string& name, const int* a)    { set_array<UInt_t, int>(name, a); }
  void set_array_l(const std::string& name, const int* a)    { set_array<ULong64_t, int>(name, a); }
  void set_array_F(const std::string& name, const double* a) { set_array<Float_t, double>(name, a); }
  void set_array_D(const std::string& name, const double* a) { set_array<Double_t, double>(name, a); }
  void set_array_O(const std::string& name, const int* a)    { set_array<Bool_t, int>(name, a); }

  template <typename T> T get_value(const std::string& name)
  {
    T* ptr = static_cast<T*>(data[name].pointer());
    return *ptr;
  }

  Char_t get_value_C(const std::string& name)    { return get_value<Char_t>(name); }
  Char_t get_value_B(const std::string& name)    { return get_value<Char_t>(name); }
  Short_t get_value_S(const std::string& name)   { return get_value<Short_t>(name); }
  Int_t get_value_I(const std::string& name)     { return get_value<Int_t>(name); }
  Long64_t get_value_L(const std::string& name)  { return get_value<Long64_t>(name); }
  UChar_t get_value_b(const std::string& name)   { return get_value<UChar_t>(name); }
  UShort_t get_value_s(const std::string& name)  { return get_value<UShort_t>(name); }
  UInt_t get_value_i(const std::string& name)    { return get_value<UInt_t>(name); }
  ULong64_t get_value_l(const std::string& name) { return get_value<ULong64_t>(name); }
  Float_t get_value_F(const std::string& name)   { return get_value<Float_t>(name); }
  Double_t get_value_D(const std::string& name)  { return get_value<Double_t>(name); }
  Bool_t get_value_O(const std::string& name)    { return get_value<Bool_t>(name); }

  template <typename T1, typename T2> void get_array(const std::string& name, T2* a)
  {
    T1* ptr = static_cast<T1*>(data[name].pointer());
    const std::size_t len = data[name].length();
    for (std::size_t i=0; i<len; i++) { a[i] = ptr[i]; }
  }

  void get_array_C(const std::string& name, int* a)    { return get_array<Char_t, int>(name, a); }
  void get_array_B(const std::string& name, int* a)    { return get_array<Char_t, int>(name, a); }
  void get_array_S(const std::string& name, int* a)    { return get_array<Short_t, int>(name, a); }
  void get_array_I(const std::string& name, int* a)    { return get_array<Int_t, int>(name, a); }
  void get_array_L(const std::string& name, int* a)    { return get_array<Long64_t, int>(name, a); }
  void get_array_b(const std::string& name, int* a)    { return get_array<UChar_t, int>(name, a); }
  void get_array_s(const std::string& name, int* a)    { return get_array<UShort_t, int>(name, a); }
  void get_array_i(const std::string& name, int* a)    { return get_array<UInt_t, int>(name, a); }
  void get_array_l(const std::string& name, int* a)    { return get_array<ULong64_t, int>(name, a); }
  void get_array_F(const std::string& name, double* a) { return get_array<Float_t, double>(name, a); }
  void get_array_D(const std::string& name, double* a) { return get_array<Double_t, double>(name, a); }
  void get_array_O(const std::string& name, int* a)    { return get_array<Bool_t, int>(name, a); }

  void set_branches()
  {
    for (BIter it=data.begin(); it!=data.end(); ++it) {
      const std::string& name = (*it).first;
      void* ptr = (*it).second.pointer();
      tree->SetBranchAddress(name.c_str(), ptr);
    }
  }

  void construct_branches()
  {
    for (NameIter ni=branch_list.begin(); ni!=branch_list.end(); ++ni) {
      const std::string& name = *ni;
      BIter it = data.find(name);
      if (it == data.end()) break;
      void* ptr = (*it).second.pointer();
      std::size_t length = (*it).second.length();
      bool variable = (*it).second.variable_length();
      char type = (*it).second.type();
      std::ostringstream leaf;
      leaf << name;
      if (variable) {
        std::string leaf_ref = (*it).second.length_leaf();
        leaf << '[' << leaf_ref << ']';
      }
      else if (length>1) {
        leaf << '[' << length << ']';
      }
      leaf << '/' << type;
      tree->Branch(name.c_str(), ptr, leaf.str().c_str());
    }
  }

  void register_branch(const std::string& name, const std::string& type, std::size_t length=1, const std::string& leaf_ref="")
  {
    if (type=="C") __register_branch<Char_t>(name, length, leaf_ref, 'C');
    else if (type=="B") __register_branch<Char_t>(name, length, leaf_ref);
    else if (type=="S") __register_branch<Short_t>(name, length, leaf_ref);
    else if (type=="I") __register_branch<Int_t>(name, length, leaf_ref);
    else if (type=="L") __register_branch<Long64_t>(name, length, leaf_ref);
    else if (type=="b") __register_branch<UChar_t>(name, length, leaf_ref);
    else if (type=="s") __register_branch<UShort_t>(name, length, leaf_ref);
    else if (type=="i") __register_branch<UInt_t>(name, length, leaf_ref);
    else if (type=="l") __register_branch<ULong64_t>(name, length, leaf_ref);
    else if (type=="F") __register_branch<Float_t>(name, length, leaf_ref);
    else if (type=="D") __register_branch<Double_t>(name, length, leaf_ref);
    else if (type=="O") __register_branch<Bool_t>(name, length, leaf_ref);
  }

private:
  template <typename T>
  void __register_branch(const std::string& name, std::size_t length, const std::string& leaf_ref, char type=0)
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
      info.set_pointer(static_cast<void*>(p));
      info.set_length(length);
    }
    else if (length>1) {
      info.set_pointer(static_cast<void*>(new T[length]));
      info.set_length(length);
      info.set_variable_length(leaf_ref);
    }
    else {
      info.set_pointer(0);
      info.set_length(0);
      info.set_variable_length(leaf_ref);
    }

    if (type) {
      info.set_type(type);
    }
    else {
      info.set_type(type_symbol<T>());
    }
    data.insert(std::make_pair(name, info));
    branch_list.push_back(name);
  }

private:
  TTree* tree;
  BMap data;
  std::list<std::string> branch_list;

private:
  TreeIOHelper& operator=(const TreeIOHelper&);
  TreeIOHelper(const TreeIOHelper&);
};

} /* namespace rubyroot */

#endif // RUBYROOT_TreeIOHelper_H
