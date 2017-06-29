/**************************************************************************/
/* Pave classes                                                           */
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
