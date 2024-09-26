/**
 * SWIG Ruby interface to ROOT
 * @author Hirokazu Odaka
 * @date 2013-03-27
 **/

%module root
%{
#include <TObject.h>
#include <TNamed.h>
#include <TDirectory.h>
#include <TROOT.h>
#include <TMath.h>
#include <TCollection.h>
#include <TSeqCollection.h>
#include <TList.h>
#include <TObjArray.h>
#include <TMap.h>
#include <TAxis.h>
#include <TPaletteAxis.h>
#include <TApplication.h>
#include <TRint.h>
#include <TH1.h>
#include <TH2.h>
#include <TH3.h>
#include <TTree.h>
#include <TBranch.h>
#include <TLeaf.h>
#include <TChain.h>
#include <TGraph.h>
#include <TGraphErrors.h>
#include <TGraphAsymmErrors.h>
#include <TMultiGraph.h>
#include <TFormula.h>
#include <TF1.h>
#include <TFile.h>
#include <TKey.h>
#include <TCanvas.h>
#include <TStyle.h>
#include <TColor.h>
#include <TRandom.h>
#include <TRandom3.h>
#include <TObjString.h>
#include <Math/Minimizer.h>
#ifdef USE_MINUIT2
#include <Minuit2/Minuit2Minimizer.h>
#endif
#include <Math/MinimizerOptions.h>
#include <TLine.h>
#include <TBox.h>
#include <TEllipse.h>
#include <TArrow.h>
#include <TMarker.h>
#include <TPave.h>
#include <TLegend.h>
#include <TLegendEntry.h>
#include <TSpline.h>
#include <TText.h>
#include <TLatex.h>
#include <TWbox.h>
#include <TFrame.h>
#include <TVector2.h>
#include <TVector3.h>
#include <TRotation.h>
#include <TLorentzVector.h>
#include <TLorentzRotation.h>
#include <TPoint.h>

#include "TreeIOHelper.hpp"
#include "RubyFunctionObject.hpp"
#ifdef USE_MINUIT2
#include "Minuit2FunctionMinimizer.hpp"
#endif
%}

%include <std_string.i>
%include <carrays.i>

%array_class(int, IntArray)
%array_class(double, DoubleArray)

%include <std_vector.i>
%template(DoubleVector) std::vector<double>;

%include "root_types.i"
%include "root_core.i"
%include "root_math.i"
%include "root_list.i"
%include "root_attributes.i"
%include "root_graf.i"
%include "root_pave.i"
%include "root_axis.i"
%include "root_app.i"
%include "root_hist.i"
%include "root_hist2d.i"
%include "root_hist3d.i"
%include "root_tree.i"
%include "root_graph.i"
%include "root_func.i"
%include "root_file.i"
%include "root_canvas.i"
%include "root_style.i"
%include "root_cast.i"
%include "root_random.i"
%include "root_string.i"
%include "root_legend.i"
%include "root_text.i"
%include "root_spline.i"
%include "root_vector.i"

#ifdef USE_MINUIT2
%include "root_minuit2.i"
#endif
