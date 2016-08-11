/**************************************************************************/
/* Function classes                                                       */
/**************************************************************************/

class TFormula : public TNamed
{
public:
  TFormula();
  virtual        ~TFormula();

  TFormula(const char *name, const char * formula = "", bool addToGlobList = true);
  TFormula(const char *name, const char * formula, int ndim, int npar, bool addToGlobList = true);
  TFormula(const TFormula &formula);
  //               TFormula(const char *name, Int_t nparams, Int_t ndims);

  void           AddParameter(const TString &name, Double_t value = 0) { DoAddParameter(name,value,true); }
  void           AddVariable(const TString &name, Double_t value = 0);
  void           AddVariables(const TString *vars, const Int_t size);
  Int_t          Compile(const char *expression="");
  virtual void   Copy(TObject &f1) const;
  virtual void   Clear(Option_t * option="");
  Double_t       Eval(Double_t x) const;
  Double_t       Eval(Double_t x, Double_t y) const;
  Double_t       Eval(Double_t x, Double_t y , Double_t z) const;
  Double_t       Eval(Double_t x, Double_t y , Double_t z , Double_t t ) const;
  Double_t       EvalPar(const Double_t *x, const Double_t *params=0) const;
  TString        GetExpFormula(Option_t *option="") const;
  const TObject *GetLinearPart(Int_t i) const;
  Int_t          GetNdim() const {return fNdim;}
  Int_t          GetNpar() const {return fNpar;}
  Int_t          GetNumber() const { return fNumber; }
  const char *   GetParName(Int_t ipar) const;
  Int_t          GetParNumber(const char * name) const;
  Double_t       GetParameter(const char * name) const;
  Double_t       GetParameter(Int_t param) const;
  Double_t*      GetParameters() const;
  void           GetParameters(Double_t *params) const;
  Double_t       GetVariable(const char *name) const;
  Int_t          GetVarNumber(const char *name) const;
  TString        GetVarName(Int_t ivar) const;
  Bool_t         IsValid() const { return fReadyToExecute && fClingInitialized; }
  Bool_t         IsLinear() const { return TestBit(kLinear); }
  void           Print(Option_t *option = "") const;
  void           SetName(const char* name);
  void           SetParameter(const char* name, Double_t value);
  void           SetParameter(Int_t param, Double_t value);
  void           SetParameters(const Double_t *params);
  //void           SetParameters(const pair<TString,Double_t> *params, const Int_t size);
  void           SetParameters(Double_t p0,Double_t p1,Double_t p2=0,Double_t p3=0,Double_t p4=0,
                               Double_t p5=0,Double_t p6=0,Double_t p7=0,Double_t p8=0,
                               Double_t p9=0,Double_t p10=0); // *MENU*
  void           SetParName(Int_t ipar, const char *name);
  void           SetParNames(const char *name0="p0",const char *name1="p1",const char
                             *name2="p2",const char *name3="p3",const char
                             *name4="p4", const char *name5="p5",const char *name6="p6",const char *name7="p7",const char
                             *name8="p8",const char *name9="p9",const char *name10="p10"); // *MENU*
  void           SetVariable(const TString &name, Double_t value);
  void           SetVariables(const std::pair<TString,Double_t> *vars, const Int_t size);
};


class TF1 : public TNamed, public TAttLine, public TAttFill, public TAttMarker {
public:
  TF1();
  TF1(const char *name, const char *formula, Double_t xmin=0, Double_t xmax = 1);
  TF1(const char *name, Double_t xmin, Double_t xmax, Int_t npar,Int_t ndim = 1);
#ifndef __CINT__
  TF1(const char *name, Double_t (*fcn)(Double_t *, Double_t *), Double_t xmin=0, Double_t xmax=1, Int_t npar=0, Int_t ndim = 1);
  TF1(const char *name, Double_t (*fcn)(const Double_t *, const Double_t *), Double_t xmin=0, Double_t xmax=1, Int_t npar=0,Int_t ndim = 1);
#endif

  // Constructors using functors (compiled mode only)
  TF1(const char *name, ROOT::Math::ParamFunctor f, Double_t xmin = 0, Double_t xmax = 1, Int_t npar = 0,Int_t ndim = 1);

  // Template constructors from any  C++ callable object,  defining  the operator() (double * , double *)
  // and returning a double.
  // The class name is not needed when using compile code, while it is required when using
  // interpreted code via the specialized constructor with void *.
  // An instance of the C++ function class or its pointer can both be used. The former is reccomended when using
  // C++ compiled code, but if CINT compatibility is needed, then a pointer to the function class must be used.
  // xmin and xmax specify the plotting range,  npar is the number of parameters.
  // See the tutorial math/exampleFunctor.C for an example of using this constructor
  template <typename Func>
  TF1(const char *name, Func f, Double_t xmin, Double_t xmax, Int_t npar,Int_t ndim = 1 );
   
  // backward compatible interface
  template <typename Func>
  TF1(const char *name, Func f, Double_t xmin, Double_t xmax, Int_t npar, const char *   ) :
    TNamed(name,name), TAttLine(), TAttFill(), TAttMarker(),
    fXmin(xmin), fXmax(xmax),
    fNpar(npar), fNdim(1),
    fNpx(100), fType(1),
    fNpfits(0), fNDF(0), fChisquare(0),
    fMinimum(-1111), fMaximum(-1111),
    fParErrors(std::vector<Double_t>(npar)),
    fParMin(std::vector<Double_t>(npar)),
    fParMax(std::vector<Double_t>(npar)),
    fParent(0), fHistogram(0),
    fMethodCall(0),
    fNormalized(false), fNormIntegral(0),
    fFunctor(ROOT::Math::ParamFunctor(f)),
    fFormula(0),
    fParams(new TF1Parameters(npar) )
  {
    DoInitialize();
  }


  template <class PtrObj, typename MemFn>
  TF1(const char *name, const  PtrObj& p, MemFn memFn, Double_t xmin, Double_t xmax, Int_t npar,Int_t ndim = 1) :
    TNamed(name,name), TAttLine(), TAttFill(), TAttMarker(),
    fXmin(xmin), fXmax(xmax),
    fNpar(npar), fNdim(ndim),
    fNpx(100), fType(1),
    fNpfits(0), fNDF(0), fChisquare(0),
    fMinimum(-1111), fMaximum(-1111),
    fParErrors(std::vector<Double_t>(npar)),
    fParMin(std::vector<Double_t>(npar)),
    fParMax(std::vector<Double_t>(npar)),
    fParent(0), fHistogram(0),
    fMethodCall(0),
    fNormalized(false), fNormIntegral(0),
    fFunctor   ( ROOT::Math::ParamFunctor(p,memFn) ),
    fFormula(0),
    fParams(new TF1Parameters(npar) )
  {
    DoInitialize();
  }
  // backward compatible interface
  template <class PtrObj, typename MemFn>
  TF1(const char *name, const  PtrObj& p, MemFn memFn, Double_t xmin, Double_t xmax, Int_t npar,const char * , const char * ) :
    TNamed(name,name), TAttLine(), TAttFill(), TAttMarker(),
    fXmin(xmin), fXmax(xmax),
    fNpar(npar), fNdim(1),
    fNpx(100), fType(1),
    fNpfits(0), fNDF(0), fChisquare(0),
    fMinimum(-1111), fMaximum(-1111),
    fParErrors(std::vector<Double_t>(npar)),
    fParMin(std::vector<Double_t>(npar)),
    fParMax(std::vector<Double_t>(npar)),
    fParent(0), fHistogram(0),
    fMethodCall(0),
    fNormalized(false), fNormIntegral(0),
    fFunctor   ( ROOT::Math::ParamFunctor(p,memFn) ),
    fFormula(0),
    fParams(new TF1Parameters(npar) )
  {
    DoInitialize();
  }

  %extend {
    static TF1* create(const char *name, VALUE o, Double_t xmin, Double_t xmax, Int_t npar)
    {
      return new TF1(name, rubyroot::RubyFunctionObject(o, npar), xmin, xmax, npar, "RubyFunctionObject");
    }
  }


  TF1(const TF1 &f1);

  virtual   ~TF1();
  virtual void     AddParameter(const TString &name, Double_t value) { if (fFormula) fFormula->AddParameter(name,value); }
  // virtual void     AddParameters(const pair<TString,Double_t> *pairs, Int_t size) { fFormula->AddParameters(pairs,size); }
  // virtual void     AddVariable(const TString &name, Double_t value = 0) { if (fFormula) fFormula->AddVariable(name,value); }
  // virtual void     AddVariables(const TString *vars, Int_t size) { if (fFormula) fFormula->AddVariables(vars,size); }
  virtual Bool_t   AddToGlobalList(Bool_t on = kTRUE);
  virtual void     Browse(TBrowser *b);
  virtual void     Copy(TObject &f1) const;
  virtual Double_t Derivative (Double_t x, Double_t *params=0, Double_t epsilon=0.001) const;
  virtual Double_t Derivative2(Double_t x, Double_t *params=0, Double_t epsilon=0.001) const;
  virtual Double_t Derivative3(Double_t x, Double_t *params=0, Double_t epsilon=0.001) const;
  static  Double_t DerivativeError();
  virtual Int_t    DistancetoPrimitive(Int_t px, Int_t py);
  virtual void     Draw(Option_t *option="");
  virtual TF1     *DrawCopy(Option_t *option="") const;
  virtual TObject *DrawDerivative(Option_t *option="al"); // *MENU*
  virtual TObject *DrawIntegral(Option_t *option="al");   // *MENU*
  virtual void     DrawF1(Double_t xmin, Double_t xmax, Option_t *option="");
  virtual Double_t Eval(Double_t x, Double_t y=0, Double_t z=0, Double_t t=0) const;
  virtual Double_t EvalPar(const Double_t *x, const Double_t *params=0);
  virtual Double_t operator()(Double_t x, Double_t y=0, Double_t z = 0, Double_t t = 0) const;
  virtual Double_t operator()(const Double_t *x, const Double_t *params=0);
  virtual void     ExecuteEvent(Int_t event, Int_t px, Int_t py);
  virtual void     FixParameter(Int_t ipar, Double_t value);
  Double_t     GetChisquare() const {return fChisquare;}
  virtual TH1     *GetHistogram() const;
  virtual TH1     *CreateHistogram() { return DoCreateHistogram(fXmin, fXmax); }
  virtual TFormula *GetFormula() { return fFormula;}
  virtual const TFormula *GetFormula() const { return fFormula;}
  virtual TString  GetExpFormula(Option_t *option="") const { return (fFormula) ? fFormula->GetExpFormula(option) : ""; }
  virtual const TObject *GetLinearPart(Int_t i) const { return (fFormula) ? fFormula->GetLinearPart(i) : nullptr;}
  virtual Double_t GetMaximum(Double_t xmin=0, Double_t xmax=0, Double_t epsilon = 1.E-10, Int_t maxiter = 100, Bool_t logx = false) const;
  virtual Double_t GetMinimum(Double_t xmin=0, Double_t xmax=0, Double_t epsilon = 1.E-10, Int_t maxiter = 100, Bool_t logx = false) const;
  virtual Double_t GetMaximumX(Double_t xmin=0, Double_t xmax=0, Double_t epsilon = 1.E-10, Int_t maxiter = 100, Bool_t logx = false) const;
  virtual Double_t GetMinimumX(Double_t xmin=0, Double_t xmax=0, Double_t epsilon = 1.E-10, Int_t maxiter = 100, Bool_t logx = false) const;
  virtual Double_t GetMaximumStored() const {return fMaximum;}
  virtual Double_t GetMinimumStored() const {return fMinimum;}
  virtual Int_t    GetNpar() const { return fNpar;}
  virtual Int_t    GetNdim() const { return fNdim;}
  virtual Int_t    GetNDF() const;
  virtual Int_t    GetNpx() const {return fNpx;}
  TMethodCall    *GetMethodCall() const {return fMethodCall;}
  virtual Int_t    GetNumber() const { return (fFormula) ? fFormula->GetNumber() : 0;}
  virtual Int_t    GetNumberFreeParameters() const;
  virtual Int_t    GetNumberFitPoints() const {return fNpfits;}
  virtual char    *GetObjectInfo(Int_t px, Int_t py) const;
  TObject    *GetParent() const {return fParent;}
  virtual Double_t GetParameter(Int_t ipar) const {
    return (fFormula) ? fFormula->GetParameter(ipar) : fParams->GetParameter(ipar);
  }
  virtual Double_t GetParameter(const TString &name)  const {
    return (fFormula) ? fFormula->GetParameter(name) : fParams->GetParameter(name);
  }
  virtual Double_t *GetParameters() const {
    return (fFormula) ? fFormula->GetParameters() : const_cast<Double_t*>(fParams->GetParameters());
  }
  virtual void     GetParameters(Double_t *params) { if (fFormula) fFormula->GetParameters(params);
    else std::copy(fParams->ParamsVec().begin(), fParams->ParamsVec().end(), params); }
  virtual const char *GetParName(Int_t ipar) const {
    return (fFormula) ? fFormula->GetParName(ipar) : fParams->GetParName(ipar);
  }
  virtual Int_t    GetParNumber(const char* name) const {
    return (fFormula) ? fFormula->GetParNumber(name) : fParams->GetParNumber(name);
  }
  virtual Double_t GetParError(Int_t ipar) const;
  virtual const Double_t *GetParErrors() const {return fParErrors.data();}
  virtual void     GetParLimits(Int_t ipar, Double_t &parmin, Double_t &parmax) const;
  virtual Double_t GetProb() const;
  virtual Int_t    GetQuantiles(Int_t nprobSum, Double_t *q, const Double_t *probSum);
  virtual Double_t GetRandom();
  virtual Double_t GetRandom(Double_t xmin, Double_t xmax);
  virtual void     GetRange(Double_t &xmin, Double_t &xmax) const;
  virtual void     GetRange(Double_t &xmin, Double_t &ymin, Double_t &xmax, Double_t &ymax) const;
  virtual void     GetRange(Double_t &xmin, Double_t &ymin, Double_t &zmin, Double_t &xmax, Double_t &ymax, Double_t &zmax) const;
  virtual Double_t GetSave(const Double_t *x);
  virtual Double_t GetX(Double_t y, Double_t xmin=0, Double_t xmax=0, Double_t epsilon = 1.E-10, Int_t maxiter = 100, Bool_t logx = false) const;
  virtual Double_t GetXmin() const {return fXmin;}
  virtual Double_t GetXmax() const {return fXmax;}
  TAxis           *GetXaxis() const ;
  TAxis           *GetYaxis() const ;
  TAxis           *GetZaxis() const ;
  virtual Double_t GetVariable(const TString &name) { return (fFormula) ? fFormula->GetVariable(name) : 0;}
  virtual Double_t GradientPar(Int_t ipar, const Double_t *x, Double_t eps=0.01);
  virtual void     GradientPar(const Double_t *x, Double_t *grad, Double_t eps=0.01);
  virtual void     InitArgs(const Double_t *x, const Double_t *params);
  static  void     InitStandardFunctions();
  virtual Double_t Integral(Double_t a, Double_t b, Double_t epsrel=1.e-12);
  virtual Double_t IntegralOneDim(Double_t a, Double_t b, Double_t epsrel, Double_t epsabs, Double_t &err);
  virtual Double_t IntegralError(Double_t a, Double_t b, const Double_t *params=0, const Double_t *covmat=0, Double_t epsilon=1.E-2);
  virtual Double_t IntegralError(Int_t n, const Double_t * a, const Double_t * b, const Double_t *params=0, const Double_t *covmat=0, Double_t epsilon=1.E-2);
  // virtual Double_t IntegralFast(const TGraph *g, Double_t a, Double_t b, Double_t *params=0);
  virtual Double_t IntegralFast(Int_t num, Double_t *x, Double_t *w, Double_t a, Double_t b, Double_t *params=0, Double_t epsilon=1e-12);
  virtual Double_t IntegralMultiple(Int_t n, const Double_t *a, const Double_t *b, Int_t maxpts, Double_t epsrel, Double_t epsabs ,Double_t &relerr,Int_t &nfnevl, Int_t &ifail);
  virtual Double_t IntegralMultiple(Int_t n, const Double_t *a, const Double_t *b, Int_t /*minpts*/, Int_t maxpts, Double_t epsrel, Double_t &relerr,Int_t &nfnevl, Int_t &ifail) {
    return  IntegralMultiple(n,a,b,maxpts, epsrel, epsrel, relerr, nfnevl, ifail);
  }
  virtual Double_t IntegralMultiple(Int_t n, const Double_t *a, const Double_t *b, Double_t epsrel, Double_t &relerr);
  virtual Bool_t   IsEvalNormalized() const { return fNormalized; }
  /// return kTRUE if the point is inside the function range
  virtual Bool_t   IsInside(const Double_t *x) const { return !(  ( x[0] < fXmin) || ( x[0] > fXmax ) ); }
  virtual Bool_t   IsLinear() const { return (fFormula) ? fFormula->IsLinear() : false;}
  virtual Bool_t   IsValid() const;
  virtual void     Print(Option_t *option="") const;
  virtual void     Paint(Option_t *option="");
  virtual void     ReleaseParameter(Int_t ipar);
  virtual void     Save(Double_t xmin, Double_t xmax, Double_t ymin, Double_t ymax, Double_t zmin, Double_t zmax);
  virtual void     SavePrimitive(std::ostream &out, Option_t *option = "");
  virtual void     SetChisquare(Double_t chi2) {fChisquare = chi2;}
  virtual void     SetFitResult(const ROOT::Fit::FitResult & result, const Int_t * indpar = 0);
  template <class PtrObj, typename MemFn>
  void SetFunction( PtrObj& p, MemFn memFn );
  template <typename Func>
  void SetFunction( Func f );
  virtual void     SetMaximum(Double_t maximum=-1111); // *MENU*
  virtual void     SetMinimum(Double_t minimum=-1111); // *MENU*
  virtual void     SetNDF(Int_t ndf);
  virtual void     SetNumberFitPoints(Int_t npfits) {fNpfits = npfits;}
  virtual void     SetNormalized(Bool_t flag) { fNormalized = flag; Update(); }
  virtual void     SetNpx(Int_t npx=100); // *MENU*
  virtual void     SetParameter(Int_t param, Double_t value) {
    (fFormula) ? fFormula->SetParameter(param,value) : fParams->SetParameter(param,value);
    Update();
  }
  virtual void     SetParameter(const TString &name, Double_t value) {
    (fFormula) ? fFormula->SetParameter(name,value) : fParams->SetParameter(name,value);
    Update();
  }
  virtual void     SetParameters(const Double_t *params) {
    (fFormula) ? fFormula->SetParameters(params) : fParams->SetParameters(params);
    Update(); 
  }
  virtual void     SetParameters(Double_t p0,Double_t p1,Double_t p2=0,Double_t p3=0,Double_t p4=0,
                                 Double_t p5=0,Double_t p6=0,Double_t p7=0,Double_t p8=0,
                                 Double_t p9=0,Double_t p10=0) {
    if (fFormula) fFormula->SetParameters(p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10);
    else          fParams->SetParameters(p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10);
    Update();
  } // *MENU*
  virtual void     SetParName(Int_t ipar, const char *name);
  virtual void     SetParNames(const char *name0="p0",const char *name1="p1",const char *name2="p2",
                               const char *name3="p3",const char *name4="p4", const char *name5="p5",
                               const char *name6="p6",const char *name7="p7",const char *name8="p8",
                               const char *name9="p9",const char *name10="p10"); // *MENU*
  virtual void     SetParError(Int_t ipar, Double_t error);
  virtual void     SetParErrors(const Double_t *errors);
  virtual void     SetParLimits(Int_t ipar, Double_t parmin, Double_t parmax);
  virtual void     SetParent(TObject *p=0) {fParent = p;}
  virtual void     SetRange(Double_t xmin, Double_t xmax); // *MENU*
  virtual void     SetRange(Double_t xmin, Double_t ymin,  Double_t xmax, Double_t ymax);
  virtual void     SetRange(Double_t xmin, Double_t ymin, Double_t zmin,  Double_t xmax, Double_t ymax, Double_t zmax);
  virtual void     SetSavedPoint(Int_t point, Double_t value);
  virtual void     SetTitle(const char *title=""); // *MENU*
  virtual void     Update();

  static  TF1     *GetCurrent();
  static  void     AbsValue(Bool_t reject=kTRUE);
  static  void     RejectPoint(Bool_t reject=kTRUE);
  static  Bool_t   RejectedPoint();
  static  void     SetCurrent(TF1 *f1);

  //Moments
  virtual Double_t Moment(Double_t n, Double_t a, Double_t b, const Double_t *params=0, Double_t epsilon=0.000001);
  virtual Double_t CentralMoment(Double_t n, Double_t a, Double_t b, const Double_t *params=0, Double_t epsilon=0.000001);
  virtual Double_t Mean(Double_t a, Double_t b, const Double_t *params=0, Double_t epsilon=0.000001) {return Moment(1,a,b,params,epsilon);}
  virtual Double_t Variance(Double_t a, Double_t b, const Double_t *params=0, Double_t epsilon=0.000001) {return CentralMoment(2,a,b,params,epsilon);}

  //some useful static utility functions to compute sampling points for Integral
  //static  void     CalcGaussLegendreSamplingPoints(TGraph *g, Double_t eps=3.0e-11);
  //static  TGraph  *CalcGaussLegendreSamplingPoints(Int_t num=21, Double_t eps=3.0e-11);
  static  void     CalcGaussLegendreSamplingPoints(Int_t num, Double_t *x, Double_t *w, Double_t eps=3.0e-11);
};
