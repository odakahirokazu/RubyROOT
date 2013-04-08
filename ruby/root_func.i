/**************************************************************************/
/* Function classes                                                       */
/**************************************************************************/

class TFormula : public TNamed
{
public:
  TFormula();
  TFormula(const char *name,const char *formula);
  TFormula(const TFormula &formula);
  virtual    ~TFormula();
  
public:
  void                Optimize();
  virtual void        Analyze(const char *schain, Int_t &err, Int_t offset=0);
  virtual Bool_t      AnalyzeFunction(TString &chaine, Int_t &err, Int_t offset=0);
  virtual Int_t       Compile(const char *expression="");
  virtual void        Copy(TObject &formula) const;
  virtual void        Clear(Option_t *option="");
  virtual char       *DefinedString(Int_t code);
  virtual Double_t    DefinedValue(Int_t code);
  virtual Int_t       DefinedVariable(TString &variable,Int_t &action);
  virtual Double_t    Eval(Double_t x, Double_t y=0, Double_t z=0, Double_t t=0) const;
  virtual Double_t    EvalParOld(const Double_t *x, const Double_t *params=0);
  virtual Double_t    EvalPar(const Double_t *x, const Double_t *params=0);;
  virtual const TObject *GetLinearPart(Int_t i);
  virtual Int_t       GetNdim() const ;
  virtual Int_t       GetNpar() const ;
  virtual Int_t       GetNumber() const ;
  virtual TString     GetExpFormula(Option_t *option="") const;
  Double_t            GetParameter(Int_t ipar) const;
  Double_t            GetParameter(const char *name) const;
  virtual Double_t   *GetParameters() const ;
  virtual void        GetParameters(Double_t *params);
  virtual const char *GetParName(Int_t ipar) const;
  virtual Int_t       GetParNumber(const char *name) const;
  virtual Bool_t      IsLinear() ;
  virtual Bool_t      IsNormalized() ;
  virtual void        Print(Option_t *option="") const; // *MENU*
  virtual void        ProcessLinear(TString &replaceformula);
  virtual void        SetNumber(Int_t number) ;
  virtual void        SetParameter(const char *name, Double_t parvalue);
  virtual void        SetParameter(Int_t ipar, Double_t parvalue);
  virtual void        SetParameters(const Double_t *params);
  virtual void        SetParameters(Double_t p0,Double_t p1,Double_t p2=0,Double_t p3=0,Double_t p4=0,
                                    Double_t p5=0,Double_t p6=0,Double_t p7=0,Double_t p8=0,
                                    Double_t p9=0,Double_t p10=0); // *MENU*
  virtual void        SetParName(Int_t ipar, const char *name);
  virtual void        SetParNames(const char *name0="p0",const char *name1="p1",const char
                                  *name2="p2",const char *name3="p3",const char
                                  *name4="p4", const char *name5="p5",const char *name6="p6",const char *name7="p7",const char
                                  *name8="p8",const char *name9="p9",const char *name10="p10"); // *MENU*
  virtual void        Update() ;

  static  void        SetMaxima(Int_t maxop=1000, Int_t maxpar=1000, Int_t maxconst=1000);
};


class TF1 : public TFormula, public TAttLine, public TAttFill, public TAttMarker
{
public:
  TF1();
  TF1(const char *name, const char *formula, Double_t xmin=0, Double_t xmax=1);
  TF1(const char *name, Double_t xmin, Double_t xmax, Int_t npar);
  TF1(const char *name, void *fcn, Double_t xmin, Double_t xmax, Int_t npar);

  %extend {
    static TF1* create(const char *name, VALUE o, Double_t xmin, Double_t xmax, Int_t npar)
    {
      return new TF1(name, rubyroot::RubyFunctionObject(o, npar), xmin, xmax, npar, "RubyFunctionObject");
    }
  }

  TF1(const TF1 &f1);
  virtual   ~TF1();
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
  virtual void     DrawF1(const char *formula, Double_t xmin, Double_t xmax, Option_t *option="");
  virtual Double_t Eval(Double_t x, Double_t y=0, Double_t z=0, Double_t t=0) const;
  virtual Double_t EvalPar(const Double_t *x, const Double_t *params=0);
  // for using TF1 as a callable object (functor)
  virtual Double_t operator()(Double_t x, Double_t y=0, Double_t z = 0, Double_t t = 0) const; 
  virtual Double_t operator()(const Double_t *x, const Double_t *params=0);  
  virtual void     ExecuteEvent(Int_t event, Int_t px, Int_t py);
  virtual void     FixParameter(Int_t ipar, Double_t value);
  Double_t     GetChisquare() const ;
  TH1     *GetHistogram() const;
  virtual Double_t GetMaximum(Double_t xmin=0, Double_t xmax=0, Double_t epsilon = 1.E-10, Int_t maxiter = 100, Bool_t logx = false) const;
  virtual Double_t GetMinimum(Double_t xmin=0, Double_t xmax=0, Double_t epsilon = 1.E-10, Int_t maxiter = 100, Bool_t logx = false) const;
  virtual Double_t GetMaximumX(Double_t xmin=0, Double_t xmax=0, Double_t epsilon = 1.E-10, Int_t maxiter = 100, Bool_t logx = false) const;
  virtual Double_t GetMinimumX(Double_t xmin=0, Double_t xmax=0, Double_t epsilon = 1.E-10, Int_t maxiter = 100, Bool_t logx = false) const;
  virtual Int_t    GetNDF() const;
  virtual Int_t    GetNpx() const ;
  TMethodCall    *GetMethodCall() const ;
  virtual Int_t    GetNumberFreeParameters() const;
  virtual Int_t    GetNumberFitPoints() const ;
  virtual char    *GetObjectInfo(Int_t px, Int_t py) const;
  TObject    *GetParent() const ;
  virtual Double_t GetParError(Int_t ipar) const;
  virtual Double_t *GetParErrors() const ;
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
  virtual Double_t GetXmin() const ;
  virtual Double_t GetXmax() const ;
  TAxis           *GetXaxis() const ;
  TAxis           *GetYaxis() const ;
  TAxis           *GetZaxis() const ;
  virtual Double_t GradientPar(Int_t ipar, const Double_t *x, Double_t eps=0.01);
  virtual void     GradientPar(const Double_t *x, Double_t *grad, Double_t eps=0.01);
  virtual void     InitArgs(const Double_t *x, const Double_t *params);
  static  void     InitStandardFunctions();
  virtual Double_t Integral(Double_t a, Double_t b, const Double_t *params=0, Double_t epsilon=1e-12);
  virtual Double_t Integral(Double_t ax, Double_t bx, Double_t ay, Double_t by, Double_t epsilon=1e-12);
  virtual Double_t Integral(Double_t ax, Double_t bx, Double_t ay, Double_t by, Double_t az, Double_t bz, Double_t epsilon=1e-12);
  virtual Double_t IntegralError(Double_t a, Double_t b, const Double_t *params=0, const Double_t *covmat=0, Double_t epsilon=1e-12);
  virtual Double_t IntegralError(Int_t n, const Double_t * a, const Double_t * b, const Double_t *params=0, const Double_t *covmat=0, Double_t epsilon=1e-12);
  //virtual Double_t IntegralFast(const TGraph *g, Double_t a, Double_t b, Double_t *params=0);
  virtual Double_t IntegralFast(Int_t num, Double_t *x, Double_t *w, Double_t a, Double_t b, Double_t *params=0, Double_t epsilon=1e-12);
  virtual Double_t IntegralMultiple(Int_t n, const Double_t *a, const Double_t *b, Int_t minpts, Int_t maxpts, Double_t epsilon, Double_t &relerr,Int_t &nfnevl, Int_t &ifail);
  virtual Double_t IntegralMultiple(Int_t n, const Double_t *a, const Double_t *b, Double_t epsilon, Double_t &relerr);
  virtual Bool_t   IsInside(const Double_t *x) const;
  virtual void     Paint(Option_t *option="");
  virtual void     Print(Option_t *option="") const;
  virtual void     ReleaseParameter(Int_t ipar);
  virtual void     Save(Double_t xmin, Double_t xmax, Double_t ymin, Double_t ymax, Double_t zmin, Double_t zmax);
  virtual void     SavePrimitive(ostream &out, Option_t *option = "");
  virtual void     SetChisquare(Double_t chi2) ;
  virtual void     SetFitResult(const ROOT::Fit::FitResult & result, const Int_t * indpar = 0);
  template <class PtrObj, typename MemFn> 
  void SetFunction( PtrObj& p, MemFn memFn );
  template <typename Func> 
  void SetFunction( Func f );
  virtual void     SetMaximum(Double_t maximum=-1111); // *MENU*
  virtual void     SetMinimum(Double_t minimum=-1111); // *MENU*
  virtual void     SetNDF(Int_t ndf);
  virtual void     SetNumberFitPoints(Int_t npfits) ;
  virtual void     SetNpx(Int_t npx=100); // *MENU*
  virtual void     SetParError(Int_t ipar, Double_t error);
  virtual void     SetParErrors(const Double_t *errors);
  virtual void     SetParLimits(Int_t ipar, Double_t parmin, Double_t parmax);
  virtual void     SetParent(TObject *p=0) ;
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
  virtual Double_t Mean(Double_t a, Double_t b, const Double_t *params=0, Double_t epsilon=0.000001) ;
  virtual Double_t Variance(Double_t a, Double_t b, const Double_t *params=0, Double_t epsilon=0.000001) ;

  //some useful static utility functions to compute sampling points for Integral
  //static  void     CalcGaussLegendreSamplingPoints(TGraph *g, Double_t eps=3.0e-11);
  //static  TGraph  *CalcGaussLegendreSamplingPoints(Int_t num=21, Double_t eps=3.0e-11);
  static  void     CalcGaussLegendreSamplingPoints(Int_t num, Double_t *x, Double_t *w, Double_t eps=3.0e-11);
};
