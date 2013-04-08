// 2D-histogram

class TH2 : public TH1
{
public:
  TH2(const TH2&);
  virtual ~TH2();
  virtual Int_t    BufferEmpty(Int_t action=0);
  virtual void     Copy(TObject &hnew) const;
  virtual Int_t    Fill(Double_t x, Double_t y);
  virtual Int_t    Fill(Double_t x, Double_t y, Double_t w);
  virtual Int_t    Fill(Double_t x, const char *namey, Double_t w);
  virtual Int_t    Fill(const char *namex, Double_t y, Double_t w);
  virtual Int_t    Fill(const char *namex, const char *namey, Double_t w);
  virtual void     FillN(Int_t, const Double_t *, const Double_t *, Int_t); ; //MayNotUse
  virtual void     FillN(Int_t ntimes, const Double_t *x, const Double_t *y, const Double_t *w, Int_t stride=1);
  virtual void     FillRandom(const char *fname, Int_t ntimes=5000);
  virtual void     FillRandom(TH1 *h, Int_t ntimes=5000);
  virtual Int_t    FindFirstBinAbove(Double_t threshold=0, Int_t axis=1) const;
  virtual Int_t    FindLastBinAbove (Double_t threshold=0, Int_t axis=1) const;
  virtual void     FitSlicesX(TF1 *f1=0,Int_t firstybin=0, Int_t lastybin=-1, Int_t cut=0, Option_t *option="QNR", TObjArray* arr = 0); // *MENU*
  virtual void     FitSlicesY(TF1 *f1=0,Int_t firstxbin=0, Int_t lastxbin=-1, Int_t cut=0, Option_t *option="QNR", TObjArray* arr = 0); // *MENU*
  virtual Double_t GetBinWithContent2(Double_t c, Int_t &binx, Int_t &biny, Int_t firstxbin=1, Int_t lastxbin=-1,Int_t firstybin=1, Int_t lastybin=-1, Double_t maxdiff=0) const;
  using TH1::GetBinErrorLow;
  using TH1::GetBinErrorUp;
  virtual Double_t GetBinErrorLow(Int_t binx, Int_t biny) ;
  virtual Double_t GetBinErrorUp(Int_t binx, Int_t biny) ;
  virtual Double_t GetCorrelationFactor(Int_t axis1=1,Int_t axis2=2) const;
  virtual Double_t GetCovariance(Int_t axis1=1,Int_t axis2=2) const;
  virtual void     GetRandom2(Double_t &x, Double_t &y);
  virtual void     GetStats(Double_t *stats) const;
  virtual Double_t Integral(Option_t *option="") const;
  //virtual Double_t Integral(Int_t, Int_t, Option_t * ="") const ;
  using TH1::Integral;
  virtual Double_t Integral(Int_t binx1, Int_t binx2, Int_t biny1, Int_t biny2, Option_t *option="") const;
  virtual Double_t Integral(Int_t, Int_t, Int_t, Int_t, Int_t, Int_t, Option_t * ="") const ;
  using TH1::IntegralAndError;
  virtual Double_t IntegralAndError(Int_t binx1, Int_t binx2, Int_t biny1, Int_t biny2, Double_t & err, Option_t *option="") const;
  virtual Double_t Interpolate(Double_t x);
  virtual Double_t Interpolate(Double_t x, Double_t y);
  virtual Double_t Interpolate(Double_t x, Double_t y, Double_t z);
  virtual Double_t KolmogorovTest(const TH1 *h2, Option_t *option="") const;
  virtual Long64_t Merge(TCollection *list);
  virtual TH2     *RebinX(Int_t ngroup=2, const char *newname="");
  virtual TH2     *RebinY(Int_t ngroup=2, const char *newname="");  
  virtual TH2     *Rebin2D(Int_t nxgroup=2, Int_t nygroup=2, const char *newname="");     
  TProfile     *ProfileX(const char *name="_pfx", Int_t firstybin=1, Int_t lastybin=-1, Option_t *option="") const;   // *MENU*
  TProfile     *ProfileY(const char *name="_pfy", Int_t firstxbin=1, Int_t lastxbin=-1, Option_t *option="") const;   // *MENU*
  TH1D      *ProjectionX(const char *name="_px", Int_t firstybin=0, Int_t lastybin=-1, Option_t *option="") const; // *MENU*
  TH1D      *ProjectionY(const char *name="_py", Int_t firstxbin=0, Int_t lastxbin=-1, Option_t *option="") const; // *MENU*
  virtual void     PutStats(Double_t *stats);
  virtual void     Reset(Option_t *option="");
  virtual void     SetShowProjectionX(Int_t nbins=1);  // *MENU*
  virtual void     SetShowProjectionY(Int_t nbins=1);  // *MENU*
  virtual TH1     *ShowBackground(Int_t niter=20, Option_t *option="same");
  virtual Int_t    ShowPeaks(Double_t sigma=2, Option_t *option="", Double_t threshold=0.05); // *MENU*
  virtual void     Smooth(Int_t ntimes=1, Option_t *option=""); // *MENU*
};


class TH2C : public TH2
{
public:
  TH2C();
  TH2C(const char *name,const char *title,Int_t nbinsx,Double_t xlow,Double_t xup
       ,Int_t nbinsy,Double_t ylow,Double_t yup);
  TH2C(const char *name,const char *title,Int_t nbinsx,const Double_t *xbins
       ,Int_t nbinsy,Double_t ylow,Double_t yup);
  TH2C(const char *name,const char *title,Int_t nbinsx,Double_t xlow,Double_t xup
       ,Int_t nbinsy,const Double_t *ybins);
  TH2C(const char *name,const char *title,Int_t nbinsx,const Double_t *xbins
       ,Int_t nbinsy,const Double_t *ybins);

  %extend {
    static TH2C* create(const char *name, const char *title, Int_t nbinsx, Double_t xlow, Double_t xup, Int_t nbinsy, Double_t ylow, Double_t yup)
    {
      return new TH2C(name, title, nbinsx, xlow, xup, nbinsy, ylow, yup);
    }

    static TH2C* create(const char *name, const char *title, Int_t nbinsx, const Double_t *xbins, Int_t nbinsy, Double_t ylow, Double_t yup)
    {
      return new TH2C(name, title, nbinsx, xbins, nbinsy, ylow, yup);
    }

    static TH2C* create(const char *name, const char *title, Int_t nbinsx, Double_t xlow, Double_t xup, Int_t nbinsy, const Double_t *ybins)
    {
      return new TH2C(name, title, nbinsx, xlow, xup, nbinsy, ybins);
    }

    static TH2C* create(const char *name, const char *title, Int_t nbinsx, const Double_t *xbins, Int_t nbinsy, const Double_t *ybins)
    {
      return new TH2C(name, title, nbinsx, xbins, nbinsy, ybins);
    }
  }
  
  TH2C(const TH2C &h2c);
  virtual ~TH2C();
};


class TH2S : public TH2
{
public:
  TH2S();
  TH2S(const char *name,const char *title,Int_t nbinsx,Double_t xlow,Double_t xup
       ,Int_t nbinsy,Double_t ylow,Double_t yup);
  TH2S(const char *name,const char *title,Int_t nbinsx,const Double_t *xbins
       ,Int_t nbinsy,Double_t ylow,Double_t yup);
  TH2S(const char *name,const char *title,Int_t nbinsx,Double_t xlow,Double_t xup
       ,Int_t nbinsy,const Double_t *ybins);
  TH2S(const char *name,const char *title,Int_t nbinsx,const Double_t *xbins
       ,Int_t nbinsy,const Double_t *ybins);

  %extend {
    static TH2S* create(const char *name, const char *title, Int_t nbinsx, Double_t xlow, Double_t xup, Int_t nbinsy, Double_t ylow, Double_t yup)
    {
      return new TH2S(name, title, nbinsx, xlow, xup, nbinsy, ylow, yup);
    }

    static TH2S* create(const char *name, const char *title, Int_t nbinsx, const Double_t *xbins, Int_t nbinsy, Double_t ylow, Double_t yup)
    {
      return new TH2S(name, title, nbinsx, xbins, nbinsy, ylow, yup);
    }

    static TH2S* create(const char *name, const char *title, Int_t nbinsx, Double_t xlow, Double_t xup, Int_t nbinsy, const Double_t *ybins)
    {
      return new TH2S(name, title, nbinsx, xlow, xup, nbinsy, ybins);
    }

    static TH2S* create(const char *name, const char *title, Int_t nbinsx, const Double_t *xbins, Int_t nbinsy, const Double_t *ybins)
    {
      return new TH2S(name, title, nbinsx, xbins, nbinsy, ybins);
    }
  }
  
  TH2S(const TH2S &h2c);
  virtual ~TH2S();
};


class TH2I : public TH2
{
public:
  TH2I();
  TH2I(const char *name,const char *title,Int_t nbinsx,Double_t xlow,Double_t xup
       ,Int_t nbinsy,Double_t ylow,Double_t yup);
  TH2I(const char *name,const char *title,Int_t nbinsx,const Double_t *xbins
       ,Int_t nbinsy,Double_t ylow,Double_t yup);
  TH2I(const char *name,const char *title,Int_t nbinsx,Double_t xlow,Double_t xup
       ,Int_t nbinsy,const Double_t *ybins);
  TH2I(const char *name,const char *title,Int_t nbinsx,const Double_t *xbins
       ,Int_t nbinsy,const Double_t *ybins);

  %extend {
    static TH2I* create(const char *name, const char *title, Int_t nbinsx, Double_t xlow, Double_t xup, Int_t nbinsy, Double_t ylow, Double_t yup)
    {
      return new TH2I(name, title, nbinsx, xlow, xup, nbinsy, ylow, yup);
    }

    static TH2I* create(const char *name, const char *title, Int_t nbinsx, const Double_t *xbins, Int_t nbinsy, Double_t ylow, Double_t yup)
    {
      return new TH2I(name, title, nbinsx, xbins, nbinsy, ylow, yup);
    }

    static TH2I* create(const char *name, const char *title, Int_t nbinsx, Double_t xlow, Double_t xup, Int_t nbinsy, const Double_t *ybins)
    {
      return new TH2I(name, title, nbinsx, xlow, xup, nbinsy, ybins);
    }

    static TH2I* create(const char *name, const char *title, Int_t nbinsx, const Double_t *xbins, Int_t nbinsy, const Double_t *ybins)
    {
      return new TH2I(name, title, nbinsx, xbins, nbinsy, ybins);
    }
  }
  
  TH2I(const TH2I &h2c);
  virtual ~TH2I();
};


class TH2F : public TH2
{
public:
  TH2F();
  TH2F(const char *name,const char *title,Int_t nbinsx,Double_t xlow,Double_t xup
       ,Int_t nbinsy,Double_t ylow,Double_t yup);
  TH2F(const char *name,const char *title,Int_t nbinsx,const Double_t *xbins
       ,Int_t nbinsy,Double_t ylow,Double_t yup);
  TH2F(const char *name,const char *title,Int_t nbinsx,Double_t xlow,Double_t xup
       ,Int_t nbinsy,const Double_t *ybins);
  TH2F(const char *name,const char *title,Int_t nbinsx,const Double_t *xbins
       ,Int_t nbinsy,const Double_t *ybins);

  %extend {
    static TH2F* create(const char *name, const char *title, Int_t nbinsx, Double_t xlow, Double_t xup, Int_t nbinsy, Double_t ylow, Double_t yup)
    {
      return new TH2F(name, title, nbinsx, xlow, xup, nbinsy, ylow, yup);
    }

    static TH2F* create(const char *name, const char *title, Int_t nbinsx, const Double_t *xbins, Int_t nbinsy, Double_t ylow, Double_t yup)
    {
      return new TH2F(name, title, nbinsx, xbins, nbinsy, ylow, yup);
    }

    static TH2F* create(const char *name, const char *title, Int_t nbinsx, Double_t xlow, Double_t xup, Int_t nbinsy, const Double_t *ybins)
    {
      return new TH2F(name, title, nbinsx, xlow, xup, nbinsy, ybins);
    }

    static TH2F* create(const char *name, const char *title, Int_t nbinsx, const Double_t *xbins, Int_t nbinsy, const Double_t *ybins)
    {
      return new TH2F(name, title, nbinsx, xbins, nbinsy, ybins);
    }
  }
  
  TH2F(const TH2F &h2c);
  virtual ~TH2F();
};


class TH2D : public TH2
{
public:
  TH2D();
  TH2D(const char *name,const char *title,Int_t nbinsx,Double_t xlow,Double_t xup
       ,Int_t nbinsy,Double_t ylow,Double_t yup);
  TH2D(const char *name,const char *title,Int_t nbinsx,const Double_t *xbins
       ,Int_t nbinsy,Double_t ylow,Double_t yup);
  TH2D(const char *name,const char *title,Int_t nbinsx,Double_t xlow,Double_t xup
       ,Int_t nbinsy,const Double_t *ybins);
  TH2D(const char *name,const char *title,Int_t nbinsx,const Double_t *xbins
       ,Int_t nbinsy,const Double_t *ybins);

  %extend {
    static TH2D* create(const char *name, const char *title, Int_t nbinsx, Double_t xlow, Double_t xup, Int_t nbinsy, Double_t ylow, Double_t yup)
    {
      return new TH2D(name, title, nbinsx, xlow, xup, nbinsy, ylow, yup);
    }

    static TH2D* create(const char *name, const char *title, Int_t nbinsx, const Double_t *xbins, Int_t nbinsy, Double_t ylow, Double_t yup)
    {
      return new TH2D(name, title, nbinsx, xbins, nbinsy, ylow, yup);
    }

    static TH2D* create(const char *name, const char *title, Int_t nbinsx, Double_t xlow, Double_t xup, Int_t nbinsy, const Double_t *ybins)
    {
      return new TH2D(name, title, nbinsx, xlow, xup, nbinsy, ybins);
    }

    static TH2D* create(const char *name, const char *title, Int_t nbinsx, const Double_t *xbins, Int_t nbinsy, const Double_t *ybins)
    {
      return new TH2D(name, title, nbinsx, xbins, nbinsy, ybins);
    }
  }
  
  TH2D(const TH2D &h2c);
  virtual ~TH2D();
};
