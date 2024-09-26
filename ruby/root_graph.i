/**************************************************************************/
/* Graph classes                                                          */
/**************************************************************************/

%include "typemaps.i"

class TGraph : public TNamed, public TAttLine, public TAttFill, public TAttMarker {
public:
  TGraph();
  TGraph(Int_t n);
  TGraph(Int_t n, const Int_t *x, const Int_t *y);
  TGraph(Int_t n, const Float_t *x, const Float_t *y);
  TGraph(Int_t n, const Double_t *x, const Double_t *y);
  TGraph(const TGraph &gr);

  TGraph(const TVectorF &vx, const TVectorF &vy);
  TGraph(const TVectorD &vx, const TVectorD &vy);
  TGraph(const TH1 *h);
  TGraph(const TF1 *f, Option_t *option="");
  TGraph(const char *filename, const char *format="%lg %lg", Option_t *option="");
  virtual ~TGraph();

  virtual void          Apply(TF1 *f);
  virtual void          Browse(TBrowser *b);
  virtual Double_t      Chisquare(TF1 *f1, Option_t *option="") const;
  static Bool_t         CompareArg(const TGraph* gr, Int_t left, Int_t right);
  static Bool_t         CompareX(const TGraph* gr, Int_t left, Int_t right);
  static Bool_t         CompareY(const TGraph* gr, Int_t left, Int_t right);
  static Bool_t         CompareRadius(const TGraph* gr, Int_t left, Int_t right);
  virtual void          ComputeRange(Double_t &xmin, Double_t &ymin, Double_t &xmax, Double_t &ymax) const;
  virtual Int_t         DistancetoPrimitive(Int_t px, Int_t py);
  virtual void          Draw(Option_t *chopt="");
  virtual void          DrawGraph(Int_t n, const Int_t *x, const Int_t *y, Option_t *option="");
  virtual void          DrawGraph(Int_t n, const Float_t *x, const Float_t *y, Option_t *option="");
  virtual void          DrawGraph(Int_t n, const Double_t *x=0, const Double_t *y=0, Option_t *option="");
  virtual void          DrawPanel(); // *MENU*
  virtual Double_t      Eval(Double_t x, TSpline *spline=0, Option_t *option="") const;
  virtual void          ExecuteEvent(Int_t event, Int_t px, Int_t py);
  virtual void          Expand(Int_t newsize);
  virtual void          Expand(Int_t newsize, Int_t step);
  virtual TObject      *FindObject(const char *name) const;
  virtual TObject      *FindObject(const TObject *obj) const;
  virtual TFitResultPtr Fit(const char *formula ,Option_t *option="" ,Option_t *goption="", Axis_t xmin=0, Axis_t xmax=0); // *MENU*
  virtual TFitResultPtr Fit(TF1 *f1 ,Option_t *option="" ,Option_t *goption="", Axis_t xmin=0, Axis_t xmax=0);
  virtual void          FitPanel(); // *MENU*
  Bool_t                GetEditable() const;
  TF1                  *GetFunction(const char *name) const;
  TH1F                 *GetHistogram() const;
  TList                *GetListOfFunctions() const { return fFunctions; }
  virtual Double_t      GetCorrelationFactor() const;
  virtual Double_t      GetCovariance() const;
  virtual Double_t      GetMean(Int_t axis=1) const;
  virtual Double_t      GetRMS(Int_t axis=1) const;
  Int_t                 GetMaxSize() const {return fMaxSize;}
  Int_t                 GetN() const {return fNpoints;}
  virtual Double_t      GetErrorX(Int_t bin) const;
  virtual Double_t      GetErrorY(Int_t bin) const;
  virtual Double_t      GetErrorXhigh(Int_t bin) const;
  virtual Double_t      GetErrorXlow(Int_t bin)  const;
  virtual Double_t      GetErrorYhigh(Int_t bin) const;
  virtual Double_t      GetErrorYlow(Int_t bin)  const;
  Double_t             *GetX()  const {return fX;}
  Double_t             *GetY()  const {return fY;}
  virtual Double_t     *GetEX() const {return 0;}
  virtual Double_t     *GetEY() const {return 0;}
  virtual Double_t     *GetEXhigh() const {return 0;}
  virtual Double_t     *GetEXlow()  const {return 0;}
  virtual Double_t     *GetEYhigh() const {return 0;}
  virtual Double_t     *GetEYlow()  const {return 0;}
  virtual Double_t     *GetEXlowd()  const {return 0;}
  virtual Double_t     *GetEXhighd() const {return 0;}
  virtual Double_t     *GetEYlowd()  const {return 0;}
  virtual Double_t     *GetEYhighd() const {return 0;}
  Double_t              GetMaximum()  const {return fMaximum;}
  Double_t              GetMinimum()  const {return fMinimum;}
  TAxis                *GetXaxis() const ;
  TAxis                *GetYaxis() const ;
  virtual Int_t         GetPoint(Int_t i, Double_t &OUTPUT, Double_t &OUTPUT) const;
  virtual Double_t      GetPointX(Int_t i) const;
  virtual Double_t      GetPointY(Int_t i) const;

  virtual void          InitExpo(Double_t xmin=0, Double_t xmax=0);
  virtual void          InitGaus(Double_t xmin=0, Double_t xmax=0);
  virtual void          InitPolynom(Double_t xmin=0, Double_t xmax=0);
  virtual Int_t         InsertPoint(); // *MENU*
  virtual Double_t      Integral(Int_t first=0, Int_t last=-1) const;
  virtual Bool_t        IsEditable() const {return !TestBit(kNotEditable);}
  virtual Int_t         IsInside(Double_t x, Double_t y) const;
  virtual void          LeastSquareFit(Int_t m, Double_t *a, Double_t xmin=0, Double_t xmax=0);
  virtual void          LeastSquareLinearFit(Int_t n, Double_t &a0, Double_t &a1, Int_t &ifail, Double_t xmin=0, Double_t xmax=0);
  virtual Int_t         Merge(TCollection* list);
  virtual void          Paint(Option_t *chopt="");
  void                  PaintGraph(Int_t npoints, const Double_t *x, const Double_t *y, Option_t *chopt);
  void                  PaintGrapHist(Int_t npoints, const Double_t *x, const Double_t *y, Option_t *chopt);
  virtual void          PaintStats(TF1 *fit);
  virtual void          Print(Option_t *chopt="") const;
  virtual void          RecursiveRemove(TObject *obj);
  virtual Int_t         RemovePoint(); // *MENU*
  virtual Int_t         RemovePoint(Int_t ipoint);
  virtual void          SavePrimitive(std::ostream &out, Option_t *option = "");
  virtual void          SetEditable(Bool_t editable=kTRUE); // *TOGGLE* *GETTER=GetEditable
  virtual void          SetHistogram(TH1F *h) {fHistogram = h;}
  virtual void          SetMaximum(Double_t maximum=-1111); // *MENU*
  virtual void          SetMinimum(Double_t minimum=-1111); // *MENU*
  virtual void          Set(Int_t n);
  virtual void          SetPoint(Int_t i, Double_t x, Double_t y);
  virtual void          SetTitle(const char *title="");    // *MENU*
  virtual void          Sort(Bool_t (*greater)(const TGraph*, Int_t, Int_t)=&TGraph::CompareX,
                             Bool_t ascending=kTRUE, Int_t low=0, Int_t high=-1111);
  virtual void          UseCurrentStyle();
  void                  Zero(Int_t &k,Double_t AZ,Double_t BZ,Double_t E2,Double_t &X,Double_t &Y,Int_t maxiterations);

  %extend {
    Double_t getX(Int_t i) const { return $self->GetX()[i]; }
    Double_t getY(Int_t i) const { return $self->GetY()[i]; }
    Double_t getEX(Int_t i) const { return $self->GetEX()[i]; }
    Double_t getEY(Int_t i) const { return $self->GetEY()[i]; }
    Double_t getEXhigh(Int_t i) const { return $self->GetEXhigh()[i]; }
    Double_t getEXlow(Int_t i) const { return $self->GetEXlow()[i]; }
    Double_t getEYhigh(Int_t i) const { return $self->GetEYhigh()[i]; }
    Double_t getEYlow(Int_t i) const { return $self->GetEYlow()[i]; }

    TSpline3* GetSpline3(){
      TSpline3* spline=new TSpline3();
      if($self->GetN()!=0){
        using namespace std;
        cout << "N() = " << $self->GetN() << endl;
        $self->Eval($self->GetX()[0], spline, "S");
      }
      return spline;
    }
  }
};


class TGraphErrors : public TGraph {
public:
  TGraphErrors();
  TGraphErrors(Int_t n);
  TGraphErrors(Int_t n, const Float_t *x, const Float_t *y, const Float_t *ex=0, const Float_t *ey=0);
  TGraphErrors(Int_t n, const Double_t *x, const Double_t *y, const Double_t *ex=0, const Double_t *ey=0);
  TGraphErrors(const TVectorF &vx, const TVectorF &vy, const TVectorF &vex, const TVectorF &vey);
  TGraphErrors(const TVectorD &vx, const TVectorD &vy, const TVectorD &vex, const TVectorD &vey);
  TGraphErrors(const TGraphErrors &gr);

  TGraphErrors(const TH1 *h);
  TGraphErrors(const char *filename, const char *format="%lg %lg %lg %lg", Option_t *option="");
  virtual ~TGraphErrors();
  virtual void    Apply(TF1 *f);
  static Int_t    CalculateScanfFields(const char *fmt);
  virtual void    ComputeRange(Double_t &xmin, Double_t &ymin, Double_t &xmax, Double_t &ymax) const;
  Double_t        GetErrorX(Int_t bin)     const;
  Double_t        GetErrorY(Int_t bin)     const;
  Double_t        GetErrorXhigh(Int_t bin) const;
  Double_t        GetErrorXlow(Int_t bin)  const;
  Double_t        GetErrorYhigh(Int_t bin) const;
  Double_t        GetErrorYlow(Int_t bin)  const;
  Double_t       *GetEX() const {return fEX;}
  Double_t       *GetEY() const {return fEY;}
  virtual Int_t   Merge(TCollection* list);
  virtual void    Print(Option_t *chopt="") const;
  virtual void    SavePrimitive(std::ostream &out, Option_t *option = "");
  virtual void    SetPointError(Double_t ex, Double_t ey);  // *MENU
  virtual void    SetPointError(Int_t i, Double_t ex, Double_t ey);
};


class TGraphAsymmErrors : public TGraph {
public:
  TGraphAsymmErrors();
  TGraphAsymmErrors(Int_t n);
  TGraphAsymmErrors(Int_t n, const Float_t *x, const Float_t *y, const Float_t *exl=0, const Float_t *exh=0, const Float_t *eyl=0, const Float_t *eyh=0);
  TGraphAsymmErrors(Int_t n, const Double_t *x, const Double_t *y, const Double_t *exl=0, const Double_t *exh=0, const Double_t *eyl=0, const Double_t *eyh=0);
  TGraphAsymmErrors(const TVectorF &vx, const TVectorF &vy, const TVectorF &vexl, const TVectorF &vexh, const TVectorF &veyl, const TVectorF &veyh);
  TGraphAsymmErrors(const TVectorD &vx, const TVectorD &vy, const TVectorD &vexl, const TVectorD &vexh, const TVectorD &veyl, const TVectorD &veyh);
  TGraphAsymmErrors(const TGraphAsymmErrors &gr);

  TGraphAsymmErrors(const TH1 *h);
  TGraphAsymmErrors(const TH1* pass, const TH1* total, Option_t *option="");
  virtual ~TGraphAsymmErrors();

  virtual void    Apply(TF1 *f);
  virtual void    BayesDivide(const TH1* pass, const TH1* total, Option_t *opt="");
  virtual void    Divide(const TH1* pass, const TH1* total, Option_t *opt="cp");
  virtual void    ComputeRange(Double_t &xmin, Double_t &ymin, Double_t &xmax, Double_t &ymax) const;
  Double_t        GetErrorX(Int_t bin)   const;
  Double_t        GetErrorY(Int_t bin)   const;
  Double_t        GetErrorXlow(Int_t i)  const;
  Double_t        GetErrorXhigh(Int_t i) const;
  Double_t        GetErrorYlow(Int_t i)  const;
  Double_t        GetErrorYhigh(Int_t i) const;
  Double_t       *GetEXlow()  const {return fEXlow;}
  Double_t       *GetEXhigh() const {return fEXhigh;}
  Double_t       *GetEYlow()  const {return fEYlow;}
  Double_t       *GetEYhigh() const {return fEYhigh;}
  virtual Int_t   Merge(TCollection* list);
  virtual void    Print(Option_t *chopt="") const;
  virtual void    SavePrimitive(std::ostream &out, Option_t *option = "");
  virtual void    SetPointError(Double_t exl, Double_t exh, Double_t eyl, Double_t eyh); // *MENU*
  virtual void    SetPointError(Int_t i, Double_t exl, Double_t exh, Double_t eyl, Double_t eyh);
  virtual void    SetPointEXlow(Int_t i, Double_t exl);
  virtual void    SetPointEXhigh(Int_t i, Double_t exh);
  virtual void    SetPointEYlow(Int_t i, Double_t eyl);
  virtual void    SetPointEYhigh(Int_t i, Double_t eyh);
};


class TMultiGraph : public TNamed {
public:
  TMultiGraph();
  TMultiGraph(const char *name, const char *title);
  virtual ~TMultiGraph();

  virtual void      Add(TGraph *graph, Option_t *chopt="");
  virtual void      Add(TMultiGraph *multigraph, Option_t *chopt="");
  virtual void      Browse(TBrowser *b);
  virtual Int_t     DistancetoPrimitive(Int_t px, Int_t py);
  virtual void      Draw(Option_t *chopt="");
  virtual TFitResultPtr Fit(const char *formula ,Option_t *option="" ,Option_t *goption="", Axis_t xmin=0, Axis_t xmax=0);
  virtual TFitResultPtr Fit(TF1 *f1 ,Option_t *option="" ,Option_t *goption="", Axis_t rxmin=0, Axis_t rxmax=0);
  virtual void      FitPanel(); // *MENU*
  virtual Option_t *GetGraphDrawOption(const TGraph *gr) const;
  virtual void      LeastSquareLinearFit(Int_t ndata, Double_t &a0, Double_t &a1, Int_t &ifail, Double_t xmin, Double_t xmax);
  virtual void      LeastSquareFit(Int_t m, Double_t *a, Double_t xmin, Double_t xmax);
  virtual void      InitPolynom(Double_t xmin, Double_t xmax);
  virtual void      InitExpo(Double_t xmin, Double_t xmax);
  virtual void      InitGaus(Double_t xmin, Double_t xmax);
  virtual Int_t     IsInside(Double_t x, Double_t y) const;
  TH1F             *GetHistogram();
  TF1              *GetFunction(const char *name) const;
  TList            *GetListOfGraphs() const { return fGraphs; }
  /* TIter             begin() const; */
  /* TIter             end() const { return TIter::End(); } */
  TList            *GetListOfFunctions();  // non const method (create list if empty)
  const TList      *GetListOfFunctions() const { return fFunctions; }
  TAxis            *GetXaxis();
  TAxis            *GetYaxis();
  virtual void      Paint(Option_t *chopt="");
  void              PaintPads(Option_t *chopt="");
  void              PaintPolyLine3D(Option_t *chopt="");
  void              PaintReverse(Option_t *chopt="");
  virtual void      Print(Option_t *chopt="") const;
  virtual void      RecursiveRemove(TObject *obj);
  virtual void      SavePrimitive(std::ostream &out, Option_t *option = "");
  virtual void      SetMaximum(Double_t maximum=-1111);
  virtual void      SetMinimum(Double_t minimum=-1111);
};
