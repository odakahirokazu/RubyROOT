/**************************************************************************/
/* Legend classes                                                         */
/**************************************************************************/

class TPave : public TBox {
public:
  TPave();
  TPave(Double_t x1, Double_t y1,Double_t x2 ,Double_t y2,
        Int_t bordersize=4 ,Option_t *option="br");
  TPave(const TPave &pave);
  virtual ~TPave();
  void  Copy(TObject &pave) const;
  virtual void  ConvertNDCtoPad();
  virtual Int_t DistancetoPrimitive(Int_t px, Int_t py);
  virtual void  Draw(Option_t *option="");
  virtual void  DrawPave(Double_t x1, Double_t y1,Double_t x2 ,Double_t y2,
                         Int_t bordersize=4 ,Option_t *option="br");
  virtual void  ExecuteEvent(Int_t event, Int_t px, Int_t py);
  Int_t       GetBorderSize() const;
  Double_t    GetCornerRadius() const;
  Option_t   *GetName() const;
  Option_t   *GetOption() const;
  Int_t       GetShadowColor() const;
  Double_t    GetX1NDC() const;
  Double_t    GetX2NDC() const;
  Double_t    GetY1NDC() const;
  Double_t    GetY2NDC() const;
  virtual ULong_t  Hash() const;
  virtual Bool_t   IsSortable() const;
  virtual void  ls(Option_t *option="") const;
  virtual void  Paint(Option_t *option="");
  virtual void  PaintPave(Double_t x1, Double_t y1,Double_t x2 ,Double_t y2,
                          Int_t bordersize=4 ,Option_t *option="br");
  virtual void  PaintPaveArc(Double_t x1, Double_t y1,Double_t x2 ,Double_t y2,
                             Int_t bordersize=4 ,Option_t *option="br");
  virtual void  Print(Option_t *option="") const;
  virtual void  SavePrimitive(std::ostream &out, Option_t *option = "");
  virtual void  SetBorderSize(Int_t bordersize=4);
  virtual void  SetCornerRadius(Double_t rad = 0.2);
  virtual void  SetName(const char *name="");
  virtual void  SetOption(Option_t *option="br");
  virtual void  SetShadowColor(Int_t color);
  virtual void  SetX1NDC(Double_t x1);
  virtual void  SetX2NDC(Double_t x2);
  virtual void  SetY1NDC(Double_t y1);
  virtual void  SetY2NDC(Double_t y2);
  virtual void  SetX1(Double_t x1);
  virtual void  SetX2(Double_t x2);
  virtual void  SetY1(Double_t y1);
  virtual void  SetY2(Double_t y2);
};


class TLegendEntry : public TObject, public TAttText, public TAttLine,
                     public TAttFill, public TAttMarker {
public:
  TLegendEntry();
  TLegendEntry(const TObject *obj, const char *label = 0, Option_t *option="lpf" );
  TLegendEntry( const TLegendEntry &entry );
  virtual ~TLegendEntry();
  virtual void          Copy( TObject &obj ) const;
  virtual const char   *GetLabel() const;
  virtual TObject      *GetObject() const;
  virtual Option_t     *GetOption() const;
  virtual void          Print( Option_t *option = "" ) const;
  virtual void          SaveEntry( std::ostream &out, const char *name );
  virtual void          SetLabel( const char *label = "" );
  virtual void          SetObject(TObject* obj );
  virtual void          SetObject( const char *objectName );  // *MENU*
  virtual void          SetOption( Option_t *option="lpf" );
};


class TLegend : public TPave , public TAttText {
public:
  TLegend();
  TLegend( Double_t x1, Double_t y1, Double_t x2, Double_t y2,
           const char* header = "", Option_t* option="brNDC" );
  virtual ~TLegend();
  TLegend( const TLegend &legend );

  TLegendEntry   *AddEntry(const TObject* obj, const char* label = "", Option_t* option = "lpf" );
  TLegendEntry   *AddEntry(const char *name, const char* label = "", Option_t* option = "lpf" );
  virtual void    Clear( Option_t* option = "" ); // *MENU*
  virtual void    Copy( TObject &obj ) const;
  virtual void    DeleteEntry(); // *MENU*
  virtual void    Draw( Option_t* option = "" );
  virtual void    EditEntryAttFill();
  virtual void    EditEntryAttLine();
  virtual void    EditEntryAttMarker();
  virtual void    EditEntryAttText();
  Float_t         GetColumnSeparation() const;
  TLegendEntry   *GetEntry() const;
  Float_t         GetEntrySeparation() const;
  virtual const char *GetHeader() const;
  TList          *GetListOfPrimitives() const;
  Float_t         GetMargin() const;
  Int_t           GetNColumns() const;
  Int_t           GetNRows() const;
  virtual void    InsertEntry( const char* objectName = "",const char* label = "",
                               Option_t* option = "lpf" ); // *MENU*
  virtual void    Paint( Option_t* option = "" );
  virtual void    PaintPrimitives();
  virtual void    Print( Option_t* option = "" ) const;
  virtual void    RecursiveRemove(TObject *obj);
  virtual void    SavePrimitive(std::ostream &out, Option_t *option  = "");
  void            SetDefaults();
  void            SetColumnSeparation( Float_t columnSeparation );
  virtual void    SetEntryLabel( const char* label ); // *MENU*
  virtual void    SetEntryOption( Option_t* option ); // *MENU*
  void            SetEntrySeparation( Float_t entryseparation );
  virtual void    SetHeader( const char *header = "" );  // *MENU*
  void            SetMargin( Float_t margin );
  void            SetNColumns( Int_t nColumns ); // *MENU*
};
