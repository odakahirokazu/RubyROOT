/**************************************************************************/
/* Tree classes                                                           */
/**************************************************************************/

class TTree : public TNamed, public TAttLine, public TAttFill, public TAttMarker {
public:
  // Used as the max value for any TTree range operation.
  %rename(KMaxEntries) kMaxEntries;
  static constexpr Long64_t kMaxEntries = TVirtualTreePlayer::kMaxEntries;

  TTree();
  TTree(const char* name, const char* title, Int_t splitlevel = 99);
  %extend {
    static TTree* create(const char* name, const char* title, Int_t splitlevel = 99)
    {
      return new TTree(name, title, splitlevel);
    }
  }

  virtual ~TTree();

  virtual Int_t           AddBranchToCache(const char *bname, Bool_t subbranches = kFALSE);
  virtual Int_t           AddBranchToCache(TBranch *branch,   Bool_t subbranches = kFALSE);
  virtual Int_t           DropBranchFromCache(const char *bname, Bool_t subbranches = kFALSE);
  virtual Int_t           DropBranchFromCache(TBranch *branch,   Bool_t subbranches = kFALSE);
  virtual TFriendElement *AddFriend(const char* treename, const char* filename = "");
  virtual TFriendElement *AddFriend(const char* treename, TFile* file);
  virtual TFriendElement *AddFriend(TTree* tree, const char* alias = "", Bool_t warn = kFALSE);
  virtual void            AddTotBytes(Int_t tot) { fTotBytes += tot; }
  virtual void            AddZipBytes(Int_t zip) { fZipBytes += zip; }
  virtual Long64_t        AutoSave(Option_t* option = "");
  virtual Int_t           Branch(TCollection* list, Int_t bufsize = 32000, Int_t splitlevel = 99, const char* name = "");
  virtual Int_t           Branch(TList* list, Int_t bufsize = 32000, Int_t splitlevel = 99);
  virtual Int_t           Branch(const char* folder, Int_t bufsize = 32000, Int_t splitlevel = 99);
  virtual TBranch        *Branch(const char* name, void* address, const char* leaflist, Int_t bufsize = 32000);
  TBranch        *Branch(const char* name, char* address, const char* leaflist, Int_t bufsize = 32000)
  {
    // Overload to avoid confusion between this signature and the template instance.
    return Branch(name,(void*)address,leaflist,bufsize);
  }
  TBranch        *Branch(const char* name, Long_t address, const char* leaflist, Int_t bufsize = 32000)
  {
    // Overload to avoid confusion between this signature and the template instance.
    return Branch(name,(void*)address,leaflist,bufsize);
  }
  TBranch        *Branch(const char* name, int address, const char* leaflist, Int_t bufsize = 32000)
  {
    // Overload to avoid confusion between this signature and the template instance.
    return Branch(name,(void*)(Long_t)address,leaflist,bufsize);
  }
#if !defined(__CINT__)
  virtual TBranch        *Branch(const char* name, const char* classname, void* addobj, Int_t bufsize = 32000, Int_t splitlevel = 99);
#endif
  template <class T> TBranch *Branch(const char* name, const char* classname, T* obj, Int_t bufsize = 32000, Int_t splitlevel = 99)
  {
    // See BranchImpRed for details. Here we __ignore
    return BranchImpRef(name, classname, TBuffer::GetClass(typeid(T)), obj, bufsize, splitlevel);
  }
  template <class T> TBranch *Branch(const char* name, const char* classname, T** addobj, Int_t bufsize = 32000, Int_t splitlevel = 99)
  {
    // See BranchImp for details
    return BranchImp(name, classname, TBuffer::GetClass(typeid(T)), addobj, bufsize, splitlevel);
  }
  template <class T> TBranch *Branch(const char* name, T** addobj, Int_t bufsize = 32000, Int_t splitlevel = 99)
  {
    // See BranchImp for details
    return BranchImp(name, TBuffer::GetClass(typeid(T)), addobj, bufsize, splitlevel);
  }
  template <class T> TBranch *Branch(const char* name, T* obj, Int_t bufsize = 32000, Int_t splitlevel = 99)
  {
    // See BranchImp for details
    return BranchImpRef(name, TBuffer::GetClass(typeid(T)), TDataType::GetType(typeid(T)), obj, bufsize, splitlevel);
  }
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
  virtual TTree          *CopyTree(const char* selection, Option_t* option = "", Long64_t nentries = kMaxEntries, Long64_t firstentry = 0);
  virtual TBasket        *CreateBasket(TBranch*);
  virtual void            DirectoryAutoAdd(TDirectory *);
  Int_t                   Debug() const { return fDebug; }
  virtual void            Delete(Option_t* option = ""); // *MENU*
  virtual void            Draw(Option_t* opt) { Draw(opt, "", "", kMaxEntries, 0); }
  virtual Long64_t        Draw(const char* varexp, const TCut& selection, Option_t* option = "", Long64_t nentries = kMaxEntries, Long64_t firstentry = 0);
  virtual Long64_t        Draw(const char* varexp, const char* selection, Option_t* option = "", Long64_t nentries = kMaxEntries, Long64_t firstentry = 0); // *MENU*
  virtual void            DropBaskets();
  virtual void            DropBuffers(Int_t nbytes);
  virtual Int_t           Fill();
  virtual TBranch        *FindBranch(const char* name);
  virtual TLeaf          *FindLeaf(const char* name);
  virtual Int_t           Fit(const char* funcname, const char* varexp, const char* selection = "", Option_t* option = "", Option_t* goption = "", Long64_t nentries = kMaxEntries, Long64_t firstentry = 0); // *MENU*
  virtual Int_t           FlushBaskets() const;
  virtual const char     *GetAlias(const char* aliasName) const;
  virtual Long64_t        GetAutoFlush() const {return fAutoFlush;}
  virtual Long64_t        GetAutoSave()  const {return fAutoSave;}
  virtual TBranch        *GetBranch(const char* name);
  virtual TBranchRef     *GetBranchRef() const { return fBranchRef; };
  virtual Bool_t          GetBranchStatus(const char* branchname) const;
  static  Int_t           GetBranchStyle();
  virtual Long64_t        GetCacheSize() const { return fCacheSize; }

  virtual Long64_t        GetChainEntryNumber(Long64_t entry) const { return entry; }
  virtual Long64_t        GetChainOffset() const { return fChainOffset; }
  TFile                  *GetCurrentFile() const;
  Int_t           GetDefaultEntryOffsetLen() const {return fDefaultEntryOffsetLen;}
  Long64_t        GetDebugMax()  const { return fDebugMax; }
  Long64_t        GetDebugMin()  const { return fDebugMin; }
  TDirectory             *GetDirectory() const { return fDirectory; }
  virtual Long64_t        GetEntries() const   { return fEntries; }
  virtual Long64_t        GetEntries(const char *selection);
  virtual Long64_t        GetEntriesFast() const   { return fEntries; }
  virtual Long64_t        GetEntriesFriend() const;
  virtual Long64_t        GetEstimate() const { return fEstimate; }
  virtual Int_t           GetEntry(Long64_t entry, Int_t getall = 0);
  Int_t           GetEvent(Long64_t entry, Int_t getall = 0) { return GetEntry(entry, getall); }
  virtual Int_t           GetEntryWithIndex(Int_t major, Int_t minor = 0);
  virtual Long64_t        GetEntryNumberWithBestIndex(Long64_t major, Long64_t minor = 0) const;
  virtual Long64_t        GetEntryNumberWithIndex(Long64_t major, Long64_t minor = 0) const;
  TEventList             *GetEventList() const { return fEventList; }
  virtual TEntryList     *GetEntryList();
  virtual Long64_t        GetEntryNumber(Long64_t entry) const;
  virtual Int_t           GetFileNumber() const { return fFileNumber; }
  virtual TTree          *GetFriend(const char*) const;
  virtual const char     *GetFriendAlias(TTree*) const;
  TH1                    *GetHistogram() { return GetPlayer()->GetHistogram(); }
  virtual Int_t          *GetIndex() { return &fIndex.fArray[0]; }
  virtual Double_t       *GetIndexValues() { return &fIndexValues.fArray[0]; }
  virtual TIterator      *GetIteratorOnAllLeaves(Bool_t dir = kIterForward);
  virtual TLeaf          *GetLeaf(const char* branchname, const char* leafname);
  virtual TLeaf          *GetLeaf(const char* name);
  virtual TList          *GetListOfClones() { return fClones; }
  virtual TObjArray      *GetListOfBranches() { return &fBranches; }
  virtual TObjArray      *GetListOfLeaves() { return &fLeaves; }
  virtual TList          *GetListOfFriends() const { return fFriends; }
  virtual TList          *GetListOfAliases() const { return fAliases; }

  // GetMakeClass is left non-virtual for efficiency reason.
  // Making it virtual affects the performance of the I/O
  Int_t           GetMakeClass() const { return fMakeClass; }

  virtual Long64_t        GetMaxEntryLoop() const { return fMaxEntryLoop; }
  virtual Double_t        GetMaximum(const char* columname);
  static  Long64_t        GetMaxTreeSize();
  virtual Long64_t        GetMaxVirtualSize() const { return fMaxVirtualSize; }
  virtual Double_t        GetMinimum(const char* columname);
  virtual Int_t           GetNbranches() { return fBranches.GetEntriesFast(); }
  TObject                *GetNotify() const { return fNotify; }
  TVirtualTreePlayer     *GetPlayer();
  virtual Int_t           GetPacketSize() const { return fPacketSize; }
  virtual TVirtualPerfStats *GetPerfStats() const { return fPerfStats; }
  virtual Long64_t        GetReadEntry()  const { return fReadEntry; }
  virtual Long64_t        GetReadEvent()  const { return fReadEntry; }
  virtual Int_t           GetScanField()  const { return fScanField; }
  TTreeFormula           *GetSelect()    { return GetPlayer()->GetSelect(); }
  virtual Long64_t        GetSelectedRows() { return GetPlayer()->GetSelectedRows(); }
  virtual Int_t           GetTimerInterval() const { return fTimerInterval; }
  TBuffer*        GetTransientBuffer(Int_t size);
  virtual Long64_t        GetTotBytes() const { return fTotBytes; }
  virtual TTree          *GetTree() const { return const_cast<TTree*>(this); }
  virtual TVirtualIndex  *GetTreeIndex() const { return fTreeIndex; }
  virtual Int_t           GetTreeNumber() const { return 0; }
  virtual Int_t           GetUpdate() const { return fUpdate; }
  virtual TList          *GetUserInfo();
  // See TSelectorDraw::GetVar
  TTreeFormula           *GetVar(Int_t i)  { return GetPlayer()->GetVar(i); }
  // See TSelectorDraw::GetVar
  TTreeFormula           *GetVar1() { return GetPlayer()->GetVar1(); }
  // See TSelectorDraw::GetVar
  TTreeFormula           *GetVar2() { return GetPlayer()->GetVar2(); }
  // See TSelectorDraw::GetVar
  TTreeFormula           *GetVar3() { return GetPlayer()->GetVar3(); }
  // See TSelectorDraw::GetVar
  TTreeFormula           *GetVar4() { return GetPlayer()->GetVar4(); }
  // See TSelectorDraw::GetVal
  virtual Double_t       *GetVal(Int_t i)   { return GetPlayer()->GetVal(i); }
  // See TSelectorDraw::GetVal
  virtual Double_t       *GetV1()   { return GetPlayer()->GetV1(); }
  // See TSelectorDraw::GetVal
  virtual Double_t       *GetV2()   { return GetPlayer()->GetV2(); }
  // See TSelectorDraw::GetVal
  virtual Double_t       *GetV3()   { return GetPlayer()->GetV3(); }
  // See TSelectorDraw::GetVal
  virtual Double_t       *GetV4()   { return GetPlayer()->GetV4(); }
  virtual Double_t       *GetW()    { return GetPlayer()->GetW(); }
  virtual Double_t        GetWeight() const   { return fWeight; }
  virtual Long64_t        GetZipBytes() const { return fZipBytes; }
  virtual void            IncrementTotalBuffers(Int_t nbytes) { fTotalBuffers += nbytes; }
  Bool_t                  IsFolder() const { return kTRUE; }
  virtual Int_t           LoadBaskets(Long64_t maxmemory = 2000000000);
  virtual Long64_t        LoadTree(Long64_t entry);
  virtual Long64_t        LoadTreeFriend(Long64_t entry, TTree* T);
  virtual Int_t           MakeClass(const char* classname = 0, Option_t* option = "");
  virtual Int_t           MakeCode(const char* filename = 0);
  virtual Int_t           MakeProxy(const char* classname, const char* macrofilename = 0, const char* cutfilename = 0, const char* option = 0, Int_t maxUnrolling = 3);
  virtual Int_t           MakeSelector(const char* selector = 0, Option_t* option = "");
  Bool_t                  MemoryFull(Int_t nbytes);
  virtual Long64_t        Merge(TCollection* list, Option_t* option = "");
  virtual Long64_t        Merge(TCollection* list, TFileMergeInfo *info);
  static  TTree          *MergeTrees(TList* list, Option_t* option = "");
  virtual Bool_t          Notify();
  virtual void            OptimizeBaskets(ULong64_t maxMemory=10000000, Float_t minComp=1.1, Option_t *option="");
  TPrincipal             *Principal(const char* varexp = "", const char* selection = "", Option_t* option = "np", Long64_t nentries = kMaxEntries, Long64_t firstentry = 0);
  virtual void            Print(Option_t* option = "") const; // *MENU*
  virtual void            PrintCacheStats(Option_t* option = "") const;
  virtual Long64_t        Process(const char* filename, Option_t* option = "", Long64_t nentries = kMaxEntries, Long64_t firstentry = 0); // *MENU*
#if defined(__CINT__)
#if defined(R__MANUAL_DICT)
  virtual Long64_t        Process(void* selector, Option_t* option = "", Long64_t nentries = kMaxEntries, Long64_t firstentry = 0);
#endif
#else
  virtual Long64_t        Process(TSelector* selector, Option_t* option = "", Long64_t nentries = kMaxEntries, Long64_t firstentry = 0);
#endif
  virtual Long64_t        Project(const char* hname, const char* varexp, const char* selection = "", Option_t* option = "", Long64_t nentries = kMaxEntries, Long64_t firstentry = 0);
  virtual TSQLResult     *Query(const char* varexp = "", const char* selection = "", Option_t* option = "", Long64_t nentries = kMaxEntries, Long64_t firstentry = 0);
  virtual Long64_t        ReadFile(const char* filename, const char* branchDescriptor = "", char delimiter = ' ');
  virtual Long64_t        ReadStream(std::istream& inputStream, const char* branchDescriptor = "", char delimiter = ' ');
  virtual void            Refresh();
  virtual void            RecursiveRemove(TObject *obj);
  virtual void            RemoveFriend(TTree*);
  virtual void            Reset(Option_t* option = "");
  virtual void            ResetAfterMerge(TFileMergeInfo *);
  virtual void            ResetBranchAddress(TBranch *);
  virtual void            ResetBranchAddresses();
  virtual Long64_t        Scan(const char* varexp = "", const char* selection = "", Option_t* option = "", Long64_t nentries = kMaxEntries, Long64_t firstentry = 0); // *MENU*
  virtual Bool_t          SetAlias(const char* aliasName, const char* aliasFormula);
  virtual void            SetAutoSave(Long64_t autos = -300000000);
  virtual void            SetAutoFlush(Long64_t autof = -30000000);
  virtual void            SetBasketSize(const char* bname, Int_t buffsize = 16000);
#if !defined(__CINT__)
  virtual Int_t           SetBranchAddress(const char *bname,void *add, TBranch **ptr = 0);
#endif
  virtual Int_t           SetBranchAddress(const char *bname,void *add, TClass *realClass, EDataType datatype, Bool_t isptr);
  virtual Int_t           SetBranchAddress(const char *bname,void *add, TBranch **ptr, TClass *realClass, EDataType datatype, Bool_t isptr);
  template <class T> Int_t SetBranchAddress(const char *bname, T **add, TBranch **ptr = 0) {
    TClass *cl = TClass::GetClass(typeid(T));
    EDataType type = kOther_t;
    if (cl==0) type = TDataType::GetType(typeid(T));
    return SetBranchAddress(bname,add,ptr,cl,type,true);
  }
#ifndef R__NO_CLASS_TEMPLATE_SPECIALIZATION
  // This can only be used when the template overload resolution can distringuish between
  // T* and T**
  template <class T> Int_t SetBranchAddress(const char *bname, T *add, TBranch **ptr = 0) {
    TClass *cl = TClass::GetClass(typeid(T));
    EDataType type = kOther_t;
    if (cl==0) type = TDataType::GetType(typeid(T));
    return SetBranchAddress(bname,add,ptr,cl,type,false);
  }
#endif
  virtual void            SetBranchStatus(const char* bname, Bool_t status = 1, UInt_t* found = 0);
  static  void            SetBranchStyle(Int_t style = 1);  //style=0 for old branch, =1 for new branch style
  virtual Int_t           SetCacheSize(Long64_t cachesize = -1);
  virtual Int_t           SetCacheEntryRange(Long64_t first, Long64_t last);
  virtual void            SetCacheLearnEntries(Int_t n=10);
  virtual void            SetChainOffset(Long64_t offset = 0) { fChainOffset=offset; }
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
  virtual void            SetMaxEntryLoop(Long64_t maxev = kMaxEntries) { fMaxEntryLoop = maxev; } // *MENU*
  static  void            SetMaxTreeSize(Long64_t maxsize = 1900000000);
  virtual void            SetMaxVirtualSize(Long64_t size = 0) { fMaxVirtualSize = size; } // *MENU*
  virtual void            SetName(const char* name); // *MENU*
  virtual void            SetNotify(TObject* obj) { fNotify = obj; }
  virtual void            SetObject(const char* name, const char* title);
  virtual void            SetParallelUnzip(Bool_t opt=kTRUE, Float_t RelSize=-1);
  virtual void            SetPerfStats(TVirtualPerfStats* perf);
  virtual void            SetScanField(Int_t n = 50) { fScanField = n; } // *MENU*
  virtual void            SetTimerInterval(Int_t msec = 333) { fTimerInterval=msec; }
  virtual void            SetTreeIndex(TVirtualIndex* index);
  virtual void            SetWeight(Double_t w = 1, Option_t* option = "");
  virtual void            SetUpdate(Int_t freq = 0) { fUpdate = freq; }
  virtual void            Show(Long64_t entry = -1, Int_t lenmax = 20);
  virtual void            StartViewer(); // *MENU*
  virtual Int_t           StopCacheLearningPhase();
  virtual Int_t           UnbinnedFit(const char* funcname, const char* varexp, const char* selection = "", Option_t* option = "", Long64_t nentries = kMaxEntries, Long64_t firstentry = 0);
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

  virtual Int_t     Add(TChain* chain);
  virtual Int_t     Add(const char* name, Long64_t nentries = TTree::kMaxEntries);
  virtual Int_t     AddFile(const char* name, Long64_t nentries = TTree::kMaxEntries, const char* tname = "");
  virtual Int_t     AddFileInfoList(TCollection* list, Long64_t nfiles = TTree::kMaxEntries);
  virtual TFriendElement *AddFriend(const char* chainname, const char* dummy = "");
  virtual TFriendElement *AddFriend(const char* chainname, TFile* dummy);
  virtual TFriendElement *AddFriend(TTree* chain, const char* alias = "", Bool_t warn = kFALSE);
  virtual void      Browse(TBrowser*);
  virtual void      CanDeleteRefs(Bool_t flag = kTRUE);
  virtual void      CreatePackets();
  virtual void      DirectoryAutoAdd(TDirectory *);
  virtual Long64_t  Draw(const char* varexp, const TCut& selection, Option_t* option = "", Long64_t nentries = kMaxEntries, Long64_t firstentry = 0);
  virtual Long64_t  Draw(const char* varexp, const char* selection, Option_t* option = "", Long64_t nentries = kMaxEntries, Long64_t firstentry = 0); // *MENU*
  virtual void      Draw(Option_t* opt) { Draw(opt, "", "", kMaxEntries, 0); }
  virtual Int_t     Fill() { MayNotUse("Fill()"); return -1; }
  virtual TBranch  *FindBranch(const char* name);
  virtual TLeaf    *FindLeaf(const char* name);
  virtual TBranch  *GetBranch(const char* name);
  virtual Bool_t    GetBranchStatus(const char* branchname) const;
  virtual Long64_t  GetCacheSize() const { return fTree ? fTree->GetCacheSize() : fCacheSize; }
  virtual Long64_t  GetChainEntryNumber(Long64_t entry) const;
   
  Int_t     GetNtrees() const { return fNtrees; }
  virtual Long64_t  GetEntries() const;
  virtual Long64_t  GetEntries(const char *sel) { return TTree::GetEntries(sel); }
  virtual Int_t     GetEntry(Long64_t entry=0, Int_t getall=0);
  virtual Long64_t  GetEntryNumber(Long64_t entry) const;
  virtual Int_t     GetEntryWithIndex(Int_t major, Int_t minor=0);
  TFile            *GetFile() const;
  virtual TLeaf    *GetLeaf(const char* branchname, const char* leafname);
  virtual TLeaf    *GetLeaf(const char* name);
  virtual TObjArray *GetListOfBranches();
  //                Warning, GetListOfFiles returns the list of TChainElements (not the list of files)
  //                see TChain::AddFile to see how to get the corresponding TFile objects
  TObjArray        *GetListOfFiles() const {return fFiles;}
  virtual TObjArray *GetListOfLeaves();
  virtual const char *GetAlias(const char *aliasName) const;
  virtual Double_t  GetMaximum(const char *columname);
  virtual Double_t  GetMinimum(const char *columname);
  virtual Int_t     GetNbranches();
  virtual Long64_t  GetReadEntry() const;
  TList            *GetStatus() const { return fStatus; }
  virtual TTree    *GetTree() const { return fTree; }
  virtual Int_t     GetTreeNumber() const { return fTreeNumber; }
  Long64_t *GetTreeOffset() const { return fTreeOffset; }
  Int_t     GetTreeOffsetLen() const { return fTreeOffsetLen; }
  virtual Double_t  GetWeight() const;
  virtual Int_t     LoadBaskets(Long64_t maxmemory);
  virtual Long64_t  LoadTree(Long64_t entry);
  void      Lookup(Bool_t force = kFALSE);
  virtual void      Loop(Option_t *option="", Long64_t nentries=kMaxEntries, Long64_t firstentry=0); // *MENU*
  virtual void      ls(Option_t *option="") const;
  virtual Long64_t  Merge(const char *name, Option_t *option = "");
  virtual Long64_t  Merge(TCollection *list, Option_t *option = "");
  virtual Long64_t  Merge(TCollection *list, TFileMergeInfo *info);
  virtual Long64_t  Merge(TFile *file, Int_t basketsize, Option_t *option="");
  virtual void      Print(Option_t *option="") const;
  virtual Long64_t  Process(const char *filename, Option_t *option="", Long64_t nentries=kMaxEntries, Long64_t firstentry=0); // *MENU*
  virtual Long64_t  Process(TSelector* selector, Option_t* option = "", Long64_t nentries = kMaxEntries, Long64_t firstentry = 0);
  virtual void      RecursiveRemove(TObject *obj);
  virtual void      RemoveFriend(TTree*);
  virtual void      Reset(Option_t *option="");
  virtual void      ResetAfterMerge(TFileMergeInfo *);
  virtual void      ResetBranchAddress(TBranch *);
  virtual void      ResetBranchAddresses();
  virtual Long64_t  Scan(const char *varexp="", const char *selection="", Option_t *option="", Long64_t nentries=kMaxEntries, Long64_t firstentry=0); // *MENU*
  virtual void      SetAutoDelete(Bool_t autodel=kTRUE);
  virtual Int_t     SetBranchAddress(const char *bname,void *add, TBranch **ptr = 0);
  virtual Int_t     SetBranchAddress(const char *bname,void *add, TBranch **ptr, TClass *realClass, EDataType datatype, Bool_t isptr);
  virtual Int_t     SetBranchAddress(const char *bname,void *add, TClass *realClass, EDataType datatype, Bool_t isptr);
  template <class T> Int_t SetBranchAddress(const char *bname, T **add, TBranch **ptr = 0) {
    return TTree::SetBranchAddress<T>(bname, add, ptr);
  }
#ifndef R__NO_CLASS_TEMPLATE_SPECIALIZATION
  // This can only be used when the template overload resolution can distringuish between
  // T* and T**
  template <class T> Int_t SetBranchAddress(const char *bname, T *add, TBranch **ptr = 0) {
    return TTree::SetBranchAddress<T>(bname, add, ptr);
  }
#endif

  virtual void      SetBranchStatus(const char *bname, Bool_t status=1, UInt_t *found=0);
  virtual Int_t     SetCacheSize(Long64_t cacheSize = -1);
  virtual void      SetDirectory(TDirectory *dir);
  virtual void      SetEntryList(TEntryList *elist, Option_t *opt="");
  virtual void      SetEntryListFile(const char *filename="", Option_t *opt="");
  virtual void      SetEventList(TEventList *evlist);
  virtual void      SetMakeClass(Int_t make) { TTree::SetMakeClass(make); if (fTree) fTree->SetMakeClass(make);}
  virtual void      SetPacketSize(Int_t size = 100);
  virtual void      SetProof(Bool_t on = kTRUE, Bool_t refresh = kFALSE, Bool_t gettreeheader = kFALSE);
  virtual void      SetWeight(Double_t w=1, Option_t *option="");
  virtual void      UseCache(Int_t maxCacheSize = 10, Int_t pageSize = 0);
};


class TBranch : public TNamed , public TAttFill {
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

  virtual char     *GetAddress() const {return fAddress;}
  TBasket  *GetBasket(Int_t basket);
  Int_t    *GetBasketBytes() const {return fBasketBytes;}
  Long64_t *GetBasketEntry() const {return fBasketEntry;}
  virtual Long64_t  GetBasketSeek(Int_t basket) const;
  virtual Int_t     GetBasketSize() const {return fBasketSize;}
  virtual TList    *GetBrowsables();
  virtual const char* GetClassName() const;
  Int_t     GetCompressionAlgorithm() const;
  Int_t     GetCompressionLevel() const;
  Int_t     GetCompressionSettings() const;
  TDirectory       *GetDirectory() const {return fDirectory;}
  virtual Int_t     GetEntry(Long64_t entry=0, Int_t getall = 0);
  virtual Int_t     GetEntryExport(Long64_t entry, Int_t getall, TClonesArray *list, Int_t n);
  Int_t     GetEntryOffsetLen() const { return fEntryOffsetLen; }
  Int_t     GetEvent(Long64_t entry=0) {return GetEntry(entry);}
  const char       *GetIconName() const;
  virtual Int_t     GetExpectedType(TClass *&clptr,EDataType &type);
  virtual TLeaf    *GetLeaf(const char *name) const;
  virtual TFile    *GetFile(Int_t mode=0);
  const char       *GetFileName()    const {return fFileName.Data();}
  Int_t     GetOffset()      const {return fOffset;}
  Int_t     GetReadBasket()  const {return fReadBasket;}
  Long64_t  GetReadEntry()   const {return fReadEntry;}
  Int_t     GetWriteBasket() const {return fWriteBasket;}
  Long64_t  GetTotalSize(Option_t *option="")   const;
  Long64_t  GetTotBytes(Option_t *option="")    const;
  Long64_t  GetZipBytes(Option_t *option="")    const;
  Long64_t  GetEntryNumber() const {return fEntryNumber;}
  Long64_t  GetFirstEntry()  const {return fFirstEntry; }
  TObjArray  *GetListOfBaskets()  {return &fBaskets;}
  TObjArray  *GetListOfBranches() {return &fBranches;}
  TObjArray  *GetListOfLeaves()   {return &fLeaves;}
  Int_t     GetMaxBaskets()  const  {return fMaxBaskets;}
  Int_t     GetNleaves()     const {return fNleaves;}
  Int_t     GetSplitLevel()  const {return fSplitLevel;}
  Long64_t  GetEntries()     const {return fEntries;}
  TTree    *GetTree()        const {return fTree;}
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
  virtual void      ResetReadEntry() {fReadEntry = -1;}
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
  virtual void      SetOffset(Int_t offset=0) {fOffset=offset;}
  virtual void      SetStatus(Bool_t status=1);
  virtual void      SetTree(TTree *tree) { fTree = tree;}
  virtual void      SetupAddresses();
  virtual void      UpdateAddress() {;}
  virtual void      UpdateFile();

  static  void      ResetCount();
};


class TLeaf : public TNamed {
public:
  TLeaf();
  TLeaf(TBranch *parent, const char* name, const char* type);
  virtual ~TLeaf();

  virtual void     Browse(TBrowser* b);
  virtual void     Export(TClonesArray*, Int_t) {}
  virtual void     FillBasket(TBuffer& b);
  TBranch         *GetBranch() const { return fBranch; }
  virtual TLeaf   *GetLeafCount() const { return fLeafCount; }
  virtual TLeaf   *GetLeafCounter(Int_t& countval) const;
  virtual Int_t    GetLen() const;
  virtual Int_t    GetLenStatic() const { return fLen; }
  virtual Int_t    GetLenType() const { return fLenType; }
  virtual Int_t    GetMaximum() const { return 0; }
  virtual Int_t    GetMinimum() const { return 0; }
  virtual Int_t    GetNdata() const { return fNdata; }
  virtual Int_t    GetOffset() const { return fOffset; }
  virtual void    *GetValuePointer() const { return 0; }
  virtual const char *GetTypeName() const { return ""; }

  virtual Double_t GetValue(Int_t i = 0) const;
  virtual Long64_t GetValueLong64(Int_t i = 0) const { return GetValue(i); } //overload only when it matters.
  virtual LongDouble_t GetValueLongDouble(Int_t i = 0) const { return GetValue(i); } // overload only when it matters.
  template <typename T > T GetTypedValue(Int_t i = 0) const { return GetValueHelper<T>::Exec(this, i); }

  virtual void     Import(TClonesArray*, Int_t) {}
  virtual Bool_t   IsOnTerminalBranch() const { return kTRUE; }
  virtual Bool_t   IsRange() const { return fIsRange; }
  virtual Bool_t   IsUnsigned() const { return fIsUnsigned; }
  virtual void     PrintValue(Int_t i = 0) const;
  virtual void     ReadBasket(TBuffer&) {}
  virtual void     ReadBasketExport(TBuffer&, TClonesArray*, Int_t) {}
  virtual void     ReadValue(std::istream& /*s*/, Char_t /*delim*/ = ' ') {
    Error("ReadValue", "Not implemented!");
  }
  Int_t    ResetAddress(void* add, Bool_t destructor = kFALSE);
  virtual void     SetAddress(void* add = 0);
  virtual void     SetBranch(TBranch* branch) { fBranch = branch; }
  virtual void     SetLeafCount(TLeaf* leaf);
  virtual void     SetLen(Int_t len = 1) { fLen = len; }
  virtual void     SetOffset(Int_t offset = 0) { fOffset = offset; }
  virtual void     SetRange(Bool_t range = kTRUE) { fIsRange = range; }
  virtual void     SetUnsigned() { fIsUnsigned = kTRUE; }
};


namespace rubyroot {

class TreeIOHelper
{
public:
  explicit TreeIOHelper(TTree* t);
  ~TreeIOHelper();

  const TTree* get_tree();
  Int_t get_entry(Long64_t entry=0, Int_t getall=0);
  Long64_t get_entries();

  void set_value_C(const std::string& name, Char_t v);
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

  void set_array_C(const std::string& name, int* a, std::size_t n);
  void set_array_B(const std::string& name, int* a, std::size_t n);
  void set_array_S(const std::string& name, int* a, std::size_t n);
  void set_array_I(const std::string& name, int* a, std::size_t n);
  void set_array_L(const std::string& name, int* a, std::size_t n);
  void set_array_b(const std::string& name, int* a, std::size_t n);
  void set_array_s(const std::string& name, int* a, std::size_t n);
  void set_array_i(const std::string& name, int* a, std::size_t n);
  void set_array_l(const std::string& name, int* a, std::size_t n);
  void set_array_F(const std::string& name, double* a, std::size_t n);
  void set_array_D(const std::string& name, double* a, std::size_t n);
  void set_array_O(const std::string& name, int* a, std::size_t n);

  Char_t get_value_C(const std::string& name);
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

  void get_array_C(const std::string& name, int* a);
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
