/**************************************************************************/
/* String classes                                                         */
/**************************************************************************/

class TObjString : public TObject {
public:
   TObjString(const char *s = "") : fString(s) { }
   TObjString(const TObjString &s) : TObject(), fString(s.fString) { }
   ~TObjString() { }
   Int_t       Compare(const TObject *obj) const;
   const char *GetName() const { return fString; }
   ULong_t     Hash() const { return fString.Hash(); }
   void        FillBuffer(char *&buffer) { fString.FillBuffer(buffer); }
   void        Print(Option_t *) const { Printf("TObjString = %s", (const char*)fString); }
   Bool_t      IsSortable() const { return kTRUE; }
   Bool_t      IsEqual(const TObject *obj) const;
   void        ReadBuffer(char *&buffer) { fString.ReadBuffer(buffer); }
   void        SetString(const char *s) { fString = s; }
   TString     GetString() const { return fString; }
   Int_t       Sizeof() const { return fString.Sizeof(); }
   TString    &String() { return fString; }
};


class TString {
public:
  TString(const char* s="");
  const char* Data() const;
};
