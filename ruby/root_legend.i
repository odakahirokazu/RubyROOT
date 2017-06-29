/**************************************************************************/
/* Legend classes                                                         */
/**************************************************************************/

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
