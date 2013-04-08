/**************************************************************************/
/* List classes                                                           */
/**************************************************************************/

%nodefault;
class TCollection : public TObject
{
public:
  virtual            ~TCollection();
  virtual void       Add(TObject *obj);
  void               AddVector(TObject *obj1, ...);
  virtual void       AddAll(const TCollection *col);
  Bool_t             AssertClass(TClass *cl) const;
  void               Browse(TBrowser *b);
  Int_t              Capacity() const ;
  virtual void       Clear(Option_t *option="");
  virtual TObject   *Clone(const char *newname="") const;
  Int_t              Compare(const TObject *obj) const;
  Bool_t             Contains(const char *name) const ;
  Bool_t             Contains(const TObject *obj) const ;
  virtual void       Delete(Option_t *option="");
  virtual void       Draw(Option_t *option="");
  virtual void       Dump() const ;
  virtual TObject   *FindObject(const char *name) const;
  TObject           *operator()(const char *name) const;
  virtual TObject   *FindObject(const TObject *obj) const;
  virtual Int_t      GetEntries() const ;
  virtual const char *GetName() const;
  virtual TObject  **GetObjectRef(const TObject *obj) const;
  virtual Int_t      GetSize() const ;
  virtual Int_t      GrowBy(Int_t delta) const;
  ULong_t            Hash() const ;
  Bool_t             IsArgNull(const char *where, const TObject *obj) const;
  virtual Bool_t     IsEmpty() const ;
  virtual Bool_t     IsFolder() const ;
  Bool_t             IsOwner() const ;
  Bool_t             IsSortable() const ;
  virtual void       ls(Option_t *option="") const ;
  virtual TIterator *MakeIterator(Bool_t dir = kIterForward) const;
  virtual TIterator *MakeReverseIterator() const ;
  virtual void       Paint(Option_t *option="");
  virtual void       Print(Option_t *option="") const;
  virtual void       Print(Option_t *option, Int_t recurse) const;
  virtual void       Print(Option_t *option, const char* wildcard, Int_t recurse=1) const;
  virtual void       Print(Option_t *option, TPRegexp& regexp, Int_t recurse=1) const;
  virtual void       RecursiveRemove(TObject *obj);
  virtual TObject   *Remove(TObject *obj);
  virtual void       RemoveAll(TCollection *col);
  void               RemoveAll() ;
  void               SetCurrentCollection();
  void               SetName(const char *name) ;
  virtual void       SetOwner(Bool_t enable = kTRUE);
  virtual Int_t      Write(const char *name=0, Int_t option=0, Int_t bufsize=0);
  virtual Int_t      Write(const char *name=0, Int_t option=0, Int_t bufsize=0) const;

  static TCollection  *GetCurrentCollection();
  static void          StartGarbageCollection();
  static void          GarbageCollect(TObject *obj);
  static void          EmptyGarbageCollection();
};


class TSeqCollection : public TCollection
{
public:
  virtual           ~TSeqCollection() ;
  virtual void      Add(TObject *obj) ;
  virtual void      AddFirst(TObject *obj);
  virtual void      AddLast(TObject *obj);
  virtual void      AddAt(TObject *obj, Int_t idx);
  virtual void      AddAfter(const TObject *after, TObject *obj);
  virtual void      AddBefore(const TObject *before, TObject *obj);
  virtual void      RemoveFirst() ;
  virtual void      RemoveLast() ;
  virtual TObject  *RemoveAt(Int_t idx) ;
  virtual void      RemoveAfter(TObject *after) ;
  virtual void      RemoveBefore(TObject *before) ;

  virtual TObject  *At(Int_t idx) const;
  virtual TObject  *Before(const TObject *obj) const;
  virtual TObject  *After(const TObject *obj) const;
  virtual TObject  *First() const;
  virtual TObject  *Last() const;
  Int_t             LastIndex() const ;
  virtual Int_t     GetLast() const;
  virtual Int_t     IndexOf(const TObject *obj) const;
  virtual Bool_t    IsSorted() const ;
  void              UnSort() ;
  Long64_t          Merge(TCollection *list);

  static Int_t       ObjCompare(TObject *a, TObject *b);
  static void        QSort(TObject **a, Int_t first, Int_t last);
  static inline void QSort(TObject **a, TObject **b, Int_t first, Int_t last) ;
  static void        QSort(TObject **a, Int_t nBs, TObject ***b, Int_t first, Int_t last);
};
%default;


class TObjArray : public TSeqCollection
{
public:
  typedef TObjArrayIter Iterator_t;

  TObjArray(Int_t s = TCollection::kInitCapacity, Int_t lowerBound = 0);
  TObjArray(const TObjArray &a);
  virtual          ~TObjArray();
  virtual void     Clear(Option_t *option="");
  virtual void     Compress();
  virtual void     Delete(Option_t *option="");
  virtual void     Expand(Int_t newSize);   // expand or shrink an array
  Int_t            GetEntries() const;
  Int_t            GetEntriesFast() const;
  Int_t            GetLast() const;
  TObject        **GetObjectRef() const ;;
  TObject        **GetObjectRef(const TObject *obj) const;
  Bool_t           IsEmpty() const ;
  TIterator       *MakeIterator(Bool_t dir = kIterForward) const;

  void             Add(TObject *obj) ;
  virtual void     AddFirst(TObject *obj);
  virtual void     AddLast(TObject *obj);
  virtual void     AddAt(TObject *obj, Int_t idx);
  virtual void     AddAtAndExpand(TObject *obj, Int_t idx);
  virtual Int_t    AddAtFree(TObject *obj);
  virtual void     AddAfter(const TObject *after, TObject *obj);
  virtual void     AddBefore(const TObject *before, TObject *obj);
  virtual TObject *FindObject(const char *name) const;
  virtual TObject *FindObject(const TObject *obj) const;
  virtual TObject *RemoveAt(Int_t idx);
  virtual TObject *Remove(TObject *obj);
  virtual void     RemoveRange(Int_t idx1, Int_t idx2);
  virtual void     RecursiveRemove(TObject *obj);

  TObject         *At(Int_t idx) const;
  TObject         *UncheckedAt(Int_t i) const ;
  TObject         *Before(const TObject *obj) const;
  TObject         *After(const TObject *obj) const;
  TObject         *First() const;
  TObject         *Last() const;
  //  virtual TObject *&operator[](Int_t i);
  //  virtual TObject *operator[](Int_t i) const;
  Int_t            LowerBound() const ;
  Int_t            IndexOf(const TObject *obj) const;
  void             SetLast(Int_t last);

  virtual void     Randomize(Int_t ntimes=1);
  virtual void     Sort(Int_t upto = kMaxInt);
  virtual Int_t    BinarySearch(TObject *obj, Int_t upto = kMaxInt); // the TObjArray has to be sorted, -1 == not found !!
};


class TList : public TSeqCollection
{
public:
  typedef TListIter Iterator_t;

  TList() : fFirst(0), fLast(0), fCache(0), fAscending(kTRUE) ;
  TList(TObject *) : fFirst(0), fLast(0), fCache(0), fAscending(kTRUE) ; // for backward compatibility, don't use
  virtual           ~TList();
  virtual void      Clear(Option_t *option="");
  virtual void      Delete(Option_t *option="");
  virtual TObject  *FindObject(const char *name) const;
  virtual TObject  *FindObject(const TObject *obj) const;
  virtual TIterator *MakeIterator(Bool_t dir = kIterForward) const;

  virtual void      Add(TObject *obj) ;
  virtual void      Add(TObject *obj, Option_t *opt) ;
  virtual void      AddFirst(TObject *obj);
  virtual void      AddFirst(TObject *obj, Option_t *opt);
  virtual void      AddLast(TObject *obj);
  virtual void      AddLast(TObject *obj, Option_t *opt);
  virtual void      AddAt(TObject *obj, Int_t idx);
  virtual void      AddAfter(const TObject *after, TObject *obj);
  virtual void      AddAfter(TObjLink *after, TObject *obj);
  virtual void      AddBefore(const TObject *before, TObject *obj);
  virtual void      AddBefore(TObjLink *before, TObject *obj);
  virtual TObject  *Remove(TObject *obj);
  virtual TObject  *Remove(TObjLink *lnk);
  virtual void      RemoveLast();
  virtual void      RecursiveRemove(TObject *obj);

  virtual TObject  *At(Int_t idx) const;
  virtual TObject  *After(const TObject *obj) const;
  virtual TObject  *Before(const TObject *obj) const;
  virtual TObject  *First() const;
  virtual TObjLink *FirstLink() const ;
  virtual TObject **GetObjectRef(const TObject *obj) const;
  virtual TObject  *Last() const;
  virtual TObjLink *LastLink() const ;

  virtual void      Sort(Bool_t order = kSortAscending);
  Bool_t            IsAscending() ;
};
