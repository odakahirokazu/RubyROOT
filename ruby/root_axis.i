/**************************************************************************/
/* Axis classes                                                           */
/**************************************************************************/

class TAttAxis
{
public:
  TAttAxis();
  virtual          ~TAttAxis();
  void     Copy(TAttAxis &attaxis) const;
  virtual Int_t    GetNdivisions()  const ;
  virtual Color_t  GetAxisColor()   const ;
  virtual Color_t  GetLabelColor()  const ;
  virtual Style_t  GetLabelFont()   const ;
  virtual Float_t  GetLabelOffset() const ;
  virtual Float_t  GetLabelSize()   const ;
  virtual Float_t  GetTitleOffset() const ;
  virtual Float_t  GetTitleSize()   const ;
  virtual Float_t  GetTickLength()  const ;
  virtual Color_t  GetTitleColor()  const ;
  virtual Style_t  GetTitleFont()   const ;
  virtual void     ResetAttAxis(Option_t *option="");
  virtual void     SaveAttributes(ostream &out, const char *name, const char *subname);
  virtual void     SetNdivisions(Int_t n=510, Bool_t optim=kTRUE);  // *MENU*
  virtual void     SetNdivisions(Int_t n1, Int_t n2, Int_t n3, Bool_t optim=kTRUE);
  virtual void     SetAxisColor(Color_t color=1);        // *MENU*
  virtual void     SetLabelColor(Color_t color=1);       // *MENU*
  virtual void     SetLabelFont(Style_t font=62);        // *MENU*
  virtual void     SetLabelOffset(Float_t offset=0.005); // *MENU*
  virtual void     SetLabelSize(Float_t size=0.04);      // *MENU*
  virtual void     SetTickLength(Float_t length=0.03);   // *MENU*
  virtual void     SetTitleOffset(Float_t offset=1);     // *MENU*
  virtual void     SetTitleSize(Float_t size=0.04);      // *MENU*
  virtual void     SetTitleColor(Color_t color=1);       // *MENU*
  virtual void     SetTitleFont(Style_t font=62);        // *MENU*
};


class TAxis : public TNamed, public TAttAxis
{
public:
  TAxis();
  TAxis(Int_t nbins, Double_t xmin, Double_t xmax);
  TAxis(Int_t nbins, const Double_t *xbins);
  TAxis(const TAxis &axis);
  virtual ~TAxis();
  // TAxis& operator=(const TAxis&);

  virtual void       CenterLabels(Bool_t center=kTRUE);  // *TOGGLE* *GETTER=GetCenterLabels
  virtual void       CenterTitle(Bool_t center=kTRUE);  // *TOGGLE* *GETTER=GetCenterTitle
  const char        *ChooseTimeFormat(Double_t axislength=0);
  virtual void       Copy(TObject &axis) const;
  virtual void       Delete(Option_t * /*option*/ ="") ;
  virtual Int_t      DistancetoPrimitive(Int_t px, Int_t py);
  virtual TObject   *DrawClone(Option_t * /*option*/ ="") const ;
  virtual void       ExecuteEvent(Int_t event, Int_t px, Int_t py);
  virtual Int_t      FindBin(Double_t x);
  virtual Int_t      FindBin(const char *label);
  virtual Int_t      FindFixBin(Double_t x) const;
  virtual Double_t   GetBinCenter(Int_t bin) const;
  virtual Double_t   GetBinCenterLog(Int_t bin) const;
  const char        *GetBinLabel(Int_t bin) const;
  virtual Double_t   GetBinLowEdge(Int_t bin) const;
  virtual Double_t   GetBinUpEdge(Int_t bin) const;
  virtual Double_t   GetBinWidth(Int_t bin) const;
  virtual void       GetCenter(Double_t *center) const;
  Bool_t     GetCenterLabels() const;
  Bool_t     GetCenterTitle() const;
  THashList         *GetLabels() ;
  virtual void       GetLowEdge(Double_t *edge) const;
  Bool_t     GetMoreLogLabels() const;
  Int_t      GetNbins() const ;
  Bool_t     GetNoExponent() const;
  Bool_t     GetDecimals() const;
  virtual TObject   *GetParent() const ;
  Bool_t     GetRotateTitle() const;
  virtual const char *GetTicks() const;
  virtual Bool_t     GetTimeDisplay() const ;
  virtual const char *GetTimeFormat() const ;
  virtual const char *GetTimeFormatOnly() const;
  const char        *GetTitle() const ;
  const TArrayD     *GetXbins() const ;
  Int_t      GetFirst() const;
  Int_t      GetLast() const;
  Double_t   GetXmin() const ;
  Double_t   GetXmax() const ;
  virtual void       ImportAttributes(const TAxis *axis);
  Bool_t             IsVariableBinSize() const;
  virtual void       LabelsOption(Option_t *option="h");  // *MENU*
  virtual void       RotateTitle(Bool_t rotate=kTRUE); // *TOGGLE* *GETTER=GetRotateTitle
  virtual void       SaveAttributes(ostream &out, const char *name, const char *subname);
  virtual void       Set(Int_t nbins, Double_t xmin, Double_t xmax);
  virtual void       Set(Int_t nbins, const Float_t *xbins);
  virtual void       Set(Int_t nbins, const Double_t *xbins);
  virtual void       SetBinLabel(Int_t bin, const char *label);
  virtual void       SetDefaults();
  virtual void       SetDrawOption(Option_t * /*option*/ ="") ;
  virtual void       SetLimits(Double_t xmin, Double_t xmax);
  virtual void       SetMoreLogLabels(Bool_t more=kTRUE);  // *TOGGLE* *GETTER=GetMoreLogLabels
  virtual void       SetNoExponent(Bool_t noExponent=kTRUE);  // *TOGGLE* *GETTER=GetNoExponent
  virtual void       SetDecimals(Bool_t dot=kTRUE);  // *TOGGLE* *GETTER=GetDecimals
  virtual void       SetParent(TObject *obj) ;
  virtual void       SetRange(Int_t first=0, Int_t last=0);  // *MENU*
  virtual void       SetRangeUser(Double_t ufirst, Double_t ulast);  // *MENU*
  virtual void       SetTicks(Option_t *option="+"); // *MENU*
  virtual void       SetTimeDisplay(Int_t value) ; // *TOGGLE*
  virtual void       SetTimeFormat(const char *format="");  // *MENU*
  virtual void       SetTimeOffset(Double_t toffset, Option_t *option="local");
  virtual void       UnZoom();  // *MENU*
  virtual void       ZoomOut(Double_t factor=0, Double_t offset=0);  // *MENU*
};

