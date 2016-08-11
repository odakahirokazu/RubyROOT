/**************************************************************************/
/* Histogram classes                                                      */
/**************************************************************************/

%nodefault;
class TH1 : public TNamed, public TAttLine, public TAttFill, public TAttMarker {
public:
  enum  EBinErrorOpt;

public:
   virtual Bool_t   Add(TF1 *h1, Double_t c1=1, Option_t *option="");
   virtual Bool_t   Add(const TH1 *h1, Double_t c1=1);
   virtual Bool_t   Add(const TH1 *h, const TH1 *h2, Double_t c1=1, Double_t c2=1); // *MENU*
   virtual void     AddBinContent(Int_t bin);
   virtual void     AddBinContent(Int_t bin, Double_t w);
   static  void     AddDirectory(Bool_t add=kTRUE);
   static  Bool_t   AddDirectoryStatus();
   virtual void     Browse(TBrowser *b);
   virtual Bool_t   CanExtendAllAxes() const;
   virtual Double_t Chi2Test(const TH1* h2, Option_t *option = "UU", Double_t *res = 0) const;
   virtual Double_t Chi2TestX(const TH1* h2, Double_t &chi2, Int_t &ndf, Int_t &igood,Option_t *option = "UU",  Double_t *res = 0) const;
   virtual Double_t Chisquare(TF1 * f1, Option_t *option = "") const;
   virtual void     ClearUnderflowAndOverflow();
   virtual Double_t ComputeIntegral(Bool_t onlyPositive = false);
   TObject*         Clone(const char* newname=0) const;
   virtual void     Copy(TObject &hnew) const;
   virtual void     DirectoryAutoAdd(TDirectory *);
   virtual Int_t    DistancetoPrimitive(Int_t px, Int_t py);
   virtual Bool_t   Divide(TF1 *f1, Double_t c1=1);
   virtual Bool_t   Divide(const TH1 *h1);
   virtual Bool_t   Divide(const TH1 *h1, const TH1 *h2, Double_t c1=1, Double_t c2=1, Option_t *option=""); // *MENU*
   virtual void     Draw(Option_t *option="");
   virtual TH1     *DrawCopy(Option_t *option="", const char * name_postfix = "_copy") const;
   virtual TH1     *DrawNormalized(Option_t *option="", Double_t norm=1) const;
   virtual void     DrawPanel(); // *MENU*
   virtual Int_t    BufferEmpty(Int_t action=0);
   virtual void     Eval(TF1 *f1, Option_t *option="");
   virtual void     ExecuteEvent(Int_t event, Int_t px, Int_t py);
   virtual void     ExtendAxis(Double_t x, TAxis *axis);
   virtual TH1     *FFT(TH1* h_output, Option_t *option);
   virtual Int_t    Fill(Double_t x);
   virtual Int_t    Fill(Double_t x, Double_t w);
   virtual Int_t    Fill(const char *name, Double_t w);
   virtual void     FillN(Int_t ntimes, const Double_t *x, const Double_t *w, Int_t stride=1);
   virtual void     FillN(Int_t, const Double_t *, const Double_t *, const Double_t *, Int_t) {;}
   virtual void     FillRandom(const char *fname, Int_t ntimes=5000);
   virtual void     FillRandom(TH1 *h, Int_t ntimes=5000);
   virtual Int_t    FindBin(Double_t x, Double_t y=0, Double_t z=0);
   virtual Int_t    FindFixBin(Double_t x, Double_t y=0, Double_t z=0) const;
   virtual Int_t    FindFirstBinAbove(Double_t threshold=0, Int_t axis=1) const;
   virtual Int_t    FindLastBinAbove (Double_t threshold=0, Int_t axis=1) const;
   virtual TObject *FindObject(const char *name) const;
   virtual TObject *FindObject(const TObject *obj) const;
   virtual TFitResultPtr    Fit(const char *formula ,Option_t *option="" ,Option_t *goption="", Double_t xmin=0, Double_t xmax=0); // *MENU*
   virtual TFitResultPtr    Fit(TF1 *f1 ,Option_t *option="" ,Option_t *goption="", Double_t xmin=0, Double_t xmax=0);
   virtual void     FitPanel(); // *MENU*
   TH1             *GetAsymmetry(TH1* h2, Double_t c2=1, Double_t dc2=0);
   Int_t            GetBufferLength() const {return fBuffer ? (Int_t)fBuffer[0] : 0;}
   Int_t            GetBufferSize  () const {return fBufferSize;}
   const   Double_t *GetBuffer() const {return fBuffer;}
   static  Int_t    GetDefaultBufferSize();
   virtual Double_t *GetIntegral();
   TH1             *GetCumulative(Bool_t forward = kTRUE, const char* suffix = "_cumulative") const;

   TList           *GetListOfFunctions() const { return fFunctions; }

   virtual Int_t    GetNdivisions(Option_t *axis="X") const;
   virtual Color_t  GetAxisColor(Option_t *axis="X") const;
   virtual Color_t  GetLabelColor(Option_t *axis="X") const;
   virtual Style_t  GetLabelFont(Option_t *axis="X") const;
   virtual Float_t  GetLabelOffset(Option_t *axis="X") const;
   virtual Float_t  GetLabelSize(Option_t *axis="X") const;
   virtual Style_t  GetTitleFont(Option_t *axis="X") const;
   virtual Float_t  GetTitleOffset(Option_t *axis="X") const;
   virtual Float_t  GetTitleSize(Option_t *axis="X") const;
   virtual Float_t  GetTickLength(Option_t *axis="X") const;
   virtual Float_t  GetBarOffset() const {return Float_t(0.001*Float_t(fBarOffset));}
   virtual Float_t  GetBarWidth() const  {return Float_t(0.001*Float_t(fBarWidth));}
   virtual Int_t    GetContour(Double_t *levels=0);
   virtual Double_t GetContourLevel(Int_t level) const;
   virtual Double_t GetContourLevelPad(Int_t level) const;

   virtual Int_t    GetBin(Int_t binx, Int_t biny=0, Int_t binz=0) const;
   virtual void     GetBinXYZ(Int_t binglobal, Int_t &binx, Int_t &biny, Int_t &binz) const;
   virtual Double_t GetBinCenter(Int_t bin) const;
   virtual Double_t GetBinContent(Int_t bin) const;
   virtual Double_t GetBinContent(Int_t bin, Int_t) const { return GetBinContent(bin); }
   virtual Double_t GetBinContent(Int_t bin, Int_t, Int_t) const { return GetBinContent(bin); }
   virtual Double_t GetBinError(Int_t bin) const;
   virtual Double_t GetBinError(Int_t binx, Int_t biny) const { return GetBinError(GetBin(binx, biny)); } // for 2D histograms only
   virtual Double_t GetBinError(Int_t binx, Int_t biny, Int_t binz) const { return GetBinError(GetBin(binx, biny, binz)); } // for 3D histograms only
   virtual Double_t GetBinErrorLow(Int_t bin) const;
   virtual Double_t GetBinErrorUp(Int_t bin) const;
   virtual EBinErrorOpt  GetBinErrorOption() const { return fBinStatErrOpt; }
   virtual Double_t GetBinLowEdge(Int_t bin) const;
   virtual Double_t GetBinWidth(Int_t bin) const;
   virtual Double_t GetBinWithContent(Double_t c, Int_t &binx, Int_t firstx=0, Int_t lastx=0,Double_t maxdiff=0) const;
   virtual void     GetCenter(Double_t *center) const;
   static  Bool_t   GetDefaultSumw2();
   TDirectory      *GetDirectory() const {return fDirectory;}
   virtual Double_t GetEntries() const;
   virtual Double_t GetEffectiveEntries() const;
   virtual TF1     *GetFunction(const char *name) const;
   virtual Int_t    GetDimension() const { return fDimension; }
   virtual Double_t GetKurtosis(Int_t axis=1) const;
   virtual void     GetLowEdge(Double_t *edge) const;
   virtual Double_t GetMaximum(Double_t maxval=FLT_MAX) const;
   virtual Int_t    GetMaximumBin() const;
   virtual Int_t    GetMaximumBin(Int_t &locmax, Int_t &locmay, Int_t &locmaz) const;
   virtual Double_t GetMaximumStored() const {return fMaximum;}
   virtual Double_t GetMinimum(Double_t minval=-FLT_MAX) const;
   virtual Int_t    GetMinimumBin() const;
   virtual Int_t    GetMinimumBin(Int_t &locmix, Int_t &locmiy, Int_t &locmiz) const;
   virtual Double_t GetMinimumStored() const {return fMinimum;}
   virtual Double_t GetMean(Int_t axis=1) const;
   virtual Double_t GetMeanError(Int_t axis=1) const;
   virtual Int_t    GetNbinsX() const {return fXaxis.GetNbins();}
   virtual Int_t    GetNbinsY() const {return fYaxis.GetNbins();}
   virtual Int_t    GetNbinsZ() const {return fZaxis.GetNbins();}
   virtual Int_t    GetNcells() const {return fNcells; }
   virtual Double_t GetNormFactor() const {return fNormFactor;}
   virtual char    *GetObjectInfo(Int_t px, Int_t py) const;
   Option_t        *GetOption() const {return fOption.Data();}

   TVirtualHistPainter *GetPainter(Option_t *option="");

   virtual Int_t    GetQuantiles(Int_t nprobSum, Double_t *q, const Double_t *probSum=0);
   virtual Double_t GetRandom() const;
   virtual void     GetStats(Double_t *stats) const;
   virtual Double_t GetStdDev(Int_t axis=1) const;
   virtual Double_t GetStdDevError(Int_t axis=1) const;
   virtual Double_t GetSumOfWeights() const;
   virtual TArrayD *GetSumw2() {return &fSumw2;}
   virtual const TArrayD *GetSumw2() const {return &fSumw2;}
   virtual Int_t    GetSumw2N() const {return fSumw2.fN;}
           Double_t GetRMS(Int_t axis=1) const { return GetStdDev(axis); }
           Double_t GetRMSError(Int_t axis=1) const { return GetStdDevError(axis); }

   virtual Double_t GetSkewness(Int_t axis=1) const;
           TAxis*   GetXaxis()  { return &fXaxis; }
           TAxis*   GetYaxis()  { return &fYaxis; }
           TAxis*   GetZaxis()  { return &fZaxis; }
     const TAxis*   GetXaxis() const { return &fXaxis; }
     const TAxis*   GetYaxis() const { return &fYaxis; }
     const TAxis*   GetZaxis() const { return &fZaxis; }
   virtual Double_t Integral(Option_t *option="") const;
   virtual Double_t Integral(Int_t binx1, Int_t binx2, Option_t *option="") const;
   virtual Double_t IntegralAndError(Int_t binx1, Int_t binx2, Double_t & err, Option_t *option="") const;
   virtual Double_t Interpolate(Double_t x);
   virtual Double_t Interpolate(Double_t x, Double_t y);
   virtual Double_t Interpolate(Double_t x, Double_t y, Double_t z);
           Bool_t   IsBinOverflow(Int_t bin) const;
           Bool_t   IsBinUnderflow(Int_t bin) const;
   virtual Double_t AndersonDarlingTest(const TH1 *h2, Option_t *option="") const;
   virtual Double_t AndersonDarlingTest(const TH1 *h2, Double_t &advalue) const;
   virtual Double_t KolmogorovTest(const TH1 *h2, Option_t *option="") const;
   virtual void     LabelsDeflate(Option_t *axis="X");
   virtual void     LabelsInflate(Option_t *axis="X");
   virtual void     LabelsOption(Option_t *option="h", Option_t *axis="X");
   virtual Long64_t Merge(TCollection *list);
   virtual Bool_t   Multiply(TF1 *h1, Double_t c1=1);
   virtual Bool_t   Multiply(const TH1 *h1);
   virtual Bool_t   Multiply(const TH1 *h1, const TH1 *h2, Double_t c1=1, Double_t c2=1, Option_t *option=""); // *MENU*
   virtual void     Paint(Option_t *option="");
   virtual void     Print(Option_t *option="") const;
   virtual void     PutStats(Double_t *stats);
   virtual TH1     *Rebin(Int_t ngroup=2, const char*newname="", const Double_t *xbins=0);  // *MENU*
   virtual TH1     *RebinX(Int_t ngroup=2, const char*newname="") { return Rebin(ngroup,newname, (Double_t*) 0); }
   virtual void     Rebuild(Option_t *option="");
   virtual void     RecursiveRemove(TObject *obj);
   virtual void     Reset(Option_t *option="");
   virtual void     ResetStats();
   virtual void     SavePrimitive(std::ostream &out, Option_t *option = "");
   virtual void     Scale(Double_t c1=1, Option_t *option="");
   virtual void     SetAxisColor(Color_t color=1, Option_t *axis="X");
   virtual void     SetAxisRange(Double_t xmin, Double_t xmax, Option_t *axis="X");
   virtual void     SetBarOffset(Float_t offset=0.25) {fBarOffset = Short_t(1000*offset);}
   virtual void     SetBarWidth(Float_t width=0.5) {fBarWidth = Short_t(1000*width);}
   virtual void     SetBinContent(Int_t bin, Double_t content);
   virtual void     SetBinContent(Int_t bin, Int_t, Double_t content) { SetBinContent(bin, content); }
   virtual void     SetBinContent(Int_t bin, Int_t, Int_t, Double_t content) { SetBinContent(bin, content); }
   virtual void     SetBinError(Int_t bin, Double_t error);
   virtual void     SetBinError(Int_t binx, Int_t biny, Double_t error);
   virtual void     SetBinError(Int_t binx, Int_t biny, Int_t binz, Double_t error);
   virtual void     SetBins(Int_t nx, Double_t xmin, Double_t xmax);
   virtual void     SetBins(Int_t nx, const Double_t *xBins);
   virtual void     SetBins(Int_t nx, Double_t xmin, Double_t xmax, Int_t ny, Double_t ymin, Double_t ymax);
   virtual void     SetBins(Int_t nx, const Double_t *xBins, Int_t ny, const Double_t *yBins);
   virtual void     SetBins(Int_t nx, Double_t xmin, Double_t xmax, Int_t ny, Double_t ymin, Double_t ymax,
                            Int_t nz, Double_t zmin, Double_t zmax);
   virtual void     SetBins(Int_t nx, const Double_t *xBins, Int_t ny, const Double_t * yBins, Int_t nz,
                            const Double_t *zBins);
   virtual void     SetBinsLength(Int_t = -1) { } //redefined in derived classes
   virtual void     SetBinErrorOption(EBinErrorOpt type) { fBinStatErrOpt = type; }
   virtual void     SetBuffer(Int_t buffersize, Option_t *option="");
   virtual UInt_t   SetCanExtend(UInt_t extendBitMask);
   virtual void     SetContent(const Double_t *content);
   virtual void     SetContour(Int_t nlevels, const Double_t *levels=0);
   virtual void     SetContourLevel(Int_t level, Double_t value);
   static  void     SetDefaultBufferSize(Int_t buffersize=1000);
   static  void     SetDefaultSumw2(Bool_t sumw2=kTRUE);
   virtual void     SetDirectory(TDirectory *dir);
   virtual void     SetEntries(Double_t n) {fEntries = n;};
   virtual void     SetError(const Double_t *error);
   virtual void     SetLabelColor(Color_t color=1, Option_t *axis="X");
   virtual void     SetLabelFont(Style_t font=62, Option_t *axis="X");
   virtual void     SetLabelOffset(Float_t offset=0.005, Option_t *axis="X");
   virtual void     SetLabelSize(Float_t size=0.02, Option_t *axis="X");

   /*
    * Set the minimum / maximum value for the Y axis (1-D histograms) or Z axis (2-D histograms)
    *   By default the maximum / minimum value used in drawing is the maximum / minimum value of the histogram
    * plus a margin of 10%. If these functions are called, the values are used without any extra margin.
    */
   virtual void     SetMaximum(Double_t maximum = -1111) { fMaximum = maximum; }; // *MENU*
   virtual void     SetMinimum(Double_t minimum = -1111) { fMinimum = minimum; }; // *MENU*

   virtual void     SetName(const char *name); // *MENU*
   virtual void     SetNameTitle(const char *name, const char *title);
   virtual void     SetNdivisions(Int_t n=510, Option_t *axis="X");
   virtual void     SetNormFactor(Double_t factor=1) {fNormFactor = factor;}
   virtual void     SetStats(Bool_t stats=kTRUE); // *MENU*
   virtual void     SetOption(Option_t *option=" ") {fOption = option;}
   virtual void     SetTickLength(Float_t length=0.02, Option_t *axis="X");
   virtual void     SetTitleFont(Style_t font=62, Option_t *axis="X");
   virtual void     SetTitleOffset(Float_t offset=1, Option_t *axis="X");
   virtual void     SetTitleSize(Float_t size=0.02, Option_t *axis="X");
   virtual void     SetTitle(const char *title);  // *MENU*
   virtual void     SetXTitle(const char *title) {fXaxis.SetTitle(title);}
   virtual void     SetYTitle(const char *title) {fYaxis.SetTitle(title);}
   virtual void     SetZTitle(const char *title) {fZaxis.SetTitle(title);}
   virtual TH1     *ShowBackground(Int_t niter=20, Option_t *option="same"); // *MENU*
   virtual Int_t    ShowPeaks(Double_t sigma=2, Option_t *option="", Double_t threshold=0.05); // *MENU*
   virtual void     Smooth(Int_t ntimes=1, Option_t *option=""); // *MENU*
   static  void     SmoothArray(Int_t NN, Double_t *XX, Int_t ntimes=1);
   static  void     StatOverflows(Bool_t flag=kTRUE);
   virtual void     Sumw2(Bool_t flag = kTRUE);
   void             UseCurrentStyle();
   static  TH1     *TransformHisto(TVirtualFFT *fft, TH1* h_output,  Option_t *option);


   // TODO: Remove obsolete methods in v6-04
   virtual Double_t GetCellContent(Int_t binx, Int_t biny) const
                        { Obsolete("GetCellContent", "v6-00", "v6-04"); return GetBinContent(GetBin(binx, biny)); }
   virtual Double_t GetCellError(Int_t binx, Int_t biny) const
                        { Obsolete("GetCellError", "v6-00", "v6-04"); return GetBinError(binx, biny); }
   virtual void     RebinAxis(Double_t x, TAxis *axis)
                        { Obsolete("RebinAxis", "v6-00", "v6-04"); ExtendAxis(x, axis); }
   virtual void     SetCellContent(Int_t binx, Int_t biny, Double_t content)
                        { Obsolete("SetCellContent", "v6-00", "v6-04"); SetBinContent(GetBin(binx, biny), content); }
   virtual void     SetCellError(Int_t binx, Int_t biny, Double_t content)
                        { Obsolete("SetCellError", "v6-00", "v6-04"); SetBinError(binx, biny, content); }
};
%default;


class TH1C : public TH1
{
public:
  TH1C();
  TH1C(const char *name,const char *title,Int_t nbinsx,Double_t xlow,Double_t xup);
  TH1C(const char *name,const char *title,Int_t nbinsx,const Double_t *xbins);
  %extend {
    static TH1C* create(const char *name, const char *title, Int_t nbinsx, Double_t xlow, Double_t xup)
    {
      return new TH1C(name, title, nbinsx, xlow, xup);
    }

    static TH1C* create(const char *name, const char *title, Int_t nbinsx, const Double_t *xbins)
    {
      return new TH1C(name, title, nbinsx, xbins);
    }
  }

  TH1C(const TH1C &h1d);
  virtual ~TH1C();
};


class TH1S : public TH1
{
public:
  TH1S();
  TH1S(const char *name,const char *title,Int_t nbinsx,Double_t xlow,Double_t xup);
  TH1S(const char *name,const char *title,Int_t nbinsx,const Double_t *xbins);
  %extend {
    static TH1S* create(const char *name, const char *title, Int_t nbinsx, Double_t xlow, Double_t xup)
    {
      return new TH1S(name, title, nbinsx, xlow, xup);
    }

    static TH1S* create(const char *name, const char *title, Int_t nbinsx, const Double_t *xbins)
    {
      return new TH1S(name, title, nbinsx, xbins);
    }
  }

  TH1S(const TH1S &h1d);
  virtual ~TH1S();
};


class TH1I : public TH1
{
public:
  TH1I();
  TH1I(const char *name,const char *title,Int_t nbinsx,Double_t xlow,Double_t xup);
  TH1I(const char *name,const char *title,Int_t nbinsx,const Double_t *xbins);
  %extend {
    static TH1I* create(const char *name, const char *title, Int_t nbinsx, Double_t xlow, Double_t xup)
    {
      return new TH1I(name, title, nbinsx, xlow, xup);
    }

    static TH1I* create(const char *name, const char *title, Int_t nbinsx, const Double_t *xbins)
    {
      return new TH1I(name, title, nbinsx, xbins);
    }
  }

  TH1I(const TH1I &h1d);
  virtual ~TH1I();
};


class TH1F : public TH1
{
public:
  TH1F();
  TH1F(const char *name,const char *title,Int_t nbinsx,Double_t xlow,Double_t xup);
  TH1F(const char *name,const char *title,Int_t nbinsx,const Double_t *xbins);
  %extend {
    static TH1F* create(const char *name, const char *title, Int_t nbinsx, Double_t xlow, Double_t xup)
    {
      return new TH1F(name, title, nbinsx, xlow, xup);
    }

    static TH1F* create(const char *name, const char *title, Int_t nbinsx, const Double_t *xbins)
    {
      return new TH1F(name, title, nbinsx, xbins);
    }
  }

  TH1F(const TH1F &h1d);
  virtual ~TH1F();
};


class TH1D : public TH1
{
public:
  TH1D();
  TH1D(const char *name,const char *title,Int_t nbinsx,Double_t xlow,Double_t xup);
  TH1D(const char *name,const char *title,Int_t nbinsx,const Double_t *xbins);
  %extend {
    static TH1D* create(const char *name, const char *title, Int_t nbinsx, Double_t xlow, Double_t xup)
    {
      return new TH1D(name, title, nbinsx, xlow, xup);
    }

    static TH1D* create(const char *name, const char *title, Int_t nbinsx, const Double_t *xbins)
    {
      return new TH1D(name, title, nbinsx, xbins);
    }
  }

  TH1D(const TH1D &h1d);
  virtual ~TH1D();
};
