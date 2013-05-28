/**************************************************************************/
/* Canvas classes                                                         */
/**************************************************************************/

%nodefault;
class TVirtualPad : public TObject, public TAttLine, public TAttFill, public TAttPad
{
public:
  virtual void     AbsCoordinates(Bool_t set);
  virtual Double_t AbsPixeltoX(Int_t px);
  virtual Double_t AbsPixeltoY(Int_t py);
  virtual void     AddExec(const char *name, const char *command);
  virtual TLegend *BuildLegend(Double_t x1=0.5, Double_t y1=0.67, Double_t x2=0.88, Double_t y2=0.88, const char *title="");
  virtual TVirtualPad* cd(Int_t subpadnumber=0);
  virtual void     Clear(Option_t *option="");
  virtual void     Close(Option_t *option="");
  virtual void     CopyPixmap();
  virtual void     CopyPixmaps();
  virtual void     DeleteExec(const char *name);
  virtual void     Divide(Int_t nx=1, Int_t ny=1, Float_t xmargin=0.01, Float_t ymargin=0.01, Int_t color=0);
  virtual void     Draw(Option_t *option="");
  virtual void     DrawClassObject(const TObject *obj, Option_t *option="");
  virtual TH1F    *DrawFrame(Double_t xmin, Double_t ymin, Double_t xmax, Double_t ymax, const char *title="");
  virtual void     ExecuteEventAxis(Int_t event, Int_t px, Int_t py, TAxis *axis);
  virtual Short_t  GetBorderMode() const;
  virtual Short_t  GetBorderSize() const;
  virtual Int_t    GetCanvasID() const;
  virtual TCanvasImp *GetCanvasImp() const;
  virtual TCanvas  *GetCanvas() const;
  virtual TVirtualPad *GetVirtCanvas() const;
  virtual Int_t    GetEvent() const ;
  virtual Int_t    GetEventX() const;
  virtual Int_t    GetEventY() const;
  virtual TFrame   *GetFrame();
  virtual Color_t  GetHighLightColor() const;
  virtual Int_t    GetNumber() const;
  virtual void     GetRange(Double_t &x1, Double_t &y1, Double_t &x2, Double_t &y2);
  virtual void     GetRangeAxis(Double_t &xmin, Double_t &ymin, Double_t &xmax, Double_t &ymax);
  virtual void     GetPadPar(Double_t &xlow, Double_t &ylow, Double_t &xup, Double_t &yup);
  virtual Double_t GetXlowNDC() const;
  virtual Double_t GetYlowNDC() const;
  virtual Double_t GetWNDC() const;
  virtual Double_t GetHNDC() const;
  virtual UInt_t   GetWw() const;
  virtual UInt_t   GetWh() const;
  virtual Double_t GetAbsXlowNDC() const;
  virtual Double_t GetAbsYlowNDC() const;
  virtual Double_t GetAbsWNDC() const;
  virtual Double_t GetAbsHNDC() const;
  virtual Double_t GetAspectRatio() const;
  virtual Double_t GetPhi() const;
  virtual Double_t GetTheta() const;
  virtual Double_t GetUxmin() const;
  virtual Double_t GetUymin() const;
  virtual Double_t GetUxmax() const;
  virtual Double_t GetUymax() const;
  virtual Bool_t   GetGridx() const;
  virtual Bool_t   GetGridy() const;
  virtual Int_t    GetTickx() const;
  virtual Int_t    GetTicky() const;
  virtual Double_t GetX1() const;
  virtual Double_t GetX2() const;
  virtual Double_t GetY1() const;
  virtual Double_t GetY2() const;
  virtual TList    *GetListOfPrimitives() const;
  virtual TList    *GetListOfExecs() const;
  virtual TObject  *GetPrimitive(const char *name) const;
  virtual TObject  *GetSelected() const;
  virtual TVirtualPad  *GetPad(Int_t subpadnumber) const;
  virtual TObject  *GetPadPointer() const;
  virtual TVirtualPad  *GetPadSave() const;
  virtual TVirtualPad  *GetSelectedPad() const;
  virtual TView    *GetView() const;
  virtual Int_t    GetLogx() const;
  virtual Int_t    GetLogy() const;
  virtual Int_t    GetLogz() const;
  virtual TVirtualPad  *GetMother() const;
  virtual const char *GetName() const;
  virtual const char *GetTitle() const;
  virtual Int_t    GetPadPaint() const;
  virtual Int_t    GetPixmapID() const;
  virtual TObject *GetView3D() const;
  virtual Bool_t   HasCrosshair() const;
  virtual void     HighLight(Color_t col=kRed, Bool_t set=kTRUE);
  virtual Bool_t   HasFixedAspectRatio() const;
  virtual Bool_t   IsBatch() const;
  Bool_t           IsBeingResized() const;
  virtual Bool_t   IsEditable() const;
  virtual Bool_t   IsModified() const;
  virtual Bool_t   IsRetained() const;
  virtual Bool_t   IsVertical() const;
  virtual void     ls(Option_t *option="") const;
  virtual void     Modified(Bool_t flag=1);
  virtual Bool_t   OpaqueMoving() const;
  virtual Bool_t   OpaqueResizing() const;
  virtual Double_t PadtoX(Double_t x) const;
  virtual Double_t PadtoY(Double_t y) const;
  virtual void     Paint(Option_t *option="");
  virtual void     PaintBorderPS(Double_t xl,Double_t yl,Double_t xt,Double_t yt,Int_t bmode,Int_t bsize,Int_t dark,Int_t light);
  virtual void     PaintBox(Double_t x1, Double_t y1, Double_t x2, Double_t y2, Option_t *option="");
  virtual void     PaintFillArea(Int_t n, Float_t *x, Float_t *y, Option_t *option="");
  virtual void     PaintFillArea(Int_t n, Double_t *x, Double_t *y, Option_t *option="");
  virtual void     PaintPadFrame(Double_t xmin, Double_t ymin, Double_t xmax, Double_t ymax);
  virtual void     PaintLine(Double_t x1, Double_t y1, Double_t x2, Double_t y2);
  virtual void     PaintLineNDC(Double_t u1, Double_t v1,Double_t u2, Double_t v2);
  virtual void     PaintLine3D(Float_t *p1, Float_t *p2);
  virtual void     PaintLine3D(Double_t *p1, Double_t *p2);
  virtual void     PaintPolyLine(Int_t n, Float_t *x, Float_t *y, Option_t *option="");
  virtual void     PaintPolyLine(Int_t n, Double_t *x, Double_t *y, Option_t *option="");
  virtual void     PaintPolyLine3D(Int_t n, Double_t *p);
  virtual void     PaintPolyLineNDC(Int_t n, Double_t *x, Double_t *y, Option_t *option="");
  virtual void     PaintPolyMarker(Int_t n, Float_t *x, Float_t *y, Option_t *option="");
  virtual void     PaintPolyMarker(Int_t n, Double_t *x, Double_t *y, Option_t *option="");
  virtual void     PaintModified();
  virtual void     PaintText(Double_t x, Double_t y, const char *text);
  virtual void     PaintTextNDC(Double_t u, Double_t v, const char *text);
  virtual Double_t PixeltoX(Int_t px);
  virtual Double_t PixeltoY(Int_t py);
  virtual void     Pop();
  virtual void     Print(const char *filename="") const;
  virtual void     Print(const char *filename, Option_t *option);
  virtual void     Range(Double_t x1, Double_t y1, Double_t x2, Double_t y2);
  virtual void     RangeAxis(Double_t xmin, Double_t ymin, Double_t xmax, Double_t ymax);
  virtual void     RecursiveRemove(TObject *obj);
  virtual void     RedrawAxis(Option_t *option="");
  virtual void     ResetView3D(TObject *view=0);
  virtual void     ResizePad(Option_t *option="");
  virtual void     SaveAs(const char *filename="",Option_t *option="") const;
  virtual void     SetBatch(Bool_t batch=kTRUE);
  virtual void     SetBorderMode(Short_t bordermode);
  virtual void     SetBorderSize(Short_t bordersize);
  virtual void     SetCanvas(TCanvas *c);
  virtual void     SetCanvasSize(UInt_t ww, UInt_t wh);
  virtual void     SetCrosshair(Int_t crhair=1);
  virtual void     SetCursor(ECursor cursor);
  virtual void     SetDoubleBuffer(Int_t mode=1);
  virtual void     SetEditable(Bool_t mode=kTRUE);
  virtual void     SetFixedAspectRatio(Bool_t fixed = kTRUE);
  virtual void     SetGrid(Int_t valuex = 1, Int_t valuey = 1);
  virtual void     SetGridx(Int_t value = 1);
  virtual void     SetGridy(Int_t value = 1);
  virtual void     SetLogx(Int_t value = 1);
  virtual void     SetLogy(Int_t value = 1);
  virtual void     SetLogz(Int_t value = 1);
  virtual void     SetPad(const char *name, const char *title,
                          Double_t xlow, Double_t ylow, Double_t xup,
                          Double_t yup, Color_t color=35,
                          Short_t bordersize=5, Short_t bordermode=-1);
  virtual void     SetPad(Double_t xlow, Double_t ylow, Double_t xup, Double_t yup);
  virtual void     SetAttFillPS(Color_t color, Style_t style);
  virtual void     SetAttLinePS(Color_t color, Style_t style, Width_t lwidth);
  virtual void     SetAttMarkerPS(Color_t color, Style_t style, Size_t msize);
  virtual void     SetAttTextPS(Int_t align, Float_t angle, Color_t color, Style_t font, Float_t tsize);
  virtual void     SetName(const char *name);
  virtual void     SetSelected(TObject *obj);
  virtual void     SetTicks(Int_t valuex = 1, Int_t valuey = 1);
  virtual void     SetTickx(Int_t value = 1);
  virtual void     SetTicky(Int_t value = 1);
  virtual void     SetTitle(const char *title="");
  virtual void     SetTheta(Double_t theta=30);
  virtual void     SetPhi(Double_t phi=30);
  virtual void     SetToolTipText(const char *text, Long_t delayms = 1000);
  virtual void     SetVertical(Bool_t vert=kTRUE);
  virtual void     SetView(TView *view=0);
  virtual void     SetViewer3D(TVirtualViewer3D * /*viewer3d*/);
  virtual TObject *WaitPrimitive(const char *pname="", const char *emode="");
  virtual void     Update();
  virtual Int_t    UtoAbsPixel(Double_t u) const;
  virtual Int_t    VtoAbsPixel(Double_t v) const;
  virtual Int_t    UtoPixel(Double_t u) const;
  virtual Int_t    VtoPixel(Double_t v) const;
  virtual Int_t    XtoAbsPixel(Double_t x) const;
  virtual Int_t    YtoAbsPixel(Double_t y) const;
  virtual Double_t XtoPad(Double_t x) const;
  virtual Double_t YtoPad(Double_t y) const;
  virtual Int_t    XtoPixel(Double_t x) const;
  virtual Int_t    YtoPixel(Double_t y) const;

  virtual TObject *CreateToolTip(const TBox *b, const char *text, Long_t delayms);
  virtual void     DeleteToolTip(TObject *tip);
  virtual void     ResetToolTip(TObject *tip);
  virtual void     CloseToolTip(TObject *tip);

  virtual TVirtualViewer3D *GetViewer3D(Option_t * type = "");
  virtual Bool_t            HasViewer3D() const;
  virtual void              ReleaseViewer3D(Option_t * type = "") ;

  virtual Int_t    GetGLDevice();
  virtual void     SetCopyGLDevice(Bool_t copy);
   
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


class TPad : public TVirtualPad
{
public:
  TPad();
  TPad(const char *name, const char *title, Double_t xlow,
       Double_t ylow, Double_t xup, Double_t yup,
       Color_t color=-1, Short_t bordersize=-1, Short_t bordermode=-2);
  virtual ~TPad();
  virtual void      AbsPixeltoXY(Int_t xpixel, Int_t ypixel, Double_t &x, Double_t &y);
  virtual void      AutoExec();
  virtual void      Browse(TBrowser *b);
  virtual Int_t     Clip(Float_t *x, Float_t *y, Float_t xclipl, Float_t yclipb, Float_t xclipr, Float_t yclipt);
  virtual Int_t     Clip(Double_t *x, Double_t *y, Double_t xclipl, Double_t yclipb, Double_t xclipr, Double_t yclipt);
  virtual Int_t     ClippingCode(Double_t x, Double_t y, Double_t xcl1, Double_t ycl1, Double_t xcl2, Double_t ycl2);
  virtual Int_t     ClipPolygon(Int_t n, Double_t *x, Double_t *y, Int_t nn, Double_t *xc, Double_t *yc, Double_t xclipl, Double_t yclipb, Double_t xclipr, Double_t yclipt);
  virtual void      Closed();
  virtual void      DivideSquare(Int_t n, Float_t xmargin=0.01, Float_t ymargin=0.01, Int_t color=0);
  static  void      DrawColorTable();
  virtual void      DrawCrosshair();
  virtual TObject  *FindObject(const char *name) const;
  virtual TObject  *FindObject(const TObject *obj) const;
  virtual void      UseCurrentStyle();  // *MENU*
  Int_t             GetCrosshair() const;
  virtual Int_t     GetEvent() const;
  virtual Int_t     GetEventX() const;
  virtual Int_t     GetEventY() const;
  static Int_t      GetMaxPickDistance();
  Int_t             GetGLDevice();
  TObject          *GetView3D() const;
  virtual TCanvas  *GetCanvas() const;
  virtual TVirtualPad *GetVirtCanvas() const ;
  virtual TVirtualPadPainter *GetPainter();
  ULong_t           Hash() const;;
  Bool_t            IsFolder() const;
  void              PaintFillAreaHatches(Int_t n, Double_t *x, Double_t *y, Int_t FillStyle);
  void              PaintHatches(Double_t dy, Double_t angle, Int_t nn, Double_t *xx, Double_t *yy);
  virtual TPad     *Pick(Int_t px, Int_t py, TObjLink *&pickobj);
  virtual void      PixeltoXY(Int_t xpixel, Int_t ypixel, Double_t &x, Double_t &y);
  virtual void      Pop();  // *MENU*
  virtual void      RangeChanged();
  virtual void      RangeAxisChanged();
  virtual void      SetFillStyle(Style_t fstyle);
  virtual void      SetNumber(Int_t number);
  static  void      SetMaxPickDistance(Int_t maxPick=5);
  //
  virtual void      SetGLDevice(Int_t dev);
  virtual void      SetCopyGLDevice(Bool_t copy);
  //
  virtual TObject  *WaitPrimitive(const char *pname="", const char *emode="");
  virtual void      XYtoAbsPixel(Double_t x, Double_t y, Int_t &xpixel, Int_t &ypixel) const;
  virtual void      XYtoPixel(Double_t x, Double_t y, Int_t &xpixel, Int_t &ypixel) const;

  virtual void      x3d(Option_t *type=""); // Depreciated

  virtual void      RecordPave(const TObject *obj);              // *SIGNAL*
  virtual void      RecordLatex(const TObject *obj);             // *SIGNAL*
  virtual void      EventPave();
  virtual void      StartEditing();
};


class TCanvas : public TPad
{
public:
  TCanvas(Bool_t build=kTRUE);
  TCanvas(const char *name, const char *title="", Int_t form=1);
  TCanvas(const char *name, const char *title, Int_t ww, Int_t wh);
  TCanvas(const char *name, const char *title, Int_t wtopx, Int_t wtopy, Int_t ww, Int_t wh);
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
  virtual void      Delete(Option_t * = "");
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
  void              ForceUpdate();
  const char       *GetDISPLAY() const;
  TContextMenu     *GetContextMenu() const;
  Int_t             GetDoubleBuffer() const;
  Int_t             GetEvent() const;
  Int_t             GetEventX() const;
  Int_t             GetEventY() const;
  Color_t           GetHighLightColor() const;
  TVirtualPad      *GetPadSave() const;
  void              ClearPadSave();
  TObject          *GetSelected() const;
  TObject          *GetClickSelected() const;
  Int_t             GetSelectedX() const;
  Int_t             GetSelectedY() const;
  Option_t         *GetSelectedOpt() const;
  TVirtualPad      *GetSelectedPad() const;
  TVirtualPad      *GetClickSelectedPad() const;
  Bool_t            GetShowEventStatus() const;
  Bool_t            GetShowToolBar() const;
  Bool_t            GetShowEditor() const;
  Bool_t            GetShowToolTips() const;
  Bool_t            GetAutoExec() const;
  Size_t            GetXsizeUser() const;
  Size_t            GetYsizeUser() const;
  Size_t            GetXsizeReal() const;
  Size_t            GetYsizeReal() const;
  Int_t             GetCanvasID() const;
  TCanvasImp       *GetCanvasImp() const;
  Int_t             GetWindowTopX();
  Int_t             GetWindowTopY();
  UInt_t            GetWindowWidth() const;
  UInt_t            GetWindowHeight() const;
  UInt_t            GetWw() const;
  UInt_t            GetWh() const;
  virtual void      GetCanvasPar(Int_t &wtopx, Int_t &wtopy, UInt_t &ww, UInt_t &wh);
  
  virtual void      HandleInput(EEventType button, Int_t x, Int_t y);
  Bool_t            HasMenuBar() const;
  void              Iconify();
  Bool_t            IsBatch() const;
  Bool_t            IsFolder() const;
  Bool_t            IsGrayscale();
  Bool_t            IsRetained() const;
  virtual void      ls(Option_t *option="") const;
  void              MoveOpaque(Int_t set=1);
  Bool_t            OpaqueMoving() const;
  Bool_t            OpaqueResizing() const;
  virtual void      Paint(Option_t *option="");
  virtual TPad     *Pick(Int_t px, Int_t py, TObjLink *&pickobj);
  virtual TPad     *Pick(Int_t px, Int_t py, TObject *prevSelObj);
  virtual void      Picked(TPad *selpad, TObject *selected, Int_t event);             // *SIGNAL*
  virtual void      ProcessedEvent(Int_t event, Int_t x, Int_t y, TObject *selected); // *SIGNAL*
  virtual void      Selected(TVirtualPad *pad, TObject *obj, Int_t event);            // *SIGNAL*
  virtual void      Cleared(TVirtualPad *pad);                                        // *SIGNAL*
  virtual void      Closed();                                                         // *SIGNAL*
  void              RaiseWindow();
  virtual void      Resize(Option_t *option="");
  void              ResizeOpaque(Int_t set=1);
  void              SaveSource(const char *filename="", Option_t *option="");
  void              SavePrimitive(ostream &out, Option_t *option = "");
  virtual void      SetCursor(ECursor cursor);
  virtual void      SetDoubleBuffer(Int_t mode=1);
  virtual void      SetFixedAspectRatio(Bool_t fixed = kTRUE);  // *TOGGLE*
  void              SetGrayscale(Bool_t set = kTRUE); // *TOGGLE* *GETTER=IsGrayscale
  void              SetWindowPosition(Int_t x, Int_t y);
  void              SetWindowSize(UInt_t ww, UInt_t wh);
  void              SetCanvasSize(UInt_t ww, UInt_t wh); // *MENU*
  void              SetHighLightColor(Color_t col);
  void              SetSelected(TObject *obj);
  void              SetClickSelected(TObject *obj);
  void              SetSelectedPad(TPad *pad);
  void              SetClickSelectedPad(TPad *pad);
  void              Show();
  virtual void      Size(Float_t xsizeuser=0, Float_t ysizeuser=0);
  void              SetBatch(Bool_t batch=kTRUE);
  static  void      SetFolder(Bool_t isfolder=kTRUE);
  void              SetPadSave(TPad *pad);
  void              SetRetained(Bool_t retained=kTRUE);
  void              SetTitle(const char *title="");
  virtual void      ToggleEventStatus();
  virtual void      ToggleAutoExec();
  virtual void      ToggleToolBar();
  virtual void      ToggleEditor();
  virtual void      ToggleToolTips();
  virtual void      Update();
  //Still need this.
  Bool_t            UseGL() const;
  void              SetSupportGL(Bool_t support);
   
  //Name is GetPainter, not GetPadPainter
  //to avoid name hiding and confusion.
  //GetPadPainter and GetPainter are non-virtual (no need, in fact).
  TVirtualPadPainter *GetCanvasPainter();
   
  static TCanvas   *MakeDefCanvas();
};
