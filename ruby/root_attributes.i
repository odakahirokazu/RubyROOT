// ROOT attribute classes

class TAttLine {
public:
  TAttLine();
  TAttLine(Color_t lcolor,Style_t lstyle, Width_t lwidth);
  virtual ~TAttLine();
  
  void             Copy(TAttLine &attline) const;
  Int_t            DistancetoLine(Int_t px, Int_t py, Double_t xp1, Double_t yp1, Double_t xp2, Double_t yp2 );
  virtual Color_t  GetLineColor() const {return fLineColor;}
  virtual Style_t  GetLineStyle() const {return fLineStyle;}
  virtual Width_t  GetLineWidth() const {return fLineWidth;}
  virtual void     Modify();
  virtual void     ResetAttLine(Option_t *option="");
  virtual void     SaveLineAttributes(std::ostream &out, const char *name, Int_t coldef=1, Int_t stydef=1, Int_t widdef=1);
  virtual void     SetLineAttributes(); // *MENU*
  virtual void     SetLineColor(Color_t lcolor) { fLineColor = lcolor;}
  virtual void     SetLineColorAlpha(Color_t lcolor, Float_t lalpha);
  virtual void     SetLineStyle(Style_t lstyle) { fLineStyle = lstyle;}
  virtual void     SetLineWidth(Width_t lwidth) { fLineWidth = lwidth;}
};


class TAttFill {
public:
  TAttFill();
  TAttFill(Color_t fcolor,Style_t fstyle);
  virtual ~TAttFill();
  void             Copy(TAttFill &attfill) const;
  virtual Color_t  GetFillColor() const { return fFillColor; }
  virtual Style_t  GetFillStyle() const { return fFillStyle; }
  virtual Bool_t   IsTransparent() const;
  virtual void     Modify();
  virtual void     ResetAttFill(Option_t *option="");
  virtual void     SaveFillAttributes(std::ostream &out, const char *name, Int_t coldef=1, Int_t stydef=1001);
  virtual void     SetFillAttributes(); // *MENU*
  virtual void     SetFillColor(Color_t fcolor) { fFillColor = fcolor; }
  virtual void     SetFillColorAlpha(Color_t fcolor, Float_t falpha);
  virtual void     SetFillStyle(Style_t fstyle) { fFillStyle = fstyle; }
};


class TAttMarker {
public:
  TAttMarker();
  TAttMarker(Color_t color, Style_t style, Size_t msize);
  virtual ~TAttMarker();
  void     Copy(TAttMarker &attmarker) const;
  virtual Color_t  GetMarkerColor() const {return fMarkerColor;}
  virtual Style_t  GetMarkerStyle() const {return fMarkerStyle;}
  virtual Size_t   GetMarkerSize()  const {return fMarkerSize;}
  virtual void     Modify();
  virtual void     ResetAttMarker(Option_t *toption="");
  virtual void     SaveMarkerAttributes(std::ostream &out, const char *name, Int_t coldef=1, Int_t stydef=1, Int_t sizdef=1);
  virtual void     SetMarkerAttributes();  // *MENU*
  virtual void     SetMarkerColor(Color_t mcolor=1) { fMarkerColor = mcolor;}
  virtual void     SetMarkerColorAlpha(Color_t mcolor, Float_t malpha);
  virtual void     SetMarkerStyle(Style_t mstyle=1) { fMarkerStyle = mstyle;}
  virtual void     SetMarkerSize(Size_t msize=1)    { fMarkerSize  = msize;}

};


class TAttPad {
public:
  TAttPad();
  virtual ~TAttPad();
  virtual void     Copy(TAttPad &attpad) const;
  Float_t          GetBottomMargin() const { return fBottomMargin;}
  Float_t          GetLeftMargin() const { return fLeftMargin;}
  Float_t          GetRightMargin() const { return fRightMargin;}
  Float_t          GetTopMargin() const { return fTopMargin;}
  Float_t          GetAfile() const { return fAfile;}
  Float_t          GetXfile() const { return fXfile;}
  Float_t          GetYfile() const { return fYfile;}
  Float_t          GetAstat() const { return fAstat;}
  Float_t          GetXstat() const { return fXstat;}
  Float_t          GetYstat() const { return fYstat;}
  Color_t          GetFrameFillColor() const {return fFrameFillColor;}
  Color_t          GetFrameLineColor() const {return fFrameLineColor;}
  Style_t          GetFrameFillStyle() const {return fFrameFillStyle;}
  Style_t          GetFrameLineStyle() const {return fFrameLineStyle;}
  Width_t          GetFrameLineWidth() const {return fFrameLineWidth;}
  Width_t          GetFrameBorderSize() const {return fFrameBorderSize;}
  Int_t            GetFrameBorderMode() const {return fFrameBorderMode;}
  virtual void     Print(Option_t *option="") const;
  virtual void     ResetAttPad(Option_t *option="");
  virtual void     SetBottomMargin(Float_t bottommargin);
  virtual void     SetLeftMargin(Float_t leftmargin);
  virtual void     SetRightMargin(Float_t rightmargin);
  virtual void     SetTopMargin(Float_t topmargin);
  virtual void     SetMargin(Float_t left, Float_t right, Float_t bottom, Float_t top);
  virtual void     SetAfile(Float_t afile) { fAfile=afile;}
  virtual void     SetXfile(Float_t xfile) { fXfile=xfile;}
  virtual void     SetYfile(Float_t yfile) { fYfile=yfile;}
  virtual void     SetAstat(Float_t astat) { fAstat=astat;}
  virtual void     SetXstat(Float_t xstat) { fXstat=xstat;}
  virtual void     SetYstat(Float_t ystat) { fYstat=ystat;}
  void             SetFrameFillColor(Color_t color=1) {fFrameFillColor = color;}
  void             SetFrameLineColor(Color_t color=1) {fFrameLineColor = color;}
  void             SetFrameFillStyle(Style_t styl=0)  {fFrameFillStyle = styl;}
  void             SetFrameLineStyle(Style_t styl=0)  {fFrameLineStyle = styl;}
  void             SetFrameLineWidth(Width_t width=1) {fFrameLineWidth = width;}
  void             SetFrameBorderSize(Width_t size=1) {fFrameBorderSize = size;}
  void             SetFrameBorderMode(Int_t mode=1) {fFrameBorderMode = mode;}
};


class TAttText {
public:
  TAttText();
  TAttText(Int_t align, Float_t angle, Color_t color, Style_t font, Float_t tsize);
  virtual ~TAttText();
  void     Copy(TAttText &atttext) const;
  virtual Short_t  GetTextAlign() const {return fTextAlign;}
  virtual Float_t  GetTextAngle() const {return fTextAngle;}
  virtual Color_t  GetTextColor() const {return fTextColor;}
  virtual Font_t   GetTextFont()  const {return fTextFont;}
  virtual Float_t  GetTextSize()  const {return fTextSize;}
  virtual void     Modify();
  virtual void     ResetAttText(Option_t *toption="");
  virtual void     SaveTextAttributes(std::ostream &out, const char *name, Int_t alidef=12, Float_t angdef=0, Int_t coldef=1, Int_t fondef=61, Float_t sizdef=1);
  virtual void     SetTextAttributes();  // *MENU*
  virtual void     SetTextAlign(Short_t align=11) { fTextAlign = align;}
  virtual void     SetTextAngle(Float_t tangle=0) { fTextAngle = tangle;}  // *MENU*
  virtual void     SetTextColor(Color_t tcolor=1) { fTextColor = tcolor;}
  virtual void     SetTextColorAlpha(Color_t tcolor, Float_t talpha);
  virtual void     SetTextFont(Font_t tfont=62) { fTextFont = tfont;}
  virtual void     SetTextSize(Float_t tsize=1) { fTextSize = tsize;}
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


class TAttAxis {
public:
  TAttAxis();
  virtual          ~TAttAxis();
  void     Copy(TAttAxis &attaxis) const;
  virtual Int_t    GetNdivisions()  const {return fNdivisions;}
  virtual Color_t  GetAxisColor()   const {return fAxisColor;}
  virtual Color_t  GetLabelColor()  const {return fLabelColor;}
  virtual Style_t  GetLabelFont()   const {return fLabelFont;}
  virtual Float_t  GetLabelOffset() const {return fLabelOffset;}
  virtual Float_t  GetLabelSize()   const {return fLabelSize;}
  virtual Float_t  GetTitleOffset() const {return fTitleOffset;}
  virtual Float_t  GetTitleSize()   const {return fTitleSize;}
  virtual Float_t  GetTickLength()  const {return fTickLength;}
  virtual Color_t  GetTitleColor()  const {return fTitleColor;}
  virtual Style_t  GetTitleFont()   const {return fTitleFont;}
  virtual void     ResetAttAxis(Option_t *option="");
  virtual void     SaveAttributes(std::ostream &out, const char *name, const char *subname);
  virtual void     SetNdivisions(Int_t n=510, Bool_t optim=kTRUE);   // *MENU*
  virtual void     SetNdivisions(Int_t n1, Int_t n2, Int_t n3, Bool_t optim=kTRUE);
  virtual void     SetAxisColor(Color_t color=1, Float_t alpha=1.);  // *MENU*
  virtual void     SetLabelColor(Color_t color=1, Float_t alpha=1.); // *MENU*
  virtual void     SetLabelFont(Style_t font=62);                    // *MENU*
  virtual void     SetLabelOffset(Float_t offset=0.005);             // *MENU*
  virtual void     SetLabelSize(Float_t size=0.04);                  // *MENU*
  virtual void     SetTickLength(Float_t length=0.03);               // *MENU*
  virtual void     SetTickSize(Float_t size=0.03) {SetTickLength(size);}
  virtual void     SetTitleOffset(Float_t offset=1);                 // *MENU*
  virtual void     SetTitleSize(Float_t size=0.04);                  // *MENU*
  virtual void     SetTitleColor(Color_t color=1);                   // *MENU*
  virtual void     SetTitleFont(Style_t font=62);                    // *MENU*
};
