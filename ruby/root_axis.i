/**************************************************************************/
/* Axis classes                                                           */
/**************************************************************************/

class TAxis : public TNamed, public TAttAxis {
public:
  TAxis();
  TAxis(Int_t nbins, Double_t xmin, Double_t xmax);
  TAxis(Int_t nbins, const Double_t *xbins);
  TAxis(const TAxis &axis);
  virtual ~TAxis();

  Bool_t     CanExtend() const { return (fBits2 & kCanExtend);  }
  void       SetCanExtend(Bool_t canExtend) { fBits2 = canExtend ? (fBits2 | kCanExtend) : (fBits2 & ~kCanExtend); }
  void       SetNoAlphanumeric(Bool_t noalpha = kTRUE) {
    fBits2 = noalpha ? (fBits2 | kNotAlpha) : (fBits2 & ~kNotAlpha);
    if (IsAlphanumeric() ) {
      SetCanExtend(kFALSE);
      SetAlphanumeric(kFALSE);
    }
  }
  void               CenterLabels(Bool_t center=kTRUE);
  void               CenterTitle(Bool_t center=kTRUE);
  const char        *ChooseTimeFormat(Double_t axislength=0);
  virtual void       Copy(TObject &axis) const;
  virtual void       Delete(Option_t * /*option*/ ="") { }
  virtual Int_t      DistancetoPrimitive(Int_t px, Int_t py);
  virtual TObject   *DrawClone(Option_t * /*option*/ ="") const {return 0;}
  virtual void       ExecuteEvent(Int_t event, Int_t px, Int_t py);
  virtual Int_t      FindBin(Double_t x);
  virtual Int_t      FindBin(Double_t x) const { return FindFixBin(x); }
  virtual Int_t      FindBin(const char *label);
  virtual Int_t      FindFixBin(Double_t x) const;
  virtual Int_t      FindFixBin(const char *label) const;
  virtual Double_t   GetBinCenter(Int_t bin) const;
  virtual Double_t   GetBinCenterLog(Int_t bin) const;
  const char        *GetBinLabel(Int_t bin) const;
  virtual Double_t   GetBinLowEdge(Int_t bin) const;
  virtual Double_t   GetBinUpEdge(Int_t bin) const;
  virtual Double_t   GetBinWidth(Int_t bin) const;
  virtual void       GetCenter(Double_t *center) const;
  Bool_t     GetCenterLabels() const { return TestBit(kCenterLabels); }
  Bool_t     GetCenterTitle() const { return TestBit(kCenterTitle); }
  Bool_t     GetDecimals() const { return TestBit(kDecimals); }
  THashList         *GetLabels() const { return fLabels; }
  virtual void       GetLowEdge(Double_t *edge) const;
  Bool_t     GetMoreLogLabels() const { return TestBit(kMoreLogLabels); }
  Int_t      GetNbins() const { return fNbins; }
  Bool_t     GetNoExponent() const { return TestBit(kNoExponent); }
  virtual TObject   *GetParent() const {return fParent;}
  Bool_t     GetRotateTitle() const { return TestBit(kRotateTitle); }
  virtual const char *GetTicks() const;
  virtual Bool_t     GetTimeDisplay() const {return fTimeDisplay;}
  virtual const char *GetTimeFormat() const {return fTimeFormat.Data();}
  virtual const char *GetTimeFormatOnly() const;
  const char        *GetTitle() const {return fTitle.Data();}
  const TArrayD     *GetXbins() const {return &fXbins;}
  Int_t      GetFirst() const;
  Int_t      GetLast() const;
  Double_t   GetXmin() const {return fXmin;}
  Double_t   GetXmax() const {return fXmax;}
  virtual void       ImportAttributes(const TAxis *axis);
  Bool_t             IsVariableBinSize() const {
    // true if axis has variable bin sizes, false otherwise
    return (fXbins.GetSize() != 0);
  }
  virtual void       LabelsOption(Option_t *option="h");  // *MENU*
  void       RotateTitle(Bool_t rotate=kTRUE); // *TOGGLE* *GETTER=GetRotateTitle
  virtual void       SaveAttributes(std::ostream &out, const char *name, const char *subname);
  virtual void       Set(Int_t nbins, Double_t xmin, Double_t xmax);
  virtual void       Set(Int_t nbins, const Float_t *xbins);
  virtual void       Set(Int_t nbins, const Double_t *xbins);
  virtual void       SetBinLabel(Int_t bin, const char *label);
  void       SetDecimals(Bool_t dot = kTRUE); // *TOGGLE* *GETTER=GetDecimals
  virtual void       SetDefaults();
  virtual void       SetDrawOption(Option_t * /*option*/ ="") { }
  virtual void       SetLimits(Double_t xmin, Double_t xmax) { /* set axis limits */ fXmin = xmin; fXmax = xmax; }
  void       SetMoreLogLabels(Bool_t more=kTRUE);  // *TOGGLE* *GETTER=GetMoreLogLabels
  void       SetNoExponent(Bool_t noExponent=kTRUE);  // *TOGGLE* *GETTER=GetNoExponent
  virtual void       SetParent(TObject *obj) {fParent = obj;}
  virtual void       SetRange(Int_t first=0, Int_t last=0);  // *MENU*
  virtual void       SetRangeUser(Double_t ufirst, Double_t ulast);  // *MENU*
  virtual void       SetTicks(Option_t *option="+"); // *MENU*
  virtual void       SetTimeDisplay(Int_t value) {fTimeDisplay = (value != 0);} // *TOGGLE*
  virtual void       SetTimeFormat(const char *format="");  // *MENU*
  virtual void       SetTimeOffset(Double_t toffset, Option_t *option="local");
  virtual void       UnZoom();  // *MENU*
  virtual void       ZoomOut(Double_t factor=0, Double_t offset=0);  // *MENU*
};
