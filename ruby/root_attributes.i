// ROOT attribute classes

class TAttLine
{
public:
  TAttLine();
  TAttLine(Color_t lcolor, Style_t lstyle, Width_t lwidth);
  virtual ~TAttLine();

  void             Copy(TAttLine &attline) const;
  Int_t            DistancetoLine(Int_t px, Int_t py, Double_t xp1, Double_t yp1, Double_t xp2, Double_t yp2 );
  virtual Color_t  GetLineColor() const;
  virtual Style_t  GetLineStyle() const;
  virtual Width_t  GetLineWidth() const;
  virtual void     Modify();
  virtual void     ResetAttLine(Option_t *option="");
  virtual void     SaveLineAttributes(ostream &out, const char *name, Int_t coldef=1, Int_t stydef=1, Int_t widdef=1);
  virtual void     SetLineAttributes(); // *MENU*
  virtual void     SetLineColor(Color_t lcolor);
  virtual void     SetLineColorAlpha (Color_t lcolor, Float_t lalpha);
  virtual void     SetLineStyle(Style_t lstyle);
  virtual void     SetLineWidth(Width_t lwidth);
};


class TAttFill
{
public:
  TAttFill();
  TAttFill(Color_t fcolor, Style_t fstyle);
  virtual ~TAttFill();
  void             Copy(TAttFill &attfill) const;
  virtual Color_t  GetFillColor() const;
  virtual Style_t  GetFillStyle() const;
  virtual Bool_t   IsTransparent() const;
  virtual void     Modify();
  virtual void     ResetAttFill(Option_t *option="");
  virtual void     SaveFillAttributes(ostream &out, const char *name, Int_t coldef=1, Int_t stydef=1001);
  virtual void     SetFillAttributes(); // *MENU*
  virtual void     SetFillColor(Color_t fcolor);
  virtual void     SetFillColorAlpha (Color_t fcolor, Float_t falpha);
  virtual void     SetFillStyle(Style_t fstyle);
};


class TAttMarker
{
public:
  TAttMarker();
  TAttMarker(Color_t color, Style_t style, Size_t msize);
  virtual ~TAttMarker();
  void     Copy(TAttMarker &attmarker) const;
  virtual Color_t  GetMarkerColor() const;
  virtual Style_t  GetMarkerStyle() const;
  virtual Size_t   GetMarkerSize()  const;
  virtual void     Modify();
  virtual void     ResetAttMarker(Option_t *toption="");
  virtual void     SaveMarkerAttributes(ostream &out, const char *name, Int_t coldef=1, Int_t stydef=1, Int_t sizdef=1);
  virtual void     SetMarkerAttributes();  // *MENU*
  virtual void     SetMarkerColor(Color_t tcolor=1);
  virtual void     SetMarkerColorAlpha (Color_t mcolor, Float_t malpha);
  virtual void     SetMarkerStyle(Style_t mstyle=1);
  virtual void     SetMarkerSize(Size_t msize=1);
};


class TAttPad
{
public:
  TAttPad();
  virtual ~TAttPad();
  virtual void     Copy(TAttPad &attpad) const;
  Float_t          GetBottomMargin() const;
  Float_t          GetLeftMargin() const;
  Float_t          GetRightMargin() const;
  Float_t          GetTopMargin() const;
  Float_t          GetAfile() const;
  Float_t          GetXfile() const;
  Float_t          GetYfile() const;
  Float_t          GetAstat() const;
  Float_t          GetXstat() const;
  Float_t          GetYstat() const;
  Color_t          GetFrameFillColor() const;
  Color_t          GetFrameLineColor() const;
  Style_t          GetFrameFillStyle() const;
  Style_t          GetFrameLineStyle() const;
  Width_t          GetFrameLineWidth() const;
  Width_t          GetFrameBorderSize() const;
  Int_t            GetFrameBorderMode() const;
  virtual void     Print(Option_t *option="") const;
  virtual void     ResetAttPad(Option_t *option="");
  virtual void     SetBottomMargin(Float_t bottommargin);
  virtual void     SetLeftMargin(Float_t leftmargin);
  virtual void     SetRightMargin(Float_t rightmargin);
  virtual void     SetTopMargin(Float_t topmargin);
  virtual void     SetMargin(Float_t left, Float_t right, Float_t bottom, Float_t top);
  virtual void     SetAfile(Float_t afile);
  virtual void     SetXfile(Float_t xfile);
  virtual void     SetYfile(Float_t yfile);
  virtual void     SetAstat(Float_t astat);
  virtual void     SetXstat(Float_t xstat);
  virtual void     SetYstat(Float_t ystat);
  void             SetFrameFillColor(Color_t color=1);
  void             SetFrameLineColor(Color_t color=1);
  void             SetFrameFillStyle(Style_t styl=0);
  void             SetFrameLineStyle(Style_t styl=0);
  void             SetFrameLineWidth(Width_t width=1);
  void             SetFrameBorderSize(Width_t size=1);
  void             SetFrameBorderMode(Int_t mode=1);
};


class TAttText
{
public:
  TAttText();
  TAttText(Int_t align, Float_t angle, Color_t color, Style_t font, Float_t tsize);
  virtual ~TAttText();
  void     Copy(TAttText &atttext) const;
  virtual Short_t  GetTextAlign() const ;
  virtual Float_t  GetTextAngle() const ;
  virtual Color_t  GetTextColor() const ;
  virtual Font_t   GetTextFont()  const ;
  virtual Float_t  GetTextSize()  const ;
  virtual void     Modify();
  virtual void     ResetAttText(Option_t *toption="");
  virtual void     SaveTextAttributes(ostream &out, const char *name, Int_t alidef=12, Float_t angdef=0, Int_t coldef=1, Int_t fondef=61, Float_t sizdef=1);
  virtual void     SetTextAttributes();  // *MENU*
  virtual void     SetTextAlign(Short_t align=11) ;
  virtual void     SetTextAngle(Float_t tangle=0) ;  // *MENU*
  virtual void     SetTextColor(Color_t tcolor=1) ;
  virtual void     SetTextFont(Font_t tfont=62) ;
  virtual void     SetTextSize(Float_t tsize=1) ;
  virtual void     SetTextSizePixels(Int_t npixels);
};


class TAttBBox2D {
public:
  virtual ~TAttBBox2D();
  virtual Rectangle_t     GetBBox()  = 0; //Get TopLeft Corner with width and height
  virtual TPoint          GetBBoxCenter() = 0;
  virtual void            SetBBoxCenter(const TPoint &p) = 0;
  virtual void            SetBBoxCenterX(const Int_t x) = 0;
  virtual void            SetBBoxCenterY(const Int_t y) = 0;
  virtual void            SetBBoxX1(const Int_t x) = 0; //set lhs of BB to value
  virtual void            SetBBoxX2(const Int_t x) = 0; //set rhs of BB to value
  virtual void            SetBBoxY1(const Int_t y) = 0; //set top of BB to value
  virtual void            SetBBoxY2(const Int_t y) = 0; //set bottom of BB to value
};
