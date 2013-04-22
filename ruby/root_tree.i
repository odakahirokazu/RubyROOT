/**************************************************************************/
/* Tree classes                                                           */
/**************************************************************************/

class TTree : public TNamed, public TAttLine, public TAttFill, public TAttMarker {
public:
  //  class TClusterIterator;

  TTree();
  TTree(const char* name, const char* title, Int_t splitlevel = 99);

  %extend {
    static TTree* create(const char* name, const char* title, Int_t splitlevel = 99)
    {
      return new TTree(name, title, splitlevel);
    }
  }

  virtual ~TTree();

  virtual void            AddBranchToCache(const char *bname, Bool_t subbranches = kFALSE);
  virtual void            AddBranchToCache(TBranch *branch,   Bool_t subbranches = kFALSE);
  virtual void            DropBranchFromCache(const char *bname, Bool_t subbranches = kFALSE);
  virtual void            DropBranchFromCache(TBranch *branch,   Bool_t subbranches = kFALSE);
  virtual TFriendElement *AddFriend(const char* treename, const char* filename = "");
  virtual TFriendElement *AddFriend(const char* treename, TFile* file);
  virtual TFriendElement *AddFriend(TTree* tree, const char* alias = "", Bool_t warn = kFALSE);
  virtual void            AddTotBytes(Int_t tot) ;
  virtual void            AddZipBytes(Int_t zip) ;
  virtual Long64_t        AutoSave(Option_t* option = "");
  virtual Int_t           Branch(TCollection* list, Int_t bufsize = 32000, Int_t splitlevel = 99, const char* name = "");
  virtual Int_t           Branch(TList* list, Int_t bufsize = 32000, Int_t splitlevel = 99);
  virtual Int_t           Branch(const char* folder, Int_t bufsize = 32000, Int_t splitlevel = 99);
  virtual TBranch        *Branch(const char* name, void* address, const char* leaflist, Int_t bufsize = 32000);
  TBranch        *Branch(const char* name, char* address, const char* leaflist, Int_t bufsize = 32000) ;
  TBranch        *Branch(const char* name, Long_t address, const char* leaflist, Int_t bufsize = 32000) ;
  TBranch        *Branch(const char* name, int address, const char* leaflist, Int_t bufsize = 32000) ;
#if !defined(__CINT__)
  virtual TBranch        *Branch(const char* name, const char* classname, void* addobj, Int_t bufsize = 32000, Int_t splitlevel = 99);
#endif
  template <class T> TBranch *Branch(const char* name, const char* classname, T* obj, Int_t bufsize = 32000, Int_t splitlevel = 99);
  template <class T> TBranch *Branch(const char* name, const char* classname, T** addobj, Int_t bufsize = 32000, Int_t splitlevel = 99);
  template <class T> TBranch *Branch(const char* name, T** addobj, Int_t bufsize = 32000, Int_t splitlevel = 99);
  template <class T> TBranch *Branch(const char* name, T* obj, Int_t bufsize = 32000, Int_t splitlevel = 99);

  virtual TBranch        *Bronch(const char* name, const char* classname, void* addobj, Int_t bufsize = 32000, Int_t splitlevel = 99);
  virtual TBranch        *BranchOld(const char* name, const char* classname, void* addobj, Int_t bufsize = 32000, Int_t splitlevel = 1);
  virtual TBranch        *BranchRef();
  virtual void            Browse(TBrowser*);
  virtual Int_t           BuildIndex(const char* majorname, const char* minorname = "0");
  TStreamerInfo          *BuildStreamerInfo(TClass* cl, void* pointer = 0, Bool_t canOptimize = kTRUE);
  virtual TFile          *ChangeFile(TFile* file);
  virtual TTree          *CloneTree(Long64_t nentries = -1, Option_t* option = "");
  virtual void            CopyAddresses(TTree*,Bool_t undo = kFALSE);
  virtual Long64_t        CopyEntries(TTree* tree, Long64_t nentries = -1, Option_t *option = "");
  virtual TTree          *CopyTree(const char* selection, Option_t* option = "", Long64_t nentries = 1000000000, Long64_t firstentry = 0);
  virtual TBasket        *CreateBasket(TBranch*);
  virtual void            DirectoryAutoAdd(TDirectory *);
  Int_t                   Debug() const ;
  virtual void            Delete(Option_t* option = ""); // *MENU*
  virtual void            Draw(Option_t* opt) ;
  virtual Long64_t        Draw(const char* varexp, const TCut& selection, Option_t* option = "", Long64_t nentries = 1000000000, Long64_t firstentry = 0);
  virtual Long64_t        Draw(const char* varexp, const char* selection, Option_t* option = "", Long64_t nentries = 1000000000, Long64_t firstentry = 0); // *MENU*
  virtual void            DropBaskets();
  virtual void            DropBuffers(Int_t nbytes);
  virtual Int_t           Fill();
  virtual TBranch        *FindBranch(const char* name);
  virtual TLeaf          *FindLeaf(const char* name);
  virtual Int_t           Fit(const char* funcname, const char* varexp, const char* selection = "", Option_t* option = "", Option_t* goption = "", Long64_t nentries = 1000000000, Long64_t firstentry = 0); // *MENU*
  virtual Int_t           FlushBaskets() const;
  virtual const char     *GetAlias(const char* aliasName) const;
  virtual Long64_t        GetAutoFlush() const ;
  virtual Long64_t        GetAutoSave()  const ;
  virtual TBranch        *GetBranch(const char* name);
  virtual TBranchRef     *GetBranchRef() const ;;
  virtual Bool_t          GetBranchStatus(const char* branchname) const;
  static  Int_t           GetBranchStyle();
  virtual Long64_t        GetCacheSize() const ;
  //  virtual TClusterIterator GetClusterIterator(Long64_t firstentry);
  virtual Long64_t        GetChainEntryNumber(Long64_t entry) const ;
  virtual Long64_t        GetChainOffset() const ;
  TFile                  *GetCurrentFile() const;
  Int_t           GetDefaultEntryOffsetLen() const ;
  Long64_t        GetDebugMax()  const ;
  Long64_t        GetDebugMin()  const ;
  TDirectory             *GetDirectory() const ;
  virtual Long64_t        GetEntries() const   ;
  virtual Long64_t        GetEntries(const char *selection);
  virtual Long64_t        GetEntriesFast() const   ;
  virtual Long64_t        GetEntriesFriend() const;
  virtual Long64_t        GetEstimate() const ;
  virtual Int_t           GetEntry(Long64_t entry = 0, Int_t getall = 0);
  Int_t           GetEvent(Long64_t entry = 0, Int_t getall = 0) ;
  virtual Int_t           GetEntryWithIndex(Int_t major, Int_t minor = 0);
  virtual Long64_t        GetEntryNumberWithBestIndex(Int_t major, Int_t minor = 0) const;
  virtual Long64_t        GetEntryNumberWithIndex(Int_t major, Int_t minor = 0) const;
  TEventList             *GetEventList() const ;
  virtual TEntryList     *GetEntryList();
  virtual Long64_t        GetEntryNumber(Long64_t entry) const;
  virtual Int_t           GetFileNumber() const ;
  virtual TTree          *GetFriend(const char*) const;
  virtual const char     *GetFriendAlias(TTree*) const;
  TH1                    *GetHistogram() ;
  virtual Int_t          *GetIndex() ;
  virtual Double_t       *GetIndexValues() ;
  virtual TIterator      *GetIteratorOnAllLeaves(Bool_t dir = kIterForward);
  virtual TLeaf          *GetLeaf(const char* branchname, const char* leafname);
  virtual TLeaf          *GetLeaf(const char* name);
  virtual TList          *GetListOfClones() ;
  virtual TObjArray      *GetListOfBranches() ;
  virtual TObjArray      *GetListOfLeaves() ;
  virtual TList          *GetListOfFriends() const ;
  virtual TList          *GetListOfAliases() const ;

  // GetMakeClass is left non-virtual for efficiency reason.
  // Making it virtual affects the performance of the I/O
  Int_t           GetMakeClass() const ;

  virtual Long64_t        GetMaxEntryLoop() const ;
  virtual Double_t        GetMaximum(const char* columname);
  static  Long64_t        GetMaxTreeSize();
  virtual Long64_t        GetMaxVirtualSize() const ;
  virtual Double_t        GetMinimum(const char* columname);
  virtual Int_t           GetNbranches() ;
  TObject                *GetNotify() const ;
  TVirtualTreePlayer     *GetPlayer();
  virtual Int_t           GetPacketSize() const ;
  virtual Long64_t        GetReadEntry()  const ;
  virtual Long64_t        GetReadEvent()  const ;
  virtual Int_t           GetScanField()  const ;
  TTreeFormula           *GetSelect()    ;
  virtual Long64_t        GetSelectedRows() ;
  virtual Int_t           GetTimerInterval() const ;
  TBuffer*        GetTransientBuffer(Int_t size);
  virtual Long64_t        GetTotBytes() const ;
  virtual TTree          *GetTree() const ;
  virtual TVirtualIndex  *GetTreeIndex() const ;
  virtual Int_t           GetTreeNumber() const ;
  virtual Int_t           GetUpdate() const ;
  virtual TList          *GetUserInfo();
  // See TSelectorDraw::GetVar
  TTreeFormula           *GetVar(Int_t i)  ;
  // See TSelectorDraw::GetVar
  TTreeFormula           *GetVar1() ;
  // See TSelectorDraw::GetVar
  TTreeFormula           *GetVar2() ;
  // See TSelectorDraw::GetVar
  TTreeFormula           *GetVar3() ;
  // See TSelectorDraw::GetVar
  TTreeFormula           *GetVar4() ;
  // See TSelectorDraw::GetVal
  virtual Double_t       *GetVal(Int_t i)   ;
  // See TSelectorDraw::GetVal
  virtual Double_t       *GetV1()   ;
  // See TSelectorDraw::GetVal
  virtual Double_t       *GetV2()   ;
  // See TSelectorDraw::GetVal
  virtual Double_t       *GetV3()   ;
  // See TSelectorDraw::GetVal
  virtual Double_t       *GetV4()   ;
  virtual Double_t       *GetW()    ;
  virtual Double_t        GetWeight() const   ;
  virtual Long64_t        GetZipBytes() const ;
  virtual void            IncrementTotalBuffers(Int_t nbytes) ;
  Bool_t                  IsFolder() const ;
  virtual Int_t           LoadBaskets(Long64_t maxmemory = 2000000000);
  virtual Long64_t        LoadTree(Long64_t entry);
  virtual Long64_t        LoadTreeFriend(Long64_t entry, TTree* T);
  virtual Int_t           MakeClass(const char* classname = 0, Option_t* option = "");
  virtual Int_t           MakeCode(const char* filename = 0);
  virtual Int_t           MakeProxy(const char* classname, const char* macrofilename = 0, const char* cutfilename = 0, const char* option = 0, Int_t maxUnrolling = 3);
  virtual Int_t           MakeSelector(const char* selector = 0);
  Bool_t                  MemoryFull(Int_t nbytes);
  virtual Long64_t        Merge(TCollection* list, Option_t* option = "");
  virtual Long64_t        Merge(TCollection* list, TFileMergeInfo *info);
  static  TTree          *MergeTrees(TList* list, Option_t* option = "");
  virtual Bool_t          Notify();
  virtual void            OptimizeBaskets(ULong64_t maxMemory=10000000, Float_t minComp=1.1, Option_t *option=""); 
  TPrincipal             *Principal(const char* varexp = "", const char* selection = "", Option_t* option = "np", Long64_t nentries = 1000000000, Long64_t firstentry = 0);
  virtual void            Print(Option_t* option = "") const; // *MENU*
  virtual void            PrintCacheStats(Option_t* option = "") const;
  virtual Long64_t        Process(const char* filename, Option_t* option = "", Long64_t nentries = 1000000000, Long64_t firstentry = 0); // *MENU*
#if defined(__CINT__)
#if defined(R__MANUAL_DICT)
  virtual Long64_t        Process(void* selector, Option_t* option = "", Long64_t nentries = 1000000000, Long64_t firstentry = 0);
#endif
#else
  virtual Long64_t        Process(TSelector* selector, Option_t* option = "", Long64_t nentries = 1000000000, Long64_t firstentry = 0);
#endif
  virtual Long64_t        Project(const char* hname, const char* varexp, const char* selection = "", Option_t* option = "", Long64_t nentries = 1000000000, Long64_t firstentry = 0);
  virtual TSQLResult     *Query(const char* varexp = "", const char* selection = "", Option_t* option = "", Long64_t nentries = 1000000000, Long64_t firstentry = 0);
  virtual Long64_t        ReadFile(const char* filename, const char* branchDescriptor = "", char delimiter = ' ');
  virtual Long64_t        ReadStream(istream& inputStream, const char* branchDescriptor = "", char delimiter = ' ');
  virtual void            Refresh();
  virtual void            RecursiveRemove(TObject *obj);
  virtual void            RemoveFriend(TTree*);
  virtual void            Reset(Option_t* option = "");
  virtual void            ResetAfterMerge(TFileMergeInfo *);
  virtual void            ResetBranchAddress(TBranch *);
  virtual void            ResetBranchAddresses();
  virtual Long64_t        Scan(const char* varexp = "", const char* selection = "", Option_t* option = "", Long64_t nentries = 1000000000, Long64_t firstentry = 0); // *MENU*
  virtual Bool_t          SetAlias(const char* aliasName, const char* aliasFormula);
  virtual void            SetAutoSave(Long64_t autos = 300000000);
  virtual void            SetAutoFlush(Long64_t autof = -30000000);
  virtual void            SetBasketSize(const char* bname, Int_t buffsize = 16000);
#if !defined(__CINT__)
  virtual Int_t           SetBranchAddress(const char *bname,void *add, TBranch **ptr = 0);
#endif
  virtual Int_t           SetBranchAddress(const char *bname,void *add, TClass *realClass, EDataType datatype, Bool_t isptr);
  virtual Int_t           SetBranchAddress(const char *bname,void *add, TBranch **ptr, TClass *realClass, EDataType datatype, Bool_t isptr);
  template <class T> Int_t SetBranchAddress(const char *bname, T **add, TBranch **ptr = 0) ;
#ifndef R__NO_CLASS_TEMPLATE_SPECIALIZATION
  // This can only be used when the template overload resolution can distringuish between
  // T* and T**
  template <class T> Int_t SetBranchAddress(const char *bname, T *add, TBranch **ptr = 0) ;
#endif
  virtual void            SetBranchStatus(const char* bname, Bool_t status = 1, UInt_t* found = 0);
  static  void            SetBranchStyle(Int_t style = 1);  //style=0 for old branch, =1 for new branch style
  virtual void            SetCacheSize(Long64_t cachesize = -1);
  virtual void            SetCacheEntryRange(Long64_t first, Long64_t last);
  virtual void            SetCacheLearnEntries(Int_t n=10);
  virtual void            SetChainOffset(Long64_t offset = 0) ;
  virtual void            SetCircular(Long64_t maxEntries);
  virtual void            SetDebug(Int_t level = 1, Long64_t min = 0, Long64_t max = 9999999); // *MENU*
  virtual void            SetDefaultEntryOffsetLen(Int_t newdefault, Bool_t updateExisting = kFALSE);
  virtual void            SetDirectory(TDirectory* dir);
  virtual Long64_t        SetEntries(Long64_t n = -1);
  virtual void            SetEstimate(Long64_t nentries = 1000000);
  virtual void            SetFileNumber(Int_t number = 0);
  virtual void            SetEventList(TEventList* list);
  virtual void            SetEntryList(TEntryList* list, Option_t *opt="");
  virtual void            SetMakeClass(Int_t make);
  virtual void            SetMaxEntryLoop(Long64_t maxev = 1000000000) ; // *MENU*
  static  void            SetMaxTreeSize(Long64_t maxsize = 1900000000);
  virtual void            SetMaxVirtualSize(Long64_t size = 0) ; // *MENU*
  virtual void            SetName(const char* name); // *MENU*
  virtual void            SetNotify(TObject* obj) ;
  virtual void            SetObject(const char* name, const char* title);
  virtual void            SetParallelUnzip(Bool_t opt=kTRUE, Float_t RelSize=-1);
  virtual void            SetScanField(Int_t n = 50) ; // *MENU*
  virtual void            SetTimerInterval(Int_t msec = 333) ;
  virtual void            SetTreeIndex(TVirtualIndex*index);
  virtual void            SetWeight(Double_t w = 1, Option_t* option = "");
  virtual void            SetUpdate(Int_t freq = 0) ;
  virtual void            Show(Long64_t entry = -1, Int_t lenmax = 20);
  virtual void            StartViewer(); // *MENU*
  virtual void            StopCacheLearningPhase();
  virtual Int_t           UnbinnedFit(const char* funcname, const char* varexp, const char* selection = "", Option_t* option = "", Long64_t nentries = 1000000000, Long64_t firstentry = 0);
  void                    UseCurrentStyle();
  virtual Int_t           Write(const char *name=0, Int_t option=0, Int_t bufsize=0);
  virtual Int_t           Write(const char *name=0, Int_t option=0, Int_t bufsize=0) const;
};


class TChain : public TTree {
public:
  TChain();
  TChain(const char* name, const char* title = "");

  %extend {
    static TChain* create(const char* name, const char* title="")
    {
      return new TChain(name, title);
    }
  }

  virtual ~TChain();
  
  virtual Int_t Add(TChain* chain);
  // virtual Int_t Add(const char* name, Long64_t nentries = kBigNumber);
  virtual Int_t AddFile(const char* name, Long64_t nentries = kBigNumber, const char* tname = "");
};


class TBranch : public TNamed , public TAttFill {
protected:
public:
  TBranch();
  TBranch(TTree *tree, const char *name, void *address, const char *leaflist, Int_t basketsize=32000, Int_t compress=-1);
  TBranch(TBranch *parent, const char *name, void *address, const char *leaflist, Int_t basketsize=32000, Int_t compress=-1);
  virtual ~TBranch();

  virtual void      AddBasket(TBasket &b, Bool_t ondisk, Long64_t startEntry);
  virtual void      AddLastBasket(Long64_t startEntry);
  virtual void      Browse(TBrowser *b);
  virtual void      DeleteBaskets(Option_t* option="");
  virtual void      DropBaskets(Option_t *option = "");
  void      ExpandBasketArrays();
  virtual Int_t     Fill();
  virtual TBranch  *FindBranch(const char *name);
  virtual TLeaf    *FindLeaf(const char *name);
  Int_t     FlushBaskets();
  Int_t     FlushOneBasket(UInt_t which);

  virtual char     *GetAddress() const ;
  TBasket  *GetBasket(Int_t basket);
  Int_t    *GetBasketBytes() const ;
  Long64_t *GetBasketEntry() const ;
  virtual Long64_t  GetBasketSeek(Int_t basket) const;
  virtual Int_t     GetBasketSize() const ;
  virtual TList    *GetBrowsables();
  virtual const char* GetClassName() const;
  Int_t     GetCompressionAlgorithm() const;
  Int_t     GetCompressionLevel() const;
  Int_t     GetCompressionSettings() const;
  TDirectory       *GetDirectory() const ;
  virtual Int_t     GetEntry(Long64_t entry=0, Int_t getall = 0);
  virtual Int_t     GetEntryExport(Long64_t entry, Int_t getall, TClonesArray *list, Int_t n);
  Int_t     GetEntryOffsetLen() const ;
  Int_t     GetEvent(Long64_t entry=0) ;
  const char       *GetIconName() const;
  virtual Int_t     GetExpectedType(TClass *&clptr,EDataType &type);
  virtual TLeaf    *GetLeaf(const char *name) const;
  virtual TFile    *GetFile(Int_t mode=0);
  const char       *GetFileName()    const ;
  Int_t     GetOffset()      const ;
  Int_t     GetReadBasket()  const ;
  Long64_t  GetReadEntry()   const ;
  Int_t     GetWriteBasket() const ;
  Long64_t  GetTotalSize(Option_t *option="")   const;
  Long64_t  GetTotBytes(Option_t *option="")    const;
  Long64_t  GetZipBytes(Option_t *option="")    const;
  Long64_t  GetEntryNumber() const ;
  Long64_t  GetFirstEntry()  const ;
  TObjArray  *GetListOfBaskets()  ;
  TObjArray  *GetListOfBranches() ;
  TObjArray  *GetListOfLeaves()   ;
  Int_t     GetMaxBaskets()  const  ;
  Int_t     GetNleaves()     const ;
  Int_t     GetSplitLevel()  const ;
  Long64_t  GetEntries()     const ;
  TTree    *GetTree()        const ;
  virtual Int_t     GetRow(Int_t row);
  virtual Bool_t    GetMakeClass() const;
  TBranch          *GetMother() const;
  TBranch          *GetSubBranch(const TBranch *br) const;
  Bool_t            IsAutoDelete() const;
  Bool_t            IsFolder() const;
  virtual void      KeepCircular(Long64_t maxEntries);
  virtual Int_t     LoadBaskets();
  virtual void      Print(Option_t *option="") const;
  virtual void      ReadBasket(TBuffer &b);
  virtual void      Refresh(TBranch *b);
  virtual void      Reset(Option_t *option="");
  virtual void      ResetAfterMerge(TFileMergeInfo *);
  virtual void      ResetAddress();
  virtual void      ResetReadEntry() ;
  virtual void      SetAddress(void *add);
  virtual void      SetObject(void *objadd);
  virtual void      SetAutoDelete(Bool_t autodel=kTRUE);
  virtual void      SetBasketSize(Int_t buffsize);
  virtual void      SetBufferAddress(TBuffer *entryBuffer);
  void              SetCompressionAlgorithm(Int_t algorithm=0);
  void              SetCompressionLevel(Int_t level=1);
  void              SetCompressionSettings(Int_t settings=1);
  virtual void      SetEntries(Long64_t entries);
  virtual void      SetEntryOffsetLen(Int_t len, Bool_t updateSubBranches = kFALSE);
  virtual void      SetFirstEntry( Long64_t entry );
  virtual void      SetFile(TFile *file=0);
  virtual void      SetFile(const char *filename);
  virtual Bool_t    SetMakeClass(Bool_t decomposeObj = kTRUE);
  virtual void      SetOffset(Int_t offset=0) ;
  virtual void      SetStatus(Bool_t status=1);
  virtual void      SetTree(TTree *tree) ;
  virtual void      SetupAddresses();
  virtual void      UpdateAddress() ;
  virtual void      UpdateFile();

  static  void      ResetCount();
};


class TLeaf : public TNamed {
public:
  TLeaf();
  TLeaf(TBranch *parent, const char* name, const char* type);
  virtual ~TLeaf();

  virtual void     Browse(TBrowser* b);
  virtual void     Export(TClonesArray*, Int_t) ;
  virtual void     FillBasket(TBuffer& b);
  TBranch         *GetBranch() const ;
  virtual TLeaf   *GetLeafCount() const ;
  virtual TLeaf   *GetLeafCounter(Int_t& countval) const;
  virtual Int_t    GetLen() const;
  virtual Int_t    GetLenStatic() const ;
  virtual Int_t    GetLenType() const ;
  virtual Int_t    GetMaximum() const ;
  virtual Int_t    GetMinimum() const ;
  virtual Int_t    GetNdata() const ;
  virtual Int_t    GetOffset() const ;
  virtual void    *GetValuePointer() const ;
  virtual const char *GetTypeName() const ;
  virtual Double_t GetValue(Int_t i = 0) const;
  virtual void     Import(TClonesArray*, Int_t) ;
  virtual Bool_t   IsOnTerminalBranch() const ;
  virtual Bool_t   IsRange() const ;
  virtual Bool_t   IsUnsigned() const ;
  virtual void     PrintValue(Int_t i = 0) const;
  virtual void     ReadBasket(TBuffer&) ;
  virtual void     ReadBasketExport(TBuffer&, TClonesArray*, Int_t) ;
  virtual void     ReadValue(istream& /*s*/, Char_t /*delim*/ = ' ');
  Int_t    ResetAddress(void* add, Bool_t destructor = kFALSE);
  virtual void     SetAddress(void* add = 0);
  virtual void     SetBranch(TBranch* branch) ;
  virtual void     SetLeafCount(TLeaf* leaf);
  virtual void     SetLen(Int_t len = 1) ;
  virtual void     SetOffset(Int_t offset = 0) ;
  virtual void     SetRange(Bool_t range = kTRUE) ;
  virtual void     SetUnsigned() ;
};


namespace rubyroot {

class TreeIOHelper
{
public:
  explicit TreeIOHelper(TTree* t);
  ~TreeIOHelper();

  Int_t get_entry(Long64_t entry=0, Int_t getall=0);
  Long64_t get_entries();

  void set_value_B(const std::string& name, Char_t v);
  void set_value_S(const std::string& name, Short_t v);
  void set_value_I(const std::string& name, Int_t v);
  void set_value_L(const std::string& name, Long64_t v);
  void set_value_b(const std::string& name, UChar_t v);
  void set_value_s(const std::string& name, UShort_t v);
  void set_value_i(const std::string& name, UInt_t v);
  void set_value_l(const std::string& name, ULong64_t v);
  void set_value_F(const std::string& name, Float_t v);
  void set_value_D(const std::string& name, Double_t v);
  void set_value_O(const std::string& name, Bool_t v);

  void set_array_B(const std::string& name, int* a);
  void set_array_S(const std::string& name, int* a);
  void set_array_I(const std::string& name, int* a);
  void set_array_L(const std::string& name, int* a);
  void set_array_b(const std::string& name, int* a);
  void set_array_s(const std::string& name, int* a);
  void set_array_i(const std::string& name, int* a);
  void set_array_l(const std::string& name, int* a);
  void set_array_F(const std::string& name, double* a);
  void set_array_D(const std::string& name, double* a);
  void set_array_O(const std::string& name, int* a);

  Char_t get_value_B(const std::string& name);
  Short_t get_value_S(const std::string& name);
  Int_t get_value_I(const std::string& name);
  Long64_t get_value_L(const std::string& name);
  UChar_t get_value_b(const std::string& name);
  UShort_t get_value_s(const std::string& name);
  UInt_t get_value_i(const std::string& name);
  ULong64_t get_value_l(const std::string& name);
  Float_t get_value_F(const std::string& name);
  Double_t get_value_D(const std::string& name);
  Bool_t get_value_O(const std::string& name);

  void get_array_B(const std::string& name, int* a);
  void get_array_S(const std::string& name, int* a);
  void get_array_I(const std::string& name, int* a);
  void get_array_L(const std::string& name, int* a);
  void get_array_b(const std::string& name, int* a);
  void get_array_s(const std::string& name, int* a);
  void get_array_i(const std::string& name, int* a);
  void get_array_l(const std::string& name, int* a);
  void get_array_F(const std::string& name, double* a);
  void get_array_D(const std::string& name, double* a);
  void get_array_O(const std::string& name, int* a);

  void set_branches();
  void construct_branches();
  void register_branch(const std::string& name, const std::string& type, size_t length=1, const std::string& leaf_ref="");
};

}
