// 3D-histogram

class TH3 : public TH1 /*, public TAtt3D */
{
public:
  TH3(const TH3&);
  virtual ~TH3();
  virtual Int_t    BufferEmpty(Int_t action=0);
  virtual void     Copy(TObject &hnew) const;
  virtual Int_t    Fill(Double_t x, Double_t y, Double_t z);
  virtual Int_t    Fill(Double_t x, Double_t y, Double_t z, Double_t w);
  
  virtual Int_t    Fill(const char *namex, const char *namey, const char *namez, Double_t w);
  virtual Int_t    Fill(const char *namex, Double_t y, const char *namez, Double_t w);
  virtual Int_t    Fill(const char *namex, const char *namey, Double_t z, Double_t w);
  virtual Int_t    Fill(Double_t x, const char *namey, const char *namez, Double_t w);
  virtual Int_t    Fill(Double_t x, const char *namey, Double_t z, Double_t w);
  virtual Int_t    Fill(Double_t x, Double_t y, const char *namez, Double_t w);
  
  virtual void     FillRandom(const char *fname, Int_t ntimes=5000);
  virtual void     FillRandom(TH1 *h, Int_t ntimes=5000);
  virtual Int_t    FindFirstBinAbove(Double_t threshold=0, Int_t axis=1) const;
  virtual Int_t    FindLastBinAbove (Double_t threshold=0, Int_t axis=1) const;
  virtual void     FitSlicesZ(TF1 *f1=0,Int_t binminx=1, Int_t binmaxx=0,Int_t binminy=1, Int_t binmaxy=0,
                              Int_t cut=0 ,Option_t *option="QNR"); // *MENU*
  using TH1::GetBinErrorLow;
  using TH1::GetBinErrorUp;
  virtual Double_t GetBinErrorLow(Int_t binx, Int_t biny, Int_t binz);
  virtual Double_t GetBinErrorUp(Int_t binx, Int_t biny, Int_t binz);
  virtual Double_t GetBinWithContent3(Double_t c, Int_t &binx, Int_t &biny, Int_t &binz, Int_t firstx=0, Int_t lastx=0,Int_t firsty=0, Int_t lasty=0, Int_t firstz=0, Int_t lastz=0, Double_t maxdiff=0) const;
  virtual Double_t GetCorrelationFactor(Int_t axis1=1,Int_t axis2=2) const;
  virtual Double_t GetCovariance(Int_t axis1=1,Int_t axis2=2) const;
  virtual void     GetRandom3(Double_t &x, Double_t &y, Double_t &z);
  virtual void     GetStats(Double_t *stats) const;
  virtual Double_t Integral(Option_t *option="") const;
  using TH1::Integral;
  virtual Double_t Integral(Int_t binx1, Int_t binx2, Int_t biny1, Int_t biny2, Int_t binz1, Int_t binz2, Option_t *option="") const;
  using TH1::IntegralAndError;
  virtual Double_t IntegralAndError(Int_t binx1, Int_t binx2, Int_t biny1, Int_t biny2, Int_t binz1, Int_t binz2, Double_t & err, Option_t *option="") const;
  virtual Double_t Interpolate(Double_t x);
  virtual Double_t Interpolate(Double_t x, Double_t y);
  virtual Double_t Interpolate(Double_t x, Double_t y, Double_t z);
  virtual Double_t KolmogorovTest(const TH1 *h2, Option_t *option="") const;
  virtual Long64_t Merge(TCollection *list);
  TH1D      *ProjectionX(const char *name="_px", Int_t firstybin=0, Int_t lastybin=-1, Int_t firstzbin=0,
                         Int_t lastzbin=-1, Option_t *option="") const; // *MENU*
  TH1D      *ProjectionY(const char *name="_py", Int_t firstxbin=0, Int_t lastxbin=-1, Int_t firstzbin=0,
                         Int_t lastzbin=-1, Option_t *option="") const; // *MENU*
  TH1D      *ProjectionZ(const char *name="_pz", Int_t firstxbin=0, Int_t lastxbin=-1, Int_t firstybin=0,
                         Int_t lastybin=-1, Option_t *option="") const; // *MENU*
  TH1       *Project3D(Option_t *option="x") const; // *MENU*
  TProfile2D      *Project3DProfile(Option_t *option="xy") const; // *MENU*
  virtual void     PutStats(Double_t *stats);
  virtual TH3     *RebinX(Int_t ngroup = 2, const char *newname = "");
  virtual TH3     *RebinY(Int_t ngroup = 2, const char *newname = "");
  virtual TH3     *RebinZ(Int_t ngroup = 2, const char *newname = "");
  virtual TH3     *Rebin3D(Int_t nxgroup = 2, Int_t nygroup = 2, Int_t nzgroup = 2, const char *newname = "");
  virtual void     Reset(Option_t *option="");
  virtual void     SetShowProjection(const char *option="xy",Int_t nbins=1);
};


class TH3C : public TH3
{
public:
  TH3C();
  TH3C(const char *name,const char *title,Int_t nbinsx,Double_t xlow,Double_t xup
       ,Int_t nbinsy,Double_t ylow,Double_t yup
       ,Int_t nbinsz,Double_t zlow,Double_t zup);
  TH3C(const char *name,const char *title,Int_t nbinsx,const Double_t *xbins
       ,Int_t nbinsy,const Double_t *ybins
       ,Int_t nbinsz,const Double_t *zbins);

  %extend {
    static TH3C* create(const char *name, const char *title,
                        Int_t nbinsx, Double_t xlow, Double_t xup,
                        Int_t nbinsy, Double_t ylow, Double_t yup,
                        Int_t nbinsz, Double_t zlow, Double_t zup)
    {
      return new TH3C(name, title,
                      nbinsx, xlow, xup,
                      nbinsy, ylow, yup,
                      nbinsz, zlow, zup);
    }

    static TH3C* create(const char *name, const char *title,
                        Int_t nbinsx, const Double_t *xbins,
                        Int_t nbinsy, const Double_t *ybins,
                        Int_t nbinsz, const Double_t *zbins)
    {
      return new TH3C(name, title, nbinsx, xbins, nbinsy, ybins, nbinsz, zbins);
    }
  }

  TH3C(const TH3C &h3c);
  virtual ~TH3C();
};


class TH3S : public TH3
{
public:
  TH3S();
  TH3S(const char *name,const char *title,Int_t nbinsx,Double_t xlow,Double_t xup
       ,Int_t nbinsy,Double_t ylow,Double_t yup
       ,Int_t nbinsz,Double_t zlow,Double_t zup);
  TH3S(const char *name,const char *title,Int_t nbinsx,const Double_t *xbins
       ,Int_t nbinsy,const Double_t *ybins
       ,Int_t nbinsz,const Double_t *zbins);

  %extend {
    static TH3S* create(const char *name, const char *title,
                        Int_t nbinsx, Double_t xlow, Double_t xup,
                        Int_t nbinsy, Double_t ylow, Double_t yup,
                        Int_t nbinsz, Double_t zlow, Double_t zup)
    {
      return new TH3S(name, title,
                      nbinsx, xlow, xup,
                      nbinsy, ylow, yup,
                      nbinsz, zlow, zup);
    }

    static TH3S* create(const char *name, const char *title,
                        Int_t nbinsx, const Double_t *xbins,
                        Int_t nbinsy, const Double_t *ybins,
                        Int_t nbinsz, const Double_t *zbins)
    {
      return new TH3S(name, title, nbinsx, xbins, nbinsy, ybins, nbinsz, zbins);
    }
  }

  TH3S(const TH3S &h3c);
  virtual ~TH3S();
};


class TH3I : public TH3
{
public:
  TH3I();
  TH3I(const char *name,const char *title,Int_t nbinsx,Double_t xlow,Double_t xup
       ,Int_t nbinsy,Double_t ylow,Double_t yup
       ,Int_t nbinsz,Double_t zlow,Double_t zup);
  TH3I(const char *name,const char *title,Int_t nbinsx,const Double_t *xbins
       ,Int_t nbinsy,const Double_t *ybins
       ,Int_t nbinsz,const Double_t *zbins);

  %extend {
    static TH3I* create(const char *name, const char *title,
                        Int_t nbinsx, Double_t xlow, Double_t xup,
                        Int_t nbinsy, Double_t ylow, Double_t yup,
                        Int_t nbinsz, Double_t zlow, Double_t zup)
    {
      return new TH3I(name, title,
                      nbinsx, xlow, xup,
                      nbinsy, ylow, yup,
                      nbinsz, zlow, zup);
    }

    static TH3I* create(const char *name, const char *title,
                        Int_t nbinsx, const Double_t *xbins,
                        Int_t nbinsy, const Double_t *ybins,
                        Int_t nbinsz, const Double_t *zbins)
    {
      return new TH3I(name, title, nbinsx, xbins, nbinsy, ybins, nbinsz, zbins);
    }
  }

  TH3I(const TH3I &h3c);
  virtual ~TH3I();
};


class TH3F : public TH3
{
public:
  TH3F();
  TH3F(const char *name,const char *title,Int_t nbinsx,Double_t xlow,Double_t xup
       ,Int_t nbinsy,Double_t ylow,Double_t yup
       ,Int_t nbinsz,Double_t zlow,Double_t zup);
  TH3F(const char *name,const char *title,Int_t nbinsx,const Double_t *xbins
       ,Int_t nbinsy,const Double_t *ybins
       ,Int_t nbinsz,const Double_t *zbins);

  %extend {
    static TH3F* create(const char *name, const char *title,
                        Int_t nbinsx, Double_t xlow, Double_t xup,
                        Int_t nbinsy, Double_t ylow, Double_t yup,
                        Int_t nbinsz, Double_t zlow, Double_t zup)
    {
      return new TH3F(name, title,
                      nbinsx, xlow, xup,
                      nbinsy, ylow, yup,
                      nbinsz, zlow, zup);
    }

    static TH3F* create(const char *name, const char *title,
                        Int_t nbinsx, const Double_t *xbins,
                        Int_t nbinsy, const Double_t *ybins,
                        Int_t nbinsz, const Double_t *zbins)
    {
      return new TH3F(name, title, nbinsx, xbins, nbinsy, ybins, nbinsz, zbins);
    }
  }

  TH3F(const TH3F &h3c);
  virtual ~TH3F();
};


class TH3D : public TH3
{
public:
  TH3D();
  TH3D(const char *name,const char *title,Int_t nbinsx,Double_t xlow,Double_t xup
       ,Int_t nbinsy,Double_t ylow,Double_t yup
       ,Int_t nbinsz,Double_t zlow,Double_t zup);
  TH3D(const char *name,const char *title,Int_t nbinsx,const Double_t *xbins
       ,Int_t nbinsy,const Double_t *ybins
       ,Int_t nbinsz,const Double_t *zbins);

  %extend {
    static TH3D* create(const char *name, const char *title,
                        Int_t nbinsx, Double_t xlow, Double_t xup,
                        Int_t nbinsy, Double_t ylow, Double_t yup,
                        Int_t nbinsz, Double_t zlow, Double_t zup)
    {
      return new TH3D(name, title,
                      nbinsx, xlow, xup,
                      nbinsy, ylow, yup,
                      nbinsz, zlow, zup);
    }

    static TH3D* create(const char *name, const char *title,
                        Int_t nbinsx, const Double_t *xbins,
                        Int_t nbinsy, const Double_t *ybins,
                        Int_t nbinsz, const Double_t *zbins)
    {
      return new TH3D(name, title, nbinsx, xbins, nbinsy, ybins, nbinsz, zbins);
    }
  }

  TH3D(const TH3D &h3c);
  virtual ~TH3D();
};
