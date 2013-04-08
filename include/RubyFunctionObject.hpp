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

#ifndef RUBYROOT_RubyFunctionObject_H
#define RUBYROOT_RubyFunctionObject_H 1

#include <ruby.h>

namespace rubyroot {

class RubyFunctionObject {
public:
  RubyFunctionObject(VALUE o, int np, int nx=1)
    : obj(o), num_param(np), num_x(nx)
  {
  }

  double operator() (double *x, double *p)
  {
    ID method = rb_intern("call");
    VALUE arg0 = rb_ary_new();
    for (int i=0; i<num_x; i++) {
      rb_ary_push(arg0, rb_float_new(x[0]));
    }
    VALUE arg1 = rb_ary_new();
    for (int i=0; i<num_param; i++) {
      rb_ary_push(arg1, rb_float_new(p[0]));
    }
    VALUE ret = rb_funcall(obj, method, 2, arg0, arg1);
    return NUM2DBL(ret);
  }

private:
  VALUE obj;
  int num_param;
  int num_x;
};

}

#endif // RUBYROOT_RubyFunctionObject_H
