/**************************************************************************/
/* Canvas classes                                                         */
/**************************************************************************/

class TWbox : public TBox {
public:
  TWbox();
  TWbox(Double_t x1, Double_t y1,Double_t x2 ,Double_t y2,
        Color_t color=18, Short_t bordersize=5 ,Short_t bordermode=1);
  TWbox(const TWbox &wbox);
  virtual ~TWbox();

  void          Copy(TObject &wbox) const;
  virtual void  Draw(Option_t *option="");
  virtual void  DrawWbox(Double_t x1, Double_t y1,Double_t x2 ,Double_t y2,
                         Color_t color=33 ,Short_t bordersize=5 ,Short_t bordermode=-1);
  virtual void  ExecuteEvent(Int_t event, Int_t px, Int_t py);
  Short_t       GetBorderMode() const { return fBorderMode;}
  Short_t       GetBorderSize() const { return fBorderSize;}
  Int_t         GetDarkColor() const  {return TColor::GetColorDark(GetFillColor());}
  Int_t         GetLightColor() const {return TColor::GetColorBright(GetFillColor());}
  virtual void  Paint(Option_t *option="");
  virtual void  PaintFrame(Double_t x1, Double_t y1,Double_t x2 ,Double_t y2,
                           Color_t color, Short_t bordersize, Short_t bordermode,
                           Bool_t tops);
  virtual void  PaintWbox(Double_t x1, Double_t y1,Double_t x2 ,Double_t y2,
                          Color_t color=33, Short_t bordersize=5, Short_t bordermode=-1);
  virtual void  SavePrimitive(std::ostream &out, Option_t *option = "");
  virtual void  SetBorderMode(Short_t bordermode) {fBorderMode = bordermode;} // *MENU*
  virtual void  SetBorderSize(Short_t bordersize) {fBorderSize = bordersize;} // *MENU*
};


class TFrame : public TWbox {
public:
  TFrame();
  TFrame(Double_t x1, Double_t y1,Double_t x2 ,Double_t y2);
  TFrame(const TFrame &frame);
  virtual ~TFrame();
  void  Copy(TObject &frame) const;
  virtual void  Draw(Option_t *option="");
  virtual void  ExecuteEvent(Int_t event, Int_t px, Int_t py);
  virtual void  Paint(Option_t *option="");
  virtual void  Pop();
  virtual void  SavePrimitive(std::ostream &out, Option_t *option = "");
  virtual void  UseCurrentStyle();  // *MENU*
};


class TQObject {
public:
  TQObject();
  virtual ~TQObject();

  TList   *GetListOfClassSignals() const;
  TList   *GetListOfSignals() const { return fListOfSignals; }
  TList   *GetListOfConnections() const { return fListOfConnections; }

  Bool_t   AreSignalsBlocked() const { return fSignalsBlocked; }
  Bool_t   BlockSignals(Bool_t b)
  { Bool_t ret = fSignalsBlocked; fSignalsBlocked = b; return ret; }

  void  CollectClassSignalLists(TList& list, TClass* cls);

  template <typename... T> void EmitVA(const char *signal_name, Int_t /* nargs */, const T&... params);
  // void  EmitVA(const char *signal, Int_t nargs, ...);
  void  EmitVA(const char *signal, Int_t nargs, va_list va) = delete;
  void  Emit(const char *signal);
  void  Emit(const char *signal, Long_t *paramArr);
  void  Emit(const char *signal, const char *params);
  void  Emit(const char *signal, Double_t param);
  void  Emit(const char *signal, Long_t param);
  void  Emit(const char *signal, Long64_t param);
  void  Emit(const char *signal, Bool_t param)
  { Emit(signal, (Long_t)param); }
  void  Emit(const char *signal, Char_t param)
  { Emit(signal, (Long_t)param); }
  void  Emit(const char *signal, UChar_t param)
  { Emit(signal, (Long_t)param); }
  void  Emit(const char *signal, Short_t param)
  { Emit(signal, (Long_t)param); }
  void  Emit(const char *signal, UShort_t param)
  { Emit(signal, (Long_t)param); }
  void  Emit(const char *signal, Int_t param)
  { Emit(signal, (Long_t)param); }
  void  Emit(const char *signal, UInt_t param)
  { Emit(signal, (Long_t)param); }
  void  Emit(const char *signal, ULong_t param)
  { Emit(signal, (Long_t)param); }
  void  Emit(const char *signal, ULong64_t param)
  { Emit(signal, (Long64_t) param); }
  void  Emit(const char *signal, Float_t param)
  { Emit(signal, (Double_t)param); }

  Bool_t Connect(const char *signal,
                 const char *receiver_class,
                 void *receiver,
                 const char *slot);

  Bool_t Disconnect(const char *signal = 0,
                    void *receiver = 0,
                    const char *slot = 0);

  virtual void   HighPriority(const char *signal_name,
                              const char *slot_name = 0);

  virtual void   LowPriority(const char *signal_name,
                             const char *slot_name = 0);

  virtual Bool_t HasConnection(const char *signal_name) const;
  virtual Int_t  NumberOfSignals() const;
  virtual Int_t  NumberOfConnections() const;
  virtual void   Connected(const char * /*signal_name*/) { }
  virtual void   Disconnected(const char * /*signal_name*/) { }

  virtual void   Destroyed()
  { Emit("Destroyed()"); }                 // *SIGNAL*
  virtual void   ChangedBy(const char *method)
  { Emit("ChangedBy(char*)", method); }    // *SIGNAL*
  virtual void   Message(const char *msg)
  { Emit("Message(char*)", msg); }         // *SIGNAL*

#if 0
  static Bool_t  Connect(TQObject *sender,
                         const char *signal,
                         const char *receiver_class,
                         void *receiver,
                         const char *slot);


  static Bool_t  Connect(const char *sender_class,
                         const char *signal,
                         const char *receiver_class,
                         void *receiver,
                         const char *slot);

  static Bool_t  Disconnect(TQObject *sender,
                            const char *signal = 0,
                            void *receiver = 0,
                            const char *slot = 0);

  static Bool_t  Disconnect(const char *class_name,
                            const char *signal,
                            void *receiver = 0,
                            const char *slot = 0);
#endif

  static Bool_t  AreAllSignalsBlocked();
  static Bool_t  BlockAllSignals(Bool_t b);
};


%nodefault;
class TVirtualPad : public TObject, public TAttLine, public TAttFill,
                    public TAttPad, public TQObject {

protected:
  Bool_t         fResizing;         //!true when resizing the pad

  virtual void  *GetSender() { return this; }  //used to set gTQSender

public:
  TVirtualPad();
  TVirtualPad(const char *name, const char *title, Double_t xlow,
              Double_t ylow, Double_t xup, Double_t yup,
              Color_t color=19, Short_t bordersize=4, Short_t bordermode=1);
  virtual ~TVirtualPad();
  virtual void     AbsCoordinates(Bool_t set) = 0;
  virtual Double_t AbsPixeltoX(Int_t px) = 0;
  virtual Double_t AbsPixeltoY(Int_t py) = 0;
  virtual void     AddExec(const char *name, const char *command) = 0;
  virtual TLegend *BuildLegend(Double_t x1=0.5, Double_t y1=0.67, Double_t x2=0.88, Double_t y2=0.88, const char *title="") = 0;
  virtual TVirtualPad* cd(Int_t subpadnumber=0) = 0;
  virtual void     Clear(Option_t *option="") = 0;
  virtual void     Close(Option_t *option="") = 0;
  virtual void     CopyPixmap() = 0;
  virtual void     CopyPixmaps() = 0;
  virtual void     DeleteExec(const char *name) = 0;
  virtual void     Divide(Int_t nx=1, Int_t ny=1, Float_t xmargin=0.01, Float_t ymargin=0.01, Int_t color=0) = 0;
  virtual void     Draw(Option_t *option="") = 0;
  virtual void     DrawClassObject(const TObject *obj, Option_t *option="") = 0;
  virtual TH1F    *DrawFrame(Double_t xmin, Double_t ymin, Double_t xmax, Double_t ymax, const char *title="") = 0;
  virtual void     ExecuteEventAxis(Int_t event, Int_t px, Int_t py, TAxis *axis) = 0;
  virtual Short_t  GetBorderMode() const = 0;
  virtual Short_t  GetBorderSize() const = 0;
  virtual Int_t    GetCanvasID() const = 0;
  virtual TCanvasImp *GetCanvasImp() const = 0;
  virtual TCanvas  *GetCanvas() const = 0;
  virtual TVirtualPad *GetVirtCanvas() const = 0;
  virtual Int_t    GetEvent() const  = 0;
  virtual Int_t    GetEventX() const = 0;
  virtual Int_t    GetEventY() const = 0;
  virtual TFrame   *GetFrame() = 0;
  virtual Color_t  GetHighLightColor() const = 0;
  virtual Int_t    GetNumber() const = 0;
  virtual void     GetRange(Double_t &x1, Double_t &y1, Double_t &x2, Double_t &y2) = 0;
  virtual void     GetRangeAxis(Double_t &xmin, Double_t &ymin, Double_t &xmax, Double_t &ymax) = 0;
  virtual void     GetPadPar(Double_t &xlow, Double_t &ylow, Double_t &xup, Double_t &yup) = 0;
  virtual Double_t GetXlowNDC() const = 0;
  virtual Double_t GetYlowNDC() const = 0;
  virtual Double_t GetWNDC() const = 0;
  virtual Double_t GetHNDC() const = 0;
  virtual UInt_t   GetWw() const = 0;
  virtual UInt_t   GetWh() const = 0;
  virtual Double_t GetAbsXlowNDC() const = 0;
  virtual Double_t GetAbsYlowNDC() const = 0;
  virtual Double_t GetAbsWNDC() const = 0;
  virtual Double_t GetAbsHNDC() const = 0;
  virtual Double_t GetAspectRatio() const = 0;
  virtual Double_t GetPhi() const = 0;
  virtual Double_t GetTheta() const = 0;
  virtual Double_t GetUxmin() const = 0;
  virtual Double_t GetUymin() const = 0;
  virtual Double_t GetUxmax() const = 0;
  virtual Double_t GetUymax() const = 0;
  virtual Bool_t   GetGridx() const = 0;
  virtual Bool_t   GetGridy() const = 0;
  virtual Int_t    GetTickx() const = 0;
  virtual Int_t    GetTicky() const = 0;
  virtual Double_t GetX1() const = 0;
  virtual Double_t GetX2() const = 0;
  virtual Double_t GetY1() const = 0;
  virtual Double_t GetY2() const = 0;
  virtual TList    *GetListOfPrimitives() const = 0;
  virtual TList    *GetListOfExecs() const = 0;
  virtual TObject  *GetPrimitive(const char *name) const = 0;
  virtual TObject  *GetSelected() const = 0;
  virtual TVirtualPad  *GetPad(Int_t subpadnumber) const = 0;
  virtual TObject  *GetPadPointer() const = 0;
  virtual TVirtualPad  *GetPadSave() const = 0;
  virtual TVirtualPad  *GetSelectedPad() const = 0;
  virtual TView    *GetView() const = 0;
  virtual Int_t    GetLogx() const = 0;
  virtual Int_t    GetLogy() const = 0;
  virtual Int_t    GetLogz() const = 0;
  virtual TVirtualPad  *GetMother() const = 0;
  virtual const char *GetName() const = 0;
  virtual const char *GetTitle() const = 0;
  virtual Int_t    GetPadPaint() const = 0;
  virtual Int_t    GetPixmapID() const = 0;
  virtual TObject *GetView3D() const = 0;
  virtual Bool_t   HasCrosshair() const = 0;
  virtual void     HighLight(Color_t col=kRed, Bool_t set=kTRUE) = 0;
  virtual Bool_t   HasFixedAspectRatio() const = 0;
  virtual Bool_t   IsBatch() const = 0;
  Bool_t           IsBeingResized() const { return fResizing; }
  virtual Bool_t   IsEditable() const = 0;
  virtual Bool_t   IsModified() const = 0;
  virtual Bool_t   IsRetained() const = 0;
  virtual Bool_t   IsVertical() const = 0;
  virtual void     ls(Option_t *option="") const = 0;
  virtual void     Modified(Bool_t flag=1) = 0;
  virtual Bool_t   OpaqueMoving() const = 0;
  virtual Bool_t   OpaqueResizing() const = 0;
  virtual Double_t PadtoX(Double_t x) const = 0;
  virtual Double_t PadtoY(Double_t y) const = 0;
  virtual void     Paint(Option_t *option="") = 0;
  virtual void     PaintBorderPS(Double_t xl,Double_t yl,Double_t xt,Double_t yt,Int_t bmode,Int_t bsize,Int_t dark,Int_t light) = 0;
  virtual void     PaintBox(Double_t x1, Double_t y1, Double_t x2, Double_t y2, Option_t *option="") = 0;
  virtual void     PaintFillArea(Int_t n, Float_t *x, Float_t *y, Option_t *option="") = 0;
  virtual void     PaintFillArea(Int_t n, Double_t *x, Double_t *y, Option_t *option="") = 0;
  virtual void     PaintPadFrame(Double_t xmin, Double_t ymin, Double_t xmax, Double_t ymax) = 0;
  virtual void     PaintLine(Double_t x1, Double_t y1, Double_t x2, Double_t y2) = 0;
  virtual void     PaintLineNDC(Double_t u1, Double_t v1,Double_t u2, Double_t v2) = 0;
  virtual void     PaintLine3D(Float_t *p1, Float_t *p2) = 0;
  virtual void     PaintLine3D(Double_t *p1, Double_t *p2) = 0;
  virtual void     PaintPolyLine(Int_t n, Float_t *x, Float_t *y, Option_t *option="") = 0;
  virtual void     PaintPolyLine(Int_t n, Double_t *x, Double_t *y, Option_t *option="") = 0;
  virtual void     PaintPolyLine3D(Int_t n, Double_t *p) = 0;
  virtual void     PaintPolyLineNDC(Int_t n, Double_t *x, Double_t *y, Option_t *option="") = 0;
  virtual void     PaintPolyMarker(Int_t n, Float_t *x, Float_t *y, Option_t *option="") = 0;
  virtual void     PaintPolyMarker(Int_t n, Double_t *x, Double_t *y, Option_t *option="") = 0;
  virtual void     PaintModified() = 0;
  virtual void     PaintText(Double_t x, Double_t y, const char *text) = 0;
  virtual void     PaintText(Double_t x, Double_t y, const wchar_t *text) = 0;
  virtual void     PaintTextNDC(Double_t u, Double_t v, const char *text) = 0;
  virtual void     PaintTextNDC(Double_t u, Double_t v, const wchar_t *text) = 0;
  virtual Double_t PixeltoX(Int_t px) = 0;
  virtual Double_t PixeltoY(Int_t py) = 0;
  virtual void     Pop() = 0;
  virtual void     Print(const char *filename="") const = 0;
  virtual void     Print(const char *filename, Option_t *option) = 0;
  virtual void     Range(Double_t x1, Double_t y1, Double_t x2, Double_t y2) = 0;
  virtual void     RangeAxis(Double_t xmin, Double_t ymin, Double_t xmax, Double_t ymax) = 0;
  virtual void     RecursiveRemove(TObject *obj) = 0;
  virtual void     RedrawAxis(Option_t *option="") = 0;
  virtual void     ResetView3D(TObject *view=0) = 0;
  virtual void     ResizePad(Option_t *option="") = 0;
  virtual void     SaveAs(const char *filename="",Option_t *option="") const = 0;
  virtual void     SetBatch(Bool_t batch=kTRUE) = 0;
  virtual void     SetBorderMode(Short_t bordermode) = 0;
  virtual void     SetBorderSize(Short_t bordersize) = 0;
  virtual void     SetCanvas(TCanvas *c) = 0;
  virtual void     SetCanvasSize(UInt_t ww, UInt_t wh) = 0;
  virtual void     SetCrosshair(Int_t crhair=1) = 0;
  virtual void     SetCursor(ECursor cursor) = 0;
  virtual void     SetDoubleBuffer(Int_t mode=1) = 0;
  virtual void     SetEditable(Bool_t mode=kTRUE) = 0;
  virtual void     SetFixedAspectRatio(Bool_t fixed = kTRUE) = 0;
  virtual void     SetGrid(Int_t valuex = 1, Int_t valuey = 1) = 0;
  virtual void     SetGridx(Int_t value = 1) = 0;
  virtual void     SetGridy(Int_t value = 1) = 0;
  virtual void     SetLogx(Int_t value = 1) = 0;
  virtual void     SetLogy(Int_t value = 1) = 0;
  virtual void     SetLogz(Int_t value = 1) = 0;
  virtual void     SetPad(const char *name, const char *title,
                          Double_t xlow, Double_t ylow, Double_t xup,
                          Double_t yup, Color_t color=35,
                          Short_t bordersize=5, Short_t bordermode=-1) = 0;
  virtual void     SetPad(Double_t xlow, Double_t ylow, Double_t xup, Double_t yup) = 0;
  virtual void     SetAttFillPS(Color_t color, Style_t style) = 0;
  virtual void     SetAttLinePS(Color_t color, Style_t style, Width_t lwidth) = 0;
  virtual void     SetAttMarkerPS(Color_t color, Style_t style, Size_t msize) = 0;
  virtual void     SetAttTextPS(Int_t align, Float_t angle, Color_t color, Style_t font, Float_t tsize) = 0;
  virtual void     SetName(const char *name) = 0;
  virtual void     SetSelected(TObject *obj) = 0;
  virtual void     SetTicks(Int_t valuex = 1, Int_t valuey = 1) = 0;
  virtual void     SetTickx(Int_t value = 1) = 0;
  virtual void     SetTicky(Int_t value = 1) = 0;
  virtual void     SetTitle(const char *title="") = 0;
  virtual void     SetTheta(Double_t theta=30) = 0;
  virtual void     SetPhi(Double_t phi=30) = 0;
  virtual void     SetToolTipText(const char *text, Long_t delayms = 1000) = 0;
  virtual void     SetVertical(Bool_t vert=kTRUE) = 0;
  virtual void     SetView(TView *view=0) = 0;
  virtual void     SetViewer3D(TVirtualViewer3D * /*viewer3d*/) {}
  virtual void     ShowGuidelines(TObject *object, const Int_t event, const char mode = 'i', const bool cling = true) = 0;
  virtual TObject *WaitPrimitive(const char *pname="", const char *emode="") = 0;
  virtual void     Update() = 0;
  virtual Int_t    UtoAbsPixel(Double_t u) const = 0;
  virtual Int_t    VtoAbsPixel(Double_t v) const = 0;
  virtual Int_t    UtoPixel(Double_t u) const = 0;
  virtual Int_t    VtoPixel(Double_t v) const = 0;
  virtual Int_t    XtoAbsPixel(Double_t x) const = 0;
  virtual Int_t    YtoAbsPixel(Double_t y) const = 0;
  virtual Double_t XtoPad(Double_t x) const = 0;
  virtual Double_t YtoPad(Double_t y) const = 0;
  virtual Int_t    XtoPixel(Double_t x) const = 0;
  virtual Int_t    YtoPixel(Double_t y) const = 0;

  virtual TObject *CreateToolTip(const TBox *b, const char *text, Long_t delayms) = 0;
  virtual void     DeleteToolTip(TObject *tip) = 0;
  virtual void     ResetToolTip(TObject *tip) = 0;
  virtual void     CloseToolTip(TObject *tip) = 0;

  virtual TVirtualViewer3D *GetViewer3D(Option_t * type = "") = 0;
  virtual Bool_t            HasViewer3D() const = 0;
  virtual void              ReleaseViewer3D(Option_t * type = "")  = 0;

  virtual Int_t               GetGLDevice() = 0;
  virtual void                SetCopyGLDevice(Bool_t copy) = 0;
  virtual TVirtualPadPainter *GetPainter() = 0;

  virtual Bool_t PadInSelectionMode() const;
  virtual Bool_t PadInHighlightMode() const;

  virtual void PushTopLevelSelectable(TObject *top);
  virtual void PushSelectableObject(TObject *obj);
  virtual void PopTopLevelSelectable();

  // static TVirtualPad *&Pad();
  %extend {
    static TVirtualPad* Pad()
    {
      TVirtualPad* p = TVirtualPad::Pad();
      return p;
    }
  }
};
%default;


class TPad : public TVirtualPad, public TAttBBox2D {
public:
  TPad();
  TPad(const char *name, const char *title, Double_t xlow,
       Double_t ylow, Double_t xup, Double_t yup,
       Color_t color=-1, Short_t bordersize=-1, Short_t bordermode=-2);
  virtual ~TPad();
  void              AbsCoordinates(Bool_t set) { fAbsCoord = set; }
  Double_t          AbsPixeltoX(Int_t px) {return fAbsPixeltoXk + px*fPixeltoX;}
  Double_t          AbsPixeltoY(Int_t py) {return fAbsPixeltoYk + py*fPixeltoY;}
  virtual void      AbsPixeltoXY(Int_t xpixel, Int_t ypixel, Double_t &x, Double_t &y);
  virtual void      AddExec(const char *name, const char *command);
  virtual void      AutoExec();
  virtual void      Browse(TBrowser *b);
  virtual TLegend  *BuildLegend(Double_t x1=0.5, Double_t y1=0.67, Double_t x2=0.88, Double_t y2=0.88, const char *title=""); // *MENU*
  TVirtualPad*      cd(Int_t subpadnumber=0); // *MENU*
  void              Clear(Option_t *option="");
  virtual Int_t     Clip(Float_t *x, Float_t *y, Float_t xclipl, Float_t yclipb, Float_t xclipr, Float_t yclipt);
  virtual Int_t     Clip(Double_t *x, Double_t *y, Double_t xclipl, Double_t yclipb, Double_t xclipr, Double_t yclipt);
  virtual Int_t     ClippingCode(Double_t x, Double_t y, Double_t xcl1, Double_t ycl1, Double_t xcl2, Double_t ycl2);
  virtual Int_t     ClipPolygon(Int_t n, Double_t *x, Double_t *y, Int_t nn, Double_t *xc, Double_t *yc, Double_t xclipl, Double_t yclipb, Double_t xclipr, Double_t yclipt);
  virtual void      Close(Option_t *option="");
  virtual void      Closed() { Emit("Closed()"); } // *SIGNAL*
  virtual void      CopyPixmap();
  virtual void      CopyPixmaps();
  virtual void      DeleteExec(const char *name);
  virtual void      Divide(Int_t nx=1, Int_t ny=1, Float_t xmargin=0.01, Float_t ymargin=0.01, Int_t color=0); // *MENU*
  virtual void      DivideSquare(Int_t n, Float_t xmargin=0.01, Float_t ymargin=0.01, Int_t color=0);
  virtual void      Draw(Option_t *option="");
  virtual void      DrawClassObject(const TObject *obj, Option_t *option="");
  static  void      DrawColorTable();
  virtual void      DrawCrosshair();
  TH1F             *DrawFrame(Double_t xmin, Double_t ymin, Double_t xmax, Double_t ymax, const char *title="");
  virtual void      ExecuteEventAxis(Int_t event, Int_t px, Int_t py, TAxis *axis);
  virtual TObject  *FindObject(const char *name) const;
  virtual TObject  *FindObject(const TObject *obj) const;
  virtual void      UseCurrentStyle();  // *MENU*
  virtual Short_t   GetBorderMode() const { return fBorderMode;}
  virtual Short_t   GetBorderSize() const { return fBorderSize;}
  Int_t             GetCrosshair() const;
  virtual Int_t     GetCanvasID() const;
  virtual TCanvasImp *GetCanvasImp() const;
  TFrame           *GetFrame();
  virtual Int_t     GetEvent() const;
  virtual Int_t     GetEventX() const;
  virtual Int_t     GetEventY() const;
  virtual Color_t   GetHighLightColor() const;
  virtual void      GetRange(Double_t &x1, Double_t &y1, Double_t &x2, Double_t &y2);
  virtual void      GetRangeAxis(Double_t &xmin, Double_t &ymin, Double_t &xmax, Double_t &ymax);
  virtual void      GetPadPar(Double_t &xlow, Double_t &ylow, Double_t &xup, Double_t &yup);
  Double_t          GetXlowNDC() const {return fXlowNDC;}
  Double_t          GetYlowNDC() const {return fYlowNDC;}
  Double_t          GetWNDC() const {return fWNDC;}
  Double_t          GetHNDC() const {return fHNDC;}
  virtual UInt_t    GetWw() const;
  virtual UInt_t    GetWh() const;
  Double_t          GetAbsXlowNDC() const {return fAbsXlowNDC;}
  Double_t          GetAbsYlowNDC() const {return fAbsYlowNDC;}
  Double_t          GetAbsWNDC() const {return fAbsWNDC;}
  Double_t          GetAbsHNDC() const {return fAbsHNDC;}
  Double_t          GetAspectRatio() const { return fAspectRatio; }
  Double_t          GetPhi() const   {return fPhi;}
  Double_t          GetTheta() const {return fTheta;}
  Double_t          GetUxmin() const {return fUxmin;}
  Double_t          GetUymin() const {return fUymin;}
  Double_t          GetUxmax() const {return fUxmax;}
  Double_t          GetUymax() const {return fUymax;}
  Bool_t            GetGridx() const {return fGridx;}
  Bool_t            GetGridy() const {return fGridy;}
  Int_t             GetNumber() const {return fNumber;}
  Int_t             GetTickx() const {return fTickx;}
  Int_t             GetTicky() const {return fTicky;}
  Double_t          GetX1() const { return fX1; }
  Double_t          GetX2() const { return fX2; }
  Double_t          GetY1() const { return fY1; }
  Double_t          GetY2() const { return fY2; }
  static Int_t      GetMaxPickDistance();
  TList            *GetListOfPrimitives() const {return fPrimitives;}
  TList            *GetListOfExecs() const {return fExecs;}
  virtual TObject  *GetPrimitive(const char *name) const;  //obsolete, use FindObject instead
  virtual TObject  *GetSelected() const;
  virtual TVirtualPad  *GetPad(Int_t subpadnumber) const;
  virtual TObject  *GetPadPointer() const {return fPadPointer;}
  TVirtualPad      *GetPadSave() const;
  TVirtualPad      *GetSelectedPad() const;
  Int_t             GetGLDevice();
  TView            *GetView() const {return fView;}
  TObject          *GetView3D() const {return fPadView3D;}// Return 3D View of this TPad
  Int_t             GetLogx() const {return fLogx;}
  Int_t             GetLogy() const {return fLogy;}
  Int_t             GetLogz() const {return fLogz;}
  virtual TVirtualPad *GetMother() const {return fMother;}
  const char       *GetName() const {return fName.Data();}
  const char       *GetTitle() const {return fTitle.Data();}
  virtual TCanvas  *GetCanvas() const { return fCanvas; }
  virtual TVirtualPad *GetVirtCanvas() const ;
  virtual TVirtualPadPainter *GetPainter();
  Int_t             GetPadPaint() const {return fPadPaint;}
  Int_t             GetPixmapID() const {return fPixmapID;}
  ULong_t           Hash() const { return fName.Hash(); }
  virtual Bool_t    HasCrosshair() const;
  void              HighLight(Color_t col=kRed, Bool_t set=kTRUE);
  Bool_t            HasFixedAspectRatio() const { return fFixedAspectRatio; }
  virtual Bool_t    IsBatch() const;
  virtual Bool_t    IsEditable() const {return fEditable;}
  Bool_t            IsFolder() const {return kTRUE;}
  Bool_t            IsModified() const {return fModified;}
  virtual Bool_t    IsRetained() const;
  virtual Bool_t    IsVertical() const {return !TestBit(kHori);}
  virtual void      ls(Option_t *option="") const;
  void              Modified(Bool_t flag=1);  // *SIGNAL*
  virtual Bool_t    OpaqueMoving() const;
  virtual Bool_t    OpaqueResizing() const;
  Double_t          PadtoX(Double_t x) const;
  Double_t          PadtoY(Double_t y) const;
  virtual void      Paint(Option_t *option="");
  void              PaintBox(Double_t x1, Double_t y1, Double_t x2, Double_t y2, Option_t *option="");
  void              PaintFillArea(Int_t n, Float_t *x, Float_t *y, Option_t *option=""); // Obsolete
  void              PaintFillArea(Int_t n, Double_t *x, Double_t *y, Option_t *option="");
  void              PaintFillAreaHatches(Int_t n, Double_t *x, Double_t *y, Int_t FillStyle);
  void              PaintHatches(Double_t dy, Double_t angle, Int_t nn, Double_t *xx, Double_t *yy);
  void              PaintPadFrame(Double_t xmin, Double_t ymin, Double_t xmax, Double_t ymax);
  void              PaintLine(Double_t x1, Double_t y1, Double_t x2, Double_t y2);
  void              PaintLineNDC(Double_t u1, Double_t v1,Double_t u2, Double_t v2);
  void              PaintLine3D(Float_t *p1, Float_t *p2);
  void              PaintLine3D(Double_t *p1, Double_t *p2);
  void              PaintPolyLine(Int_t n, Float_t *x, Float_t *y, Option_t *option="");
  void              PaintPolyLine(Int_t n, Double_t *x, Double_t *y, Option_t *option="");
  void              PaintPolyLine3D(Int_t n, Double_t *p);
  void              PaintPolyLineNDC(Int_t n, Double_t *x, Double_t *y, Option_t *option="");
  void              PaintPolyMarker(Int_t n, Float_t *x, Float_t *y, Option_t *option="");
  void              PaintPolyMarker(Int_t n, Double_t *x, Double_t *y, Option_t *option="");
  virtual void      PaintModified();
  void              PaintText(Double_t x, Double_t y, const char *text);
  void              PaintText(Double_t x, Double_t y, const wchar_t *text);
  void              PaintTextNDC(Double_t u, Double_t v, const char *text);
  void              PaintTextNDC(Double_t u, Double_t v, const wchar_t *text);
  virtual TPad     *Pick(Int_t px, Int_t py, TObjLink *&pickobj);
  Double_t          PixeltoX(Int_t px);
  Double_t          PixeltoY(Int_t py);
  virtual void      PixeltoXY(Int_t xpixel, Int_t ypixel, Double_t &x, Double_t &y);
  virtual void      Pop();  // *MENU*
  virtual void      Print(const char *filename="") const;
  virtual void      Print(const char *filename, Option_t *option);
  virtual void      Range(Double_t x1, Double_t y1, Double_t x2, Double_t y2); // *MENU* *ARGS={x1=>fX1,y1=>fY1,x2=>fX2,y2=>fY2}
  virtual void      RangeChanged() { Emit("RangeChanged()"); } // *SIGNAL*
  virtual void      RangeAxis(Double_t xmin, Double_t ymin, Double_t xmax, Double_t ymax);
  virtual void      RangeAxisChanged() { Emit("RangeAxisChanged()"); } // *SIGNAL*
  virtual void      RecursiveRemove(TObject *obj);
  virtual void      RedrawAxis(Option_t *option="");
  virtual void      ResetView3D(TObject *view=0){fPadView3D=view;}
  virtual void      ResizePad(Option_t *option="");
  virtual void      SaveAs(const char *filename="",Option_t *option="") const; // *MENU*
  virtual void      SetBorderMode(Short_t bordermode) {fBorderMode = bordermode; Modified();} // *MENU*
  virtual void      SetBorderSize(Short_t bordersize) {fBorderSize = bordersize; Modified();} // *MENU*
  void              SetCanvas(TCanvas *c) { fCanvas = c; }
  virtual void      SetCanvasSize(UInt_t ww, UInt_t wh);
  virtual void      SetCrosshair(Int_t crhair=1); // *TOGGLE*
  virtual void      SetCursor(ECursor cursor);
  virtual void      SetDoubleBuffer(Int_t mode=1);
  virtual void      SetDrawOption(Option_t *option="");
  virtual void      SetEditable(Bool_t mode=kTRUE); // *TOGGLE*
  virtual void      SetFixedAspectRatio(Bool_t fixed = kTRUE);  // *TOGGLE*
  virtual void      SetGrid(Int_t valuex = 1, Int_t valuey = 1) {fGridx = valuex; fGridy = valuey; Modified();}
  virtual void      SetGridx(Int_t value = 1) {fGridx = value; Modified();} // *TOGGLE*
  virtual void      SetGridy(Int_t value = 1) {fGridy = value; Modified();} // *TOGGLE*
  virtual void      SetFillStyle(Style_t fstyle);
  virtual void      SetLogx(Int_t value = 1); // *TOGGLE*
  virtual void      SetLogy(Int_t value = 1); // *TOGGLE*
  virtual void      SetLogz(Int_t value = 1); // *TOGGLE*
  virtual void      SetNumber(Int_t number) {fNumber = number;}
  virtual void      SetPad(const char *name, const char *title,
                           Double_t xlow, Double_t ylow, Double_t xup,
                           Double_t yup, Color_t color=35,
                           Short_t bordersize=5, Short_t bordermode=-1);
  virtual void      SetPad(Double_t xlow, Double_t ylow, Double_t xup, Double_t yup);
  virtual void      SetAttFillPS(Color_t color, Style_t style);
  virtual void      SetAttLinePS(Color_t color, Style_t style, Width_t lwidth);
  virtual void      SetAttMarkerPS(Color_t color, Style_t style, Size_t msize);
  virtual void      SetAttTextPS(Int_t align, Float_t angle, Color_t color, Style_t font, Float_t tsize);
  static  void      SetMaxPickDistance(Int_t maxPick=5);
  virtual void      SetName(const char *name) {fName = name;} // *MENU*
  virtual void      SetSelected(TObject *obj);
  virtual void      SetTicks(Int_t valuex = 1, Int_t valuey = 1) {fTickx = valuex; fTicky = valuey; Modified();}
  virtual void      SetTickx(Int_t value = 1) {fTickx = value; Modified();} // *TOGGLE*
  virtual void      SetTicky(Int_t value = 1) {fTicky = value; Modified();} // *TOGGLE*
  virtual void      SetTitle(const char *title="") {fTitle = title;}
  virtual void      SetTheta(Double_t theta=30) {fTheta = theta; Modified();}
  virtual void      SetPhi(Double_t phi=30) {fPhi = phi; Modified();}
  virtual void      SetToolTipText(const char *text, Long_t delayms = 1000);
  virtual void      SetVertical(Bool_t vert=kTRUE);
  virtual void      SetView(TView *view = 0);
  virtual void      SetViewer3D(TVirtualViewer3D *viewer3d) {fViewer3D = viewer3d;}

  virtual void      SetGLDevice(Int_t dev) {fGLDevice = dev;}
  virtual void      SetCopyGLDevice(Bool_t copy) {fCopyGLDevice = copy;}

  virtual void      ShowGuidelines(TObject *object, const Int_t event, const char mode = 'i', const bool cling = true);
  virtual void      Update();
  Int_t             UtoAbsPixel(Double_t u) const {return Int_t(fUtoAbsPixelk + u*fUtoPixel);}
  Int_t             VtoAbsPixel(Double_t v) const {return Int_t(fVtoAbsPixelk + v*fVtoPixel);}
  Int_t             UtoPixel(Double_t u) const;
  Int_t             VtoPixel(Double_t v) const;
  virtual TObject  *WaitPrimitive(const char *pname="", const char *emode="");
  Int_t             XtoAbsPixel(Double_t x) const;
  Int_t             YtoAbsPixel(Double_t y) const;
  Double_t          XtoPad(Double_t x) const;
  Double_t          YtoPad(Double_t y) const;
  Int_t             XtoPixel(Double_t x) const;
  Int_t             YtoPixel(Double_t y) const;
  virtual void      XYtoAbsPixel(Double_t x, Double_t y, Int_t &xpixel, Int_t &ypixel) const;
  virtual void      XYtoPixel(Double_t x, Double_t y, Int_t &xpixel, Int_t &ypixel) const;

  virtual TObject  *CreateToolTip(const TBox *b, const char *text, Long_t delayms);
  virtual void      DeleteToolTip(TObject *tip);
  virtual void      ResetToolTip(TObject *tip);
  virtual void      CloseToolTip(TObject *tip);

  virtual void      x3d(Option_t *type=""); // Depreciated

  virtual TVirtualViewer3D *GetViewer3D(Option_t * type = "");
  virtual Bool_t            HasViewer3D() const { return (fViewer3D); }
  virtual void              ReleaseViewer3D(Option_t * type = "");

  virtual Rectangle_t  GetBBox();
  virtual TPoint       GetBBoxCenter();
  virtual void         SetBBoxCenter(const TPoint &p);
  virtual void         SetBBoxCenterX(const Int_t x);
  virtual void         SetBBoxCenterY(const Int_t y);
  virtual void         SetBBoxX1(const Int_t x);
  virtual void         SetBBoxX2(const Int_t x);
  virtual void         SetBBoxY1(const Int_t y);
  virtual void         SetBBoxY2(const Int_t y);

  virtual void      RecordPave(const TObject *obj);              // *SIGNAL*
  virtual void      RecordLatex(const TObject *obj);             // *SIGNAL*
  virtual void      EventPave() { Emit("EventPave()"); }         // *SIGNAL*
  virtual void      StartEditing() { Emit("StartEditing()"); }   // *SIGNAL*
};


class TCanvas : public TPad {
public:
  TCanvas(Bool_t build=kTRUE);
  TCanvas(const char *name, const char *title="", Int_t form=1);
  TCanvas(const char *name, const char *title, Int_t ww, Int_t wh);
  TCanvas(const char *name, const char *title, Int_t wtopx, Int_t wtopy,
          Int_t ww, Int_t wh);
  TCanvas(const char *name, Int_t ww, Int_t wh, Int_t winid);

  %extend {
    static TCanvas* create(const char *name="c1", const char *title="", Int_t form=1)
    {
      return new TCanvas(name, title, form);
    }

    static TCanvas* create(const char *name, const char *title, Int_t ww, Int_t wh)
    {
      return new TCanvas(name, title, ww, wh);
    }

    static TCanvas* create(const char *name, const char *title, Int_t wtopx, Int_t wtopy, Int_t ww, Int_t wh)
    {
      return new TCanvas(name, title, wtopx, wtopy, ww, wh);
    }
  }

  virtual ~TCanvas();

  //-- used by friend TThread class
  void Constructor();
  void Constructor(const char *name, const char *title, Int_t form);
  void Constructor(const char *name, const char *title, Int_t ww, Int_t wh);
  void Constructor(const char *name, const char *title,
                   Int_t wtopx, Int_t wtopy, Int_t ww, Int_t wh);
  void Destructor();

  TVirtualPad      *cd(Int_t subpadnumber=0);
  virtual void      Browse(TBrowser *b);
  void              Clear(Option_t *option="");
  void              Close(Option_t *option="");
  virtual void      Delete(Option_t * = "") { MayNotUse("Delete()"); }
  void              DisconnectWidget();  // used by TCanvasImp
  virtual void      Draw(Option_t *option="");
  virtual TObject  *DrawClone(Option_t *option="") const; // *MENU*
  virtual TObject  *DrawClonePad(); // *MENU*
  virtual void      EditorBar();
  void              EmbedInto(Int_t winid, Int_t ww, Int_t wh);
  void              EnterLeave(TPad *prevSelPad, TObject *prevSelObj);
  void              FeedbackMode(Bool_t set);
  void              Flush();
  void              UseCurrentStyle(); // *MENU*
  void              ForceUpdate() { fCanvasImp->ForceUpdate(); }
  const char       *GetDISPLAY() const {return fDISPLAY.Data();}
  TContextMenu     *GetContextMenu() const {return fContextMenu;};
  Int_t             GetDoubleBuffer() const {return fDoubleBuffer;}
  Int_t             GetEvent() const { return fEvent; }
  Int_t             GetEventX() const { return fEventX; }
  Int_t             GetEventY() const { return fEventY; }
  Color_t           GetHighLightColor() const { return fHighLightColor; }
  TVirtualPad      *GetPadSave() const { return fPadSave; }
  void              ClearPadSave() { fPadSave = 0; }
  TObject          *GetSelected() const {return fSelected;}
  TObject          *GetClickSelected() const {return fClickSelected;}
  Int_t             GetSelectedX() const {return fSelectedX;}
  Int_t             GetSelectedY() const {return fSelectedY;}
  Option_t         *GetSelectedOpt() const {return fSelectedOpt.Data();}
  TVirtualPad      *GetSelectedPad() const { return fSelectedPad; }
  TVirtualPad      *GetClickSelectedPad() const { return fClickSelectedPad; }
  Bool_t            GetShowEventStatus() const { return TestBit(kShowEventStatus); }
  Bool_t            GetShowToolBar() const { return TestBit(kShowToolBar); }
  Bool_t            GetShowEditor() const { return TestBit(kShowEditor); }
  Bool_t            GetShowToolTips() const { return TestBit(kShowToolTips); }
  Bool_t            GetAutoExec() const { return TestBit(kAutoExec); }
  Size_t            GetXsizeUser() const {return fXsizeUser;}
  Size_t            GetYsizeUser() const {return fYsizeUser;}
  Size_t            GetXsizeReal() const {return fXsizeReal;}
  Size_t            GetYsizeReal() const {return fYsizeReal;}
  Int_t             GetCanvasID() const {return fCanvasID;}
  TCanvasImp       *GetCanvasImp() const {return fCanvasImp;}
  Int_t             GetWindowTopX();
  Int_t             GetWindowTopY();
  UInt_t            GetWindowWidth() const { return fWindowWidth; }
  UInt_t            GetWindowHeight() const { return fWindowHeight; }
  UInt_t            GetWw() const { return fCw; }
  UInt_t            GetWh() const { return fCh; }
  virtual void      GetCanvasPar(Int_t &wtopx, Int_t &wtopy, UInt_t &ww, UInt_t &wh)
  {wtopx=GetWindowTopX(); wtopy=fWindowTopY; ww=fWindowWidth; wh=fWindowHeight;}
  virtual void      HandleInput(EEventType button, Int_t x, Int_t y);
  Bool_t            HasMenuBar() const { return TestBit(kMenuBar); }
  void              Iconify() { fCanvasImp->Iconify(); }
  Bool_t            IsBatch() const { return fBatch; }
  Bool_t            IsDrawn() { return fDrawn; }
  Bool_t            IsFolder() const;
  Bool_t            IsGrayscale();
  Bool_t            IsRetained() const { return fRetained; }
  virtual void      ls(Option_t *option="") const;
  void              MoveOpaque(Int_t set=1);
  Bool_t            OpaqueMoving() const { return TestBit(kMoveOpaque); }
  Bool_t            OpaqueResizing() const { return TestBit(kResizeOpaque); }
  virtual void      Paint(Option_t *option="");
  virtual TPad     *Pick(Int_t px, Int_t py, TObjLink *&pickobj) { return TPad::Pick(px, py, pickobj); }
  virtual TPad     *Pick(Int_t px, Int_t py, TObject *prevSelObj);
  virtual void      Picked(TPad *selpad, TObject *selected, Int_t event);             // *SIGNAL*
  virtual void      ProcessedEvent(Int_t event, Int_t x, Int_t y, TObject *selected); // *SIGNAL*
  virtual void      Selected(TVirtualPad *pad, TObject *obj, Int_t event);            // *SIGNAL*
  virtual void      Cleared(TVirtualPad *pad);                                        // *SIGNAL*
  virtual void      Closed();                                                         // *SIGNAL*
  void              RaiseWindow() { fCanvasImp->RaiseWindow(); }
  void              ResetDrawn() { fDrawn=kFALSE; }
  virtual void      Resize(Option_t *option="");
  void              ResizeOpaque(Int_t set=1);
  void              SaveSource(const char *filename="", Option_t *option="");
  void              SavePrimitive(std::ostream &out, Option_t *option = "");
  virtual void      SetCursor(ECursor cursor);
  virtual void      SetDoubleBuffer(Int_t mode=1);
  virtual void      SetFixedAspectRatio(Bool_t fixed = kTRUE);  // *TOGGLE*
  void              SetGrayscale(Bool_t set = kTRUE); // *TOGGLE* *GETTER=IsGrayscale
  void              SetWindowPosition(Int_t x, Int_t y) { fCanvasImp->SetWindowPosition(x, y); }
  void              SetWindowSize(UInt_t ww, UInt_t wh) { fCanvasImp->SetWindowSize(ww, wh); }
  void              SetCanvasSize(UInt_t ww, UInt_t wh); // *MENU*
  void              SetHighLightColor(Color_t col) { fHighLightColor = col; }
  void              SetSelected(TObject *obj);
  void              SetClickSelected(TObject *obj) { fClickSelected = obj; }
  void              SetSelectedPad(TPad *pad) { fSelectedPad = pad; }
  void              SetClickSelectedPad(TPad *pad) { fClickSelectedPad = pad; }
  void              Show() { fCanvasImp->Show(); }
  virtual void      Size(Float_t xsizeuser=0, Float_t ysizeuser=0);
  void              SetBatch(Bool_t batch=kTRUE);
  static  void      SetFolder(Bool_t isfolder=kTRUE);
  void              SetPadSave(TPad *pad) {fPadSave = pad;}
  void              SetRetained(Bool_t retained=kTRUE) { fRetained=retained;}
  void              SetTitle(const char *title="");
  virtual void      ToggleEventStatus();
  virtual void      ToggleAutoExec();
  virtual void      ToggleToolBar();
  virtual void      ToggleEditor();
  virtual void      ToggleToolTips();
  virtual void      Update();

  Bool_t              UseGL() const { return fUseGL; }
  void                SetSupportGL(Bool_t support) {fUseGL = support;}
  TVirtualPadPainter *GetCanvasPainter();
  void                DeleteCanvasPainter();

  static TCanvas   *MakeDefCanvas();
  static Bool_t     SupportAlpha();
};
