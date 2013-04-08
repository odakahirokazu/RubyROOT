/**************************************************************************/
/* Style classes                                                          */
/**************************************************************************/

class TStyle : public TNamed, public TAttLine, public TAttFill, public TAttMarker, public TAttText
{
public:
  enum EPaperSize;

  TStyle();
  TStyle(const char *name, const char *title);
  TStyle(const TStyle &style);
  virtual          ~TStyle();
  Int_t            AxisChoice(Option_t *axis) const;
  virtual void     Browse(TBrowser *b);
  static  void     BuildStyles();
  virtual void     Copy(TObject &style) const;
  virtual void     cd();

  virtual Int_t    DistancetoPrimitive(Int_t px, Int_t py);
  Int_t            GetNdivisions(Option_t *axis="X") const;
  TAttText        *GetAttDate() ;
  Color_t          GetAxisColor(Option_t *axis="X") const;
  Color_t          GetLabelColor(Option_t *axis="X") const;
  Style_t          GetLabelFont(Option_t *axis="X") const;
  Float_t          GetLabelOffset(Option_t *axis="X") const;
  Float_t          GetLabelSize(Option_t *axis="X") const;
  Color_t          GetTitleColor(Option_t *axis="X") const;  //return axis title color of pad title color
  Style_t          GetTitleFont(Option_t *axis="X") const;   //return axis title font of pad title font
  Float_t          GetTitleOffset(Option_t *axis="X") const; //return axis title offset
  Float_t          GetTitleSize(Option_t *axis="X") const;   //return axis title size
  Float_t          GetTickLength(Option_t *axis="X") const;

  Float_t          GetBarOffset() const ;
  Float_t          GetBarWidth() const ;
  Int_t            GetDrawBorder() const ;
  Float_t          GetEndErrorSize() const ;
  Float_t          GetErrorX() const ;
  Bool_t           GetCanvasPreferGL() const ;
  Color_t          GetCanvasColor() const ;
  Width_t          GetCanvasBorderSize() const ;
  Int_t            GetCanvasBorderMode() const ;
  Int_t            GetCanvasDefH() const      ;
  Int_t            GetCanvasDefW() const      ;
  Int_t            GetCanvasDefX() const      ;
  Int_t            GetCanvasDefY() const      ;
  Int_t            GetColorPalette(Int_t i) const;
  Int_t            GetColorModelPS() const    ;
  Float_t          GetDateX()  const          ;
  Float_t          GetDateY() const           ;
  const char      *GetFitFormat()       const ;
  Int_t            GetHatchesLineWidth() const ;
  Double_t         GetHatchesSpacing() const  ;
  Width_t          GetLegendBorderSize() const   ;
  Color_t          GetLegendFillColor() const ;
  Style_t          GetLegendFont() const ;
  Int_t            GetNumberOfColors() const;
  Color_t          GetPadColor() const        ;
  Width_t          GetPadBorderSize() const   ;
  Int_t            GetPadBorderMode() const   ;
  Float_t          GetPadBottomMargin() const ;
  Float_t          GetPadTopMargin() const    ;
  Float_t          GetPadLeftMargin() const   ;
  Float_t          GetPadRightMargin() const  ;
  Bool_t           GetPadGridX() const        ;
  Bool_t           GetPadGridY() const        ;
  Int_t            GetPadTickX() const        ;
  Int_t            GetPadTickY() const        ;
  Color_t          GetFuncColor() const       ;
  Style_t          GetFuncStyle() const       ;
  Width_t          GetFuncWidth() const       ;
  Color_t          GetGridColor() const       ;
  Style_t          GetGridStyle() const       ;
  Width_t          GetGridWidth() const       ;
  Color_t          GetFrameFillColor()  const ;
  Color_t          GetFrameLineColor()  const ;
  Style_t          GetFrameFillStyle()  const ;
  Style_t          GetFrameLineStyle()  const ;
  Width_t          GetFrameLineWidth()  const ;
  Width_t          GetFrameBorderSize() const ;
  Int_t            GetFrameBorderMode() const ;
  Color_t          GetHistFillColor()   const ;
  Color_t          GetHistLineColor()   const ;
  Style_t          GetHistFillStyle()   const ;
  Style_t          GetHistLineStyle()   const ;
  Width_t          GetHistLineWidth()   const ;
  Bool_t           GetHistMinimumZero() const ;
  Double_t         GetHistTopMargin()   const ;
  Float_t          GetLegoInnerR() const ;
  Int_t            GetNumberContours() const ;
  Int_t            GetOptDate() const ;
  Int_t            GetOptFile() const ;
  Int_t            GetOptFit() const ;
  Int_t            GetOptStat() const ;
  Int_t            GetOptTitle() const ;
  Int_t            GetOptLogx() const ;
  Int_t            GetOptLogy() const ;
  Int_t            GetOptLogz() const ;
  const char      *GetPaintTextFormat() const ;
  void             GetPaperSize(Float_t &xsize, Float_t &ysize) const;
  Int_t            GetShowEventStatus() const ;
  Int_t            GetShowEditor() const ;
  Int_t            GetShowToolBar() const ;

  Float_t          GetScreenFactor() const ;
  Color_t          GetStatColor() const ;
  Color_t          GetStatTextColor() const ;
  Width_t          GetStatBorderSize() const ;
  Style_t          GetStatFont() const  ;
  Float_t          GetStatFontSize() const  ;
  Style_t          GetStatStyle() const  ;
  const char      *GetStatFormat() const ;
  Float_t          GetStatX() const     ;
  Float_t          GetStatY() const     ;
  Float_t          GetStatW() const     ;
  Float_t          GetStatH() const     ;
  Int_t            GetStripDecimals() const ;
  Double_t         GetTimeOffset() const ; //return axis time offset
  Int_t            GetTitleAlign() ; // return the histogram title TPaveLabel alignment
  Color_t          GetTitleFillColor() const ;  //return histogram title fill area color
  Color_t          GetTitleTextColor() const ;  //return histogram title text color
  Style_t          GetTitleStyle() const  ;
  Float_t          GetTitleFontSize() const  ; //return histogram title font size
  Width_t          GetTitleBorderSize() const ; //return border size of histogram title TPaveLabel
  Float_t          GetTitleXOffset() const ; //return X axis title offset
  Float_t          GetTitleXSize() const   ;   //return X axis title size
  Float_t          GetTitleYOffset() const ; //return Y axis title offset
  Float_t          GetTitleYSize() const   ;   //return Y axis title size
  Float_t          GetTitleX() const     ;  //return left X position of histogram title TPavelabel
  Float_t          GetTitleY() const     ;  //return left bottom position of histogram title TPavelabel
  Float_t          GetTitleW() const     ;  //return width of histogram title TPaveLabel
  Float_t          GetTitleH() const     ;  //return height of histogram title TPavelabel
  const char      *GetHeaderPS() const ;
  const char      *GetTitlePS()  const ;
  const char      *GetLineStyleString(Int_t i=1) const;
  Float_t          GetLineScalePS() const ;
  Bool_t           IsReading() const ;
  virtual void     Paint(Option_t *option="");
  virtual void     Reset(Option_t *option="");

  void             SetColorModelPS(Int_t c=0);
  void             SetFitFormat(const char *format="5.4g") ;
  void             SetHeaderPS(const char *header);
  void             SetHatchesLineWidth(Int_t l) ;
  void             SetHatchesSpacing(Double_t h) ;
  void             SetTitlePS(const char *pstitle);
  void             SetLineScalePS(Float_t scale=3) ;
  void             SetLineStyleString(Int_t i, const char *text);
  void             SetNdivisions(Int_t n=510, Option_t *axis="X");
  void             SetAxisColor(Color_t color=1, Option_t *axis="X");
  void             SetLabelColor(Color_t color=1, Option_t *axis="X");
  void             SetLabelFont(Style_t font=62, Option_t *axis="X");
  void             SetLabelOffset(Float_t offset=0.005, Option_t *axis="X");
  void             SetLabelSize(Float_t size=0.04, Option_t *axis="X");
  void             SetLegoInnerR(Float_t rad=0.5) ;
  void             SetScreenFactor(Float_t factor=1) ;
  void             SetTickLength(Float_t length=0.03, Option_t *axis="X");
  void             SetTitleColor(Color_t color=1, Option_t *axis="X"); //set axis title color or pad title color
  void             SetTitleFont(Style_t font=62, Option_t *axis="X"); //set axis title font or pad title font
  void             SetTitleOffset(Float_t offset=1, Option_t *axis="X"); //set axis title offset
  void             SetTitleSize(Float_t size=0.02, Option_t *axis="X");  //set axis title size or pad title size
  void             SetNumberContours(Int_t number=20);
  void             SetOptDate(Int_t datefl=1);
  void             SetOptFile(Int_t file=1) ;
  void             SetOptFit(Int_t fit=1);
  void             SetOptLogx(Int_t logx=1) ;
  void             SetOptLogy(Int_t logy=1) ;
  void             SetOptLogz(Int_t logz=1) ;
  void             SetOptStat(Int_t stat=1);
  void             SetOptStat(Option_t *stat);
  void             SetOptTitle(Int_t tit=1) ;
  void             SetBarOffset(Float_t baroff=0.5) ;
  void             SetBarWidth(Float_t barwidth=0.5) ;
  void             SetDateX(Float_t x=0.01) ;
  void             SetDateY(Float_t y=0.01) ;
  void             SetEndErrorSize(Float_t np=2);
  void             SetErrorX(Float_t errorx=0.5) ;
  void             SetCanvasPreferGL(Bool_t prefer = kTRUE) ;
  void             SetDrawBorder(Int_t drawborder=1) ;
  void             SetCanvasColor(Color_t color=19) ;
  void             SetCanvasBorderSize(Width_t size=1) ;
  void             SetCanvasBorderMode(Int_t mode=1) ;
  void             SetCanvasDefH(Int_t h=500) ;
  void             SetCanvasDefW(Int_t w=700) ;
  void             SetCanvasDefX(Int_t topx=10) ;
  void             SetCanvasDefY(Int_t topy=10) ;
  void             SetLegendBorderSize(Width_t size=4) ;
  void             SetLegendFillColor(Color_t color=0) ;
  void             SetLegendFont(Style_t font=62) ;
  void             SetPadColor(Color_t color=19) ;
  void             SetPadBorderSize(Width_t size=1) ;
  void             SetPadBorderMode(Int_t mode=1) ;
  void             SetPadBottomMargin(Float_t margin=0.1) ;
  void             SetPadTopMargin(Float_t margin=0.1)    ;
  void             SetPadLeftMargin(Float_t margin=0.1)   ;
  void             SetPadRightMargin(Float_t margin=0.1)  ;
  void             SetPadGridX(Bool_t gridx) ;
  void             SetPadGridY(Bool_t gridy) ;
  void             SetPadTickX(Int_t tickx)  ;
  void             SetPadTickY(Int_t ticky)  ;
  void             SetFuncStyle(Style_t style=1) ;
  void             SetFuncColor(Color_t color=1) ;
  void             SetFuncWidth(Width_t width=4) ;
  void             SetGridStyle(Style_t style=3) ;
  void             SetGridColor(Color_t color=0) ;
  void             SetGridWidth(Width_t width=1) ;
  void             SetFrameFillColor(Color_t color=1) ;
  void             SetFrameLineColor(Color_t color=1) ;
  void             SetFrameFillStyle(Style_t styl=0)  ;
  void             SetFrameLineStyle(Style_t styl=0)  ;
  void             SetFrameLineWidth(Width_t width=1) ;
  void             SetFrameBorderSize(Width_t size=1) ;
  void             SetFrameBorderMode(Int_t mode=1) ;
  void             SetHistFillColor(Color_t color=1) ;
  void             SetHistLineColor(Color_t color=1) ;
  void             SetHistFillStyle(Style_t styl=0)  ;
  void             SetHistLineStyle(Style_t styl=0)  ;
  void             SetHistLineWidth(Width_t width=1) ;
  void             SetHistMinimumZero(Bool_t zero=kTRUE);
  void             SetHistTopMargin(Double_t hmax=0.05) ;
  void             SetPaintTextFormat(const char *format="g") ;
  void             SetPaperSize(EPaperSize size);
  void             SetPaperSize(Float_t xsize=20, Float_t ysize=26);
  void             SetStatColor(Int_t color=19) ;
  void             SetStatTextColor(Int_t color=1) ;
  void             SetStatStyle(Style_t style=1001) ;
  void             SetStatBorderSize(Width_t size=2) ;
  void             SetStatFont(Style_t font=62) ;
  void             SetStatFontSize(Float_t size=0)  ;
  void             SetStatFormat(const char *format="6.4g") ;
  void             SetStatX(Float_t x=0)    ;
  void             SetStatY(Float_t y=0)    ;
  void             SetStatW(Float_t w=0.19) ;
  void             SetStatH(Float_t h=0.1)  ;
  void             SetStripDecimals(Bool_t strip=kTRUE);
  void             SetTimeOffset(Double_t toffset);
  void             SetTitleAlign(Int_t a=13) ;
  void             SetTitleFillColor(Color_t color=1)   ;
  void             SetTitleTextColor(Color_t color=1)   ;
  void             SetTitleStyle(Style_t style=1001)  ;
  void             SetTitleFontSize(Float_t size=0)   ;
  void             SetTitleBorderSize(Width_t size=2) ;
  void             SetTitleXOffset(Float_t offset=1)  ;
  void             SetTitleXSize(Float_t size=0.02)   ;
  void             SetTitleYOffset(Float_t offset=1)  ;
  void             SetTitleYSize(Float_t size=0.02)   ;
  void             SetTitleX(Float_t x=0)     ;
  void             SetTitleY(Float_t y=0.985) ;
  void             SetTitleW(Float_t w=0)     ;
  void             SetTitleH(Float_t h=0)     ;
  void             ToggleEventStatus() ;
  void             ToggleEditor() ;
  void             ToggleToolBar() ;
  void             SetIsReading(Bool_t reading=kTRUE);
  void             SetPalette(Int_t ncolors=0, Int_t *colors=0);
  void             SavePrimitive(ostream &out, Option_t * = "");
  void             SaveSource(const char *filename, Option_t *option=0);
};

%inline {
  TStyle* getStyle()
  {
    return gStyle;
  }
}


class TColor : public TNamed
{
public:
  TColor();
  TColor(Int_t color, Float_t r, Float_t g, Float_t b, const char *name="", Float_t a = 1);
  TColor(const TColor &color);
  virtual ~TColor();
  const char   *AsHexString() const;
  void          Copy(TObject &color) const;
  static void   CreateColorWheel();
  static void   CreateColorsGray();
  static void   CreateColorsCircle(Int_t offset, const char *name, UChar_t *rgb);
  static void   CreateColorsRectangle(Int_t offset, const char *name, UChar_t *rgb); 
  static Int_t  CreateGradientColorTable(UInt_t Number, Double_t* Stops,
                                         Double_t* Red, Double_t* Green, Double_t* Blue, UInt_t NColors);
  static Int_t  GetColorPalette(Int_t i);
  static Int_t  GetNumberOfColors();
  virtual void  GetRGB(Float_t &r, Float_t &g, Float_t &b) const ;

  virtual void  GetHLS(Float_t &h, Float_t &l, Float_t &s) const;

  Int_t         GetNumber() const;
  ULong_t       GetPixel() const;
  Float_t       GetRed() const ;
  Float_t       GetGreen() const ;
  Float_t       GetBlue() const ;
  Float_t       GetHue() const ;
  Float_t       GetLight() const ;
  Float_t       GetSaturation() const ;
  Float_t       GetAlpha() const ;
  virtual Float_t GetGrayscale() const ;
  virtual void  ls(Option_t *option="") const;
  virtual void  Print(Option_t *option="") const;
  virtual void  SetAlpha(Float_t a);
  virtual void  SetRGB(Float_t r, Float_t g, Float_t b);
  
  static void    InitializeColors();
  static void    HLS2RGB(Float_t h, Float_t l, Float_t s, Float_t &r, Float_t &g, Float_t &b);
  static void    HLS2RGB(Int_t h, Int_t l, Int_t s, Int_t &r, Int_t &g, Int_t &b);
  static void    HLStoRGB(Float_t h, Float_t l, Float_t s, Float_t &r, Float_t &g, Float_t &b);

  static void    HSV2RGB(Float_t h, Float_t s, Float_t v, Float_t &r, Float_t &g, Float_t &b);
  static void    RGB2HLS(Float_t r, Float_t g, Float_t b, Float_t &h, Float_t &l, Float_t &s);
  static void    RGB2HLS(Int_t r, Int_t g, Int_t b, Int_t &h, Int_t &l, Int_t &s);
  static void    RGBtoHLS(Float_t r, Float_t g, Float_t b, Float_t &h, Float_t &l, Float_t &s);

  static void    RGB2HSV(Float_t r, Float_t g, Float_t b, Float_t &h, Float_t &s, Float_t &v);
  static Int_t   GetColor(const char *hexcolor);
  static Int_t   GetColor(Float_t r, Float_t g, Float_t b);
  static Int_t   GetColor(Int_t r, Int_t g, Int_t b);
  static Int_t   GetColor(ULong_t pixel);
  static Int_t   GetColorBright(Int_t color);
  static Int_t   GetColorDark(Int_t color);
  static ULong_t Number2Pixel(Int_t ci);
  static ULong_t RGB2Pixel(Int_t r, Int_t g, Int_t b);
  static ULong_t RGB2Pixel(Float_t r, Float_t g, Float_t b);
  static void    Pixel2RGB(ULong_t pixel, Int_t &r, Int_t &g, Int_t &b);
  static void    Pixel2RGB(ULong_t pixel, Float_t &r, Float_t &g, Float_t &b);
  static const char *PixelAsHexString(ULong_t pixel);
  static void    SaveColor(ostream &out, Int_t ci);
  static Bool_t  IsGrayscale();
  static void    SetGrayscale(Bool_t set = kTRUE);
  static void    SetPalette(Int_t ncolors, Int_t *colors);
};
