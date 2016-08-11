/**************************************************************************/
/* Graphics classes                                                          */
/**************************************************************************/

class TLine : public TObject, public TAttLine, public TAttBBox2D {
public:
  TLine();
  TLine(Double_t x1, Double_t y1,Double_t x2, Double_t  y2);
  TLine(const TLine &line);
  virtual ~TLine();

  void                 Copy(TObject &line) const;
  virtual Int_t        DistancetoPrimitive(Int_t px, Int_t py);
  virtual TLine       *DrawLine(Double_t x1, Double_t y1,Double_t x2, Double_t y2);
  virtual TLine       *DrawLineNDC(Double_t x1, Double_t y1,Double_t x2, Double_t y2);
  virtual void         ExecuteEvent(Int_t event, Int_t px, Int_t py);
  Double_t             GetX1() const {return fX1;}
  Double_t             GetX2() const {return fX2;}
  Double_t             GetY1() const {return fY1;}
  Double_t             GetY2() const {return fY2;}
  Bool_t               IsHorizontal();
  Bool_t               IsVertical();
  virtual void         ls(Option_t *option="") const;
  virtual void         Paint(Option_t *option="");
  virtual void         PaintLine(Double_t x1, Double_t y1,Double_t x2, Double_t  y2);
  virtual void         PaintLineNDC(Double_t u1, Double_t v1,Double_t u2, Double_t  v2);
  virtual void         Print(Option_t *option="") const;
  virtual void         SavePrimitive(std::ostream &out, Option_t *option = "");
  virtual void         SetNDC(Bool_t isNDC=kTRUE);
  void                 SetHorizontal(Bool_t set = kTRUE); // *TOGGLE* *GETTER=IsHorizontal
  void                 SetVertical(Bool_t set = kTRUE); // *TOGGLE* *GETTER=IsVertical
  virtual void         SetX1(Double_t x1) {fX1=x1;}
  virtual void         SetX2(Double_t x2) {fX2=x2;}
  virtual void         SetY1(Double_t y1) {fY1=y1;}
  virtual void         SetY2(Double_t y2) {fY2=y2;}
  virtual Rectangle_t  GetBBox();
  virtual TPoint       GetBBoxCenter();
  virtual void         SetBBoxCenter(const TPoint &p);
  virtual void         SetBBoxCenterX(const Int_t x);
  virtual void         SetBBoxCenterY(const Int_t y);
  virtual void         SetBBoxX1(const Int_t x);
  virtual void         SetBBoxX2(const Int_t x);
  virtual void         SetBBoxY1(const Int_t y);
  virtual void         SetBBoxY2(const Int_t y);
};


class TBox : public TObject, public TAttLine, public TAttFill, public TAttBBox2D {
public:
  TBox();
  TBox(Double_t x1, Double_t y1,Double_t x2, Double_t  y2);
  TBox(const TBox &box);

  virtual ~TBox();
  void Copy(TObject &box) const;
  virtual Int_t DistancetoPrimitive(Int_t px, Int_t py);
  virtual void  Draw(Option_t *option="");
  virtual TBox *DrawBox(Double_t x1, Double_t y1, Double_t x2, Double_t  y2);
  virtual void  ExecuteEvent(Int_t event, Int_t px, Int_t py);
  Bool_t        IsBeingResized() const { return fResizing; }
  Double_t      GetX1() const { return fX1; }
  Double_t      GetX2() const { return fX2; }
  Double_t      GetY1() const { return fY1; }
  Double_t      GetY2() const { return fY2; }
  virtual void  HideToolTip(Int_t event);
  virtual Int_t IsInside(Double_t x, Double_t y) const;
  virtual void  ls(Option_t *option="") const;
  virtual void  Paint(Option_t *option="");
  virtual void  PaintBox(Double_t x1, Double_t y1, Double_t x2, Double_t y2, Option_t *option="");
  virtual void  Print(Option_t *option="") const;
  virtual void  SavePrimitive(std::ostream &out, Option_t *option = "");
  virtual void  SetX1(Double_t x1) {fX1=x1;}
  virtual void  SetX2(Double_t x2) {fX2=x2;}
  virtual void  SetY1(Double_t y1) {fY1=y1;}
  virtual void  SetY2(Double_t y2) {fY2=y2;}
  virtual void  SetToolTipText(const char *text, Long_t delayms = 1000);
  virtual Rectangle_t  GetBBox();
  virtual TPoint       GetBBoxCenter();
  virtual void         SetBBoxCenter(const TPoint &p);
  virtual void         SetBBoxCenterX(const Int_t x);
  virtual void         SetBBoxCenterY(const Int_t y);
  virtual void         SetBBoxX1(const Int_t x);
  virtual void         SetBBoxX2(const Int_t x);
  virtual void         SetBBoxY1(const Int_t y);
  virtual void         SetBBoxY2(const Int_t y);
};


class TEllipse : public TObject, public TAttLine, public TAttFill, public TAttBBox2D {
public:
  TEllipse();
  TEllipse(Double_t x1, Double_t y1,Double_t r1,Double_t r2=0,Double_t phimin=0, Double_t phimax=360,Double_t theta=0);
  TEllipse(const TEllipse &ellipse);
  virtual ~TEllipse();
  void   Copy(TObject &ellipse) const;
  virtual Int_t        DistancetoPrimitive(Int_t px, Int_t py);
  virtual void         Draw(Option_t *option="");
  virtual void         DrawEllipse(Double_t x1, Double_t y1, Double_t r1,Double_t r2,Double_t phimin, Double_t phimax,Double_t theta,Option_t *option="");
  virtual void         ExecuteEvent(Int_t event, Int_t px, Int_t py);
  Double_t             GetX1() const {return fX1;}
  Double_t             GetY1() const {return fY1;}
  Double_t             GetR1() const {return fR1;}
  Double_t             GetR2() const {return fR2;}
  Double_t             GetPhimin() const {return fPhimin;}
  Double_t             GetPhimax() const {return fPhimax;}
  Double_t             GetTheta() const  {return fTheta;}
  Bool_t               GetNoEdges() const;
  virtual void         ls(Option_t *option="") const;
  virtual void         Paint(Option_t *option="");
  virtual void         PaintEllipse(Double_t x1, Double_t y1, Double_t r1,Double_t r2,Double_t phimin, Double_t phimax,Double_t theta,Option_t *option="");
  virtual void         Print(Option_t *option="") const;
  virtual void         SavePrimitive(std::ostream &out, Option_t *option = "");
  virtual void         SetNoEdges(Bool_t noEdges=kTRUE); // *TOGGLE* *GETTER=GetNoEdges
  virtual void         SetPhimin(Double_t phi=0)   {fPhimin=phi;} // *MENU*
  virtual void         SetPhimax(Double_t phi=360) {fPhimax=phi;} // *MENU*
  virtual void         SetR1(Double_t r1) {fR1=r1;} // *MENU*
  virtual void         SetR2(Double_t r2) {fR2=r2;} // *MENU*
  virtual void         SetTheta(Double_t theta=0) {fTheta=theta;} // *MENU*
  virtual void         SetX1(Double_t x1) {fX1=x1;} // *MENU*
  virtual void         SetY1(Double_t y1) {fY1=y1;} // *MENU*
  virtual Rectangle_t  GetBBox();
  virtual TPoint       GetBBoxCenter();
  virtual void         SetBBoxCenter(const TPoint &p);
  virtual void         SetBBoxCenterX(const Int_t x);
  virtual void         SetBBoxCenterY(const Int_t y);
  virtual void         SetBBoxX1(const Int_t x);
  virtual void         SetBBoxX2(const Int_t x);
  virtual void         SetBBoxY1(const Int_t y);
  virtual void         SetBBoxY2(const Int_t y);
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
  Float_t        GetAngle() const {return fAngle;}
  Float_t        GetArrowSize() const {return fArrowSize;}
  Option_t      *GetOption() const { return fOption.Data();}
  virtual void   Paint(Option_t *option="");
  virtual void   PaintArrow(Double_t x1, Double_t y1,Double_t x2 ,Double_t y2
                            ,Float_t arrowsize=0.05 ,Option_t *option=">");
  virtual void   SavePrimitive(std::ostream &out, Option_t *option = "");
  virtual void   SetAngle(Float_t angle=60) {fAngle=angle;} // *MENU*
  virtual void   SetArrowSize(Float_t arrowsize=0.05) {fArrowSize=arrowsize;} // *MENU*
  virtual void   SetOption(Option_t *option=">"){ fOption = option;}

  static void SetDefaultAngle     (Float_t  Angle    );
  static void SetDefaultArrowSize (Float_t  ArrowSize);
  static void SetDefaultOption    (Option_t *Option  );
  static Float_t GetDefaultAngle    ();
  static Float_t GetDefaultArrowSize();
  static Option_t *GetDefaultOption ();
};
