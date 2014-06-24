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
 * @date 2013-06-13
 **/

#ifndef RUBYROOT_Minuit2FunctionMinimizer_H
#define RUBYROOT_Minuit2FunctionMinimizer_H 1

#include <ruby.h>
#include <Math/IFunction.h>
#include <Minuit2/Minuit2Minimizer.h>

namespace rubyroot {

class RubyIMultiGenFunction : public ROOT::Math::IMultiGenFunction
{
public:
  RubyIMultiGenFunction(VALUE o, int nx)
    : obj(o), num_x(nx) {}
  
  RubyIMultiGenFunction(const RubyIMultiGenFunction& r)
    : obj(r.obj), num_x(r.num_x) {}
  
  ~RubyIMultiGenFunction() {}

  IBaseFunctionMultiDim* Clone() const
  { return new RubyIMultiGenFunction(*this); }
  
  unsigned int NDim() const { return num_x; }

private:
  virtual double DoEval(const double* x) const
  {
    ID method = rb_intern("call");
    VALUE arg0 = rb_ary_new();
    for (int i=0; i<num_x; i++) {
      rb_ary_push(arg0, rb_float_new(x[i]));
    }
    VALUE ret = rb_funcall(obj, method, 1, arg0);
    return NUM2DBL(ret);    
  }
  
private:
  VALUE obj;
  int num_x;
};


class Minuit2FunctionMinimizer : public ROOT::Minuit2::Minuit2Minimizer
{
public:
  Minuit2FunctionMinimizer(ROOT::Minuit2::EMinimizerType type=ROOT::Minuit2::kMigrad)
    : Minuit2Minimizer(type), _function(0) {}
  
  Minuit2FunctionMinimizer(const char* type)
    : Minuit2Minimizer(type), _function(0) {}
  
  virtual ~Minuit2FunctionMinimizer()
  {
    if (_function) {
      delete _function;
      _function = 0;
    }
  }

  virtual void SetFunctionObject(VALUE func, int nx)
  {
    if (_function) {
      delete _function;
      _function = 0;
    }
    
    _function = new rubyroot::RubyIMultiGenFunction(func, nx);
    this->SetFunction(*_function);
  }

  double GetParameter(int i) const { return (this->X())[i]; }
  double GetError(int i) const { return (this->Errors())[i]; }

private:
  rubyroot::RubyIMultiGenFunction* _function;
};

}

#endif // RUBYROOT_Minuit2FunctionMinimizer_H
