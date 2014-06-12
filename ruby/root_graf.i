/**************************************************************************/
/* Graphics classes                                                          */
/**************************************************************************/

class TLine : public TObject, public TAttLine {
public:
  // TLine status bits
  // enum {
  //   kLineNDC    = BIT(14), // Use NDC coordinates
  //   kVertical   = BIT(15), // Line is vertical
  //   kHorizontal = BIT(16)  // Line is horizontal
  // };

  TLine();
  TLine(Double_t x1, Double_t y1,Double_t x2, Double_t  y2);
  TLine(const TLine &line);
  virtual ~TLine();

  void           Copy(TObject &line) const;
  virtual Int_t  DistancetoPrimitive(Int_t px, Int_t py);
  virtual TLine *DrawLine(Double_t x1, Double_t y1,Double_t x2, Double_t y2);
  virtual TLine *DrawLineNDC(Double_t x1, Double_t y1,Double_t x2, Double_t y2);
  virtual void   ExecuteEvent(Int_t event, Int_t px, Int_t py);
  Double_t       GetX1() const ;
  Double_t       GetX2() const ;
  Double_t       GetY1() const ;
  Double_t       GetY2() const ;
  Bool_t         IsHorizontal();
  Bool_t         IsVertical();
  virtual void   ls(Option_t *option="") const;
  virtual void   Paint(Option_t *option="");
  virtual void   PaintLine(Double_t x1, Double_t y1,Double_t x2, Double_t  y2);
  virtual void   PaintLineNDC(Double_t u1, Double_t v1,Double_t u2, Double_t  v2);
  virtual void   Print(Option_t *option="") const;
  virtual void   SavePrimitive(ostream &out, Option_t *option = "");
  void           SetHorizontal(Bool_t set = kTRUE); // *TOGGLE* *GETTER=IsHorizontal
  void           SetVertical(Bool_t set = kTRUE); // *TOGGLE* *GETTER=IsVertical
  virtual void   SetX1(Double_t x1) ;
  virtual void   SetX2(Double_t x2) ;
  virtual void   SetY1(Double_t y1) ;
  virtual void   SetY2(Double_t y2) ;
};


class TBox : public TObject, public TAttLine, public TAttFill {
public:
  //----- Private bits, clients can only test but not change them
  // enum {
  //   kCannotMove    = BIT(12)  //if set the box cannot be moved/resized
  // };
  TBox();
  TBox(Double_t x1, Double_t y1,Double_t x2, Double_t  y2);
  TBox(const TBox &box);
  // TBox& operator=(const TBox&);
  virtual ~TBox();
  void Copy(TObject &box) const;
  virtual Int_t DistancetoPrimitive(Int_t px, Int_t py);
  virtual void  Draw(Option_t *option="");
  virtual TBox *DrawBox(Double_t x1, Double_t y1, Double_t x2, Double_t  y2);
  virtual void  ExecuteEvent(Int_t event, Int_t px, Int_t py);
  Bool_t        IsBeingResized() const ;
  Double_t      GetX1() const ;
  Double_t      GetX2() const ;
  Double_t      GetY1() const ;
  Double_t      GetY2() const ;
  virtual void  HideToolTip(Int_t event);
  virtual Int_t IsInside(Double_t x, Double_t y) const;
  virtual void  ls(Option_t *option="") const;
  virtual void  Paint(Option_t *option="");
  virtual void  PaintBox(Double_t x1, Double_t y1, Double_t x2, Double_t y2, Option_t *option="");
  virtual void  Print(Option_t *option="") const;
  virtual void  SavePrimitive(ostream &out, Option_t *option = "");
  virtual void  SetX1(Double_t x1) ;
  virtual void  SetX2(Double_t x2) ;
  virtual void  SetY1(Double_t y1) ;
  virtual void  SetY2(Double_t y2) ;
  virtual void  SetToolTipText(const char *text, Long_t delayms = 1000);
};


class TEllipse : public TObject, public TAttLine, public TAttFill {
public:
  // TEllipse status bits
  // enum {
  //   kNoEdges     = BIT(9)   // don't draw lines connecting center to edges
  // };
  TEllipse();
  TEllipse(Double_t x1, Double_t y1,Double_t r1,Double_t r2=0,Double_t phimin=0, Double_t phimax=360,Double_t theta=0);
  TEllipse(const TEllipse &ellipse);
  virtual ~TEllipse();
  void   Copy(TObject &ellipse) const;
  virtual Int_t  DistancetoPrimitive(Int_t px, Int_t py);
  virtual void   Draw(Option_t *option="");
  virtual void   DrawEllipse(Double_t x1, Double_t y1, Double_t r1,Double_t r2,Double_t phimin, Double_t phimax,Double_t theta,Option_t *option="");
  virtual void   ExecuteEvent(Int_t event, Int_t px, Int_t py);
  Double_t       GetX1() const ;
  Double_t       GetY1() const ;
  Double_t       GetR1() const ;
  Double_t       GetR2() const ;
  Double_t       GetPhimin() const ;
  Double_t       GetPhimax() const ;
  Double_t       GetTheta() const  ;
  Bool_t         GetNoEdges() const;
  virtual void   ls(Option_t *option="") const;
  virtual void   Paint(Option_t *option="");
  virtual void   PaintEllipse(Double_t x1, Double_t y1, Double_t r1,Double_t r2,Double_t phimin, Double_t phimax,Double_t theta,Option_t *option="");
  virtual void   Print(Option_t *option="") const;
  virtual void   SavePrimitive(ostream &out, Option_t *option = "");
  virtual void   SetNoEdges(Bool_t noEdges=kTRUE); // *TOGGLE* *GETTER=GetNoEdges
  virtual void   SetPhimin(Double_t phi=0)   ; // *MENU*
  virtual void   SetPhimax(Double_t phi=360) ; // *MENU*
  virtual void   SetR1(Double_t r1) ; // *MENU*
  virtual void   SetR2(Double_t r2) ; // *MENU*
  virtual void   SetTheta(Double_t theta=0) ; // *MENU*
  virtual void   SetX1(Double_t x1) ; // *MENU*
  virtual void   SetY1(Double_t y1) ; // *MENU*
};


class TArrow : public TLine, public TAttFill {
public:
  TArrow();
  TArrow(Double_t x1, Double_t y1,Double_t x2 ,Double_t y2
         ,Float_t arrowsize=0.05
         ,Option_t *option=">");
  TArrow(const TArrow &arrow);
  virtual ~TArrow();
  void Copy(TObject &arrow) const;

  virtual void   Draw(Option_t *option="");
  virtual void   DrawArrow(Double_t x1, Double_t y1,Double_t x2 ,Double_t y2
                           ,Float_t arrowsize=0 ,Option_t *option="");
  Float_t        GetAngle() const;
  Float_t        GetArrowSize() const;
  Option_t      *GetOption() const;
  virtual void   Paint(Option_t *option="");
  virtual void   PaintArrow(Double_t x1, Double_t y1,Double_t x2 ,Double_t y2
                            ,Float_t arrowsize=0.05 ,Option_t *option=">");
  virtual void   SavePrimitive(ostream &out, Option_t *option = "");
  virtual void   SetAngle(Float_t angle=60);
  virtual void   SetArrowSize(Float_t arrowsize=0.05);
  virtual void   SetOption(Option_t *option=">");

  static void SetDefaultAngle     (Float_t  Angle    );
  static void SetDefaultArrowSize (Float_t  ArrowSize);  
  static void SetDefaultOption    (Option_t *Option  );
  static Float_t GetDefaultAngle    ();
  static Float_t GetDefaultArrowSize();
  static Option_t *GetDefaultOption ();
};
