/**************************************************************************/
/* File classes                                                          */
/**************************************************************************/

class TDirectoryFile : public TDirectory {
public:
  TDirectoryFile();
  TDirectoryFile(const char *name, const char *title, Option_t *option="", TDirectory* motherDir = 0);
  virtual ~TDirectoryFile();
  virtual void        Append(TObject *obj, Bool_t replace = kFALSE);
  void        Add(TObject *obj, Bool_t replace = kFALSE) { Append(obj,replace); }
  Int_t       AppendKey(TKey *key);
  virtual void        Browse(TBrowser *b);
  void        Build(TFile* motherFile = 0, TDirectory* motherDir = 0);
  virtual TObject    *CloneObject(const TObject *obj, Bool_t autoadd = kTRUE);
  virtual void        Close(Option_t *option="");
  virtual void        Copy(TObject &) const { MayNotUse("Copy(TObject &)"); }
  virtual Bool_t      cd(const char *path = 0);
  virtual void        Delete(const char *namecycle="");
  virtual void        FillBuffer(char *&buffer);
  virtual TKey       *FindKey(const char *keyname) const;
  virtual TKey       *FindKeyAny(const char *keyname) const;
  virtual TObject    *FindObjectAny(const char *name) const;
  virtual TObject    *FindObjectAnyFile(const char *name) const;
  virtual TObject    *Get(const char *namecycle);
  virtual TDirectory *GetDirectory(const char *apath, Bool_t printError = false, const char *funcname = "GetDirectory");
  template <class T> inline void GetObject(const char* namecycle, T*& ptr) // See TDirectory::Get for information
  {
    ptr = (T*)GetObjectChecked(namecycle,TBuffer::GetClass(typeid(T)));
  }
  virtual void       *GetObjectChecked(const char *namecycle, const char* classname);
  virtual void       *GetObjectChecked(const char *namecycle, const TClass* cl);
  virtual void       *GetObjectUnchecked(const char *namecycle);
  virtual Int_t       GetBufferSize() const;
  const TDatime      &GetCreationDate() const { return fDatimeC; }
  virtual TFile      *GetFile() const { return fFile; }
  virtual TKey       *GetKey(const char *name, Short_t cycle=9999) const;
  virtual TList      *GetListOfKeys() const { return fKeys; }
  const TDatime      &GetModificationDate() const { return fDatimeM; }
  virtual Int_t       GetNbytesKeys() const { return fNbytesKeys; }
  virtual Int_t       GetNkeys() const { return fKeys->GetSize(); }
  virtual Long64_t    GetSeekDir() const { return fSeekDir; }
  virtual Long64_t    GetSeekParent() const { return fSeekParent; }
  virtual Long64_t    GetSeekKeys() const { return fSeekKeys; }
  Bool_t              IsModified() const { return fModified; }
  Bool_t              IsWritable() const { return fWritable; }
  virtual void        ls(Option_t *option="") const;
  virtual TDirectory *mkdir(const char *name, const char *title="");
  virtual TFile      *OpenFile(const char *name, Option_t *option= "",
                               const char *ftitle = "", Int_t compress = 1,
                               Int_t netopt = 0);
  virtual void        Purge(Short_t nkeep=1);
  virtual void        ReadAll(Option_t *option="");
  virtual Int_t       ReadKeys(Bool_t forceRead=kTRUE);
  virtual Int_t       ReadTObject(TObject *obj, const char *keyname);
  virtual void        ResetAfterMerge(TFileMergeInfo *);
  virtual void        rmdir(const char *name);
  virtual void        Save();
  virtual void        SaveSelf(Bool_t force = kFALSE);
  virtual Int_t       SaveObjectAs(const TObject *obj, const char *filename="", Option_t *option="") const;
  virtual void        SetBufferSize(Int_t bufsize);
  void                SetModified() {fModified = kTRUE;}
  void                SetSeekDir(Long64_t v) { fSeekDir = v; }
  virtual void        SetTRefAction(TObject *ref, TObject *parent);
  void                SetWritable(Bool_t writable=kTRUE);
  virtual Int_t       Sizeof() const;
  virtual Int_t       Write(const char *name=0, Int_t opt=0, Int_t bufsize=0);
  virtual Int_t       Write(const char *name=0, Int_t opt=0, Int_t bufsize=0) const ;
  virtual Int_t       WriteTObject(const TObject *obj, const char *name=0, Option_t *option="", Int_t bufsize=0);
  virtual Int_t       WriteObjectAny(const void *obj, const char *classname, const char *name, Option_t *option="", Int_t bufsize=0);
  virtual Int_t       WriteObjectAny(const void *obj, const TClass *cl, const char *name, Option_t *option="", Int_t bufsize=0);
  virtual void        WriteDirHeader();
  virtual void        WriteKeys();
};


class TFile : public TDirectoryFile {
public:
  %rename(KAOSNotAsync) kAOSNotAsync;
  %rename(KAOSFailure) kAOSFailure;
  %rename(KAOSInProgress) kAOSInProgress;
  %rename(KAOSSuccess) kAOSSuccess;
  
  /// Asynchronous open request status
  enum EAsyncOpenStatus { kAOSNotAsync = -1,  kAOSFailure = 0,
                          kAOSInProgress = 1, kAOSSuccess = 2 };

  %rename(KInstantTimeout) kInstantTimeout;
  %rename(KEternalTimeout) kEternalTimeout;
/// Open timeout constants
  enum EOpenTimeOut { kInstantTimeout = 0, kEternalTimeout = 999999999 };

  %rename(KDisconnect) kDisconnect;
  %rename(KDoNotDisconnect) kDoNotDisconnect;
  /// TTreeCache flushing semantics
  enum ECacheAction { kDisconnect = 0, kDoNotDisconnect = 1 };

public:
  %rename(KBeg) kBeg;
  %rename(KCur) kCur;
  %rename(KEnd) kEnd;
  enum ERelativeTo { kBeg = 0, kCur = 1, kEnd = 2 };

  %rename(KDefault) kDefault;
  %rename(KLocal) kLocal;
  %rename(KNet) kNet;
  %rename(KWeb) kWeb;
  %rename(KFile) kFile;
  %rename(KMerge) kMerge;
  enum EFileType { kDefault = 0, kLocal = 1, kNet = 2, kWeb = 3, kFile = 4, kMerge = 5};

public:
  TFile();
  TFile(const char *fname, Option_t *option="", const char *ftitle="", Int_t compress=1);
  virtual ~TFile();
  virtual void        Close(Option_t *option=""); // *MENU*
  virtual void        Copy(TObject &) const { MayNotUse("Copy(TObject &)"); }
  virtual Bool_t      Cp(const char *dst, Bool_t progressbar = kTRUE,UInt_t buffersize = 1000000);
  virtual TKey*       CreateKey(TDirectory* mother, const TObject* obj, const char* name, Int_t bufsize);
  virtual TKey*       CreateKey(TDirectory* mother, const void* obj, const TClass* cl,
                                const char* name, Int_t bufsize);
  static TFile      *&CurrentFile(); // Return the current file for this thread.
  virtual void        Delete(const char *namecycle="");
  virtual void        Draw(Option_t *option="");
  virtual void        DrawMap(const char *keys="*",Option_t *option=""); // *MENU*
  virtual void        FillBuffer(char *&buffer);
  virtual void        Flush();
  TArchiveFile       *GetArchive() const { return fArchive; }
  Long64_t            GetArchiveOffset() const { return fArchiveOffset; }
  Int_t               GetBestBuffer() const;
  virtual Int_t       GetBytesToPrefetch() const;
  TFileCacheRead     *GetCacheRead(TObject* tree = 0) const;
  TFileCacheWrite    *GetCacheWrite() const;
  TArrayC            *GetClassIndex() const { return fClassIndex; }
  Int_t               GetCompressionAlgorithm() const;
  Int_t               GetCompressionLevel() const;
  Int_t               GetCompressionSettings() const;
  Float_t             GetCompressionFactor();
  virtual Long64_t    GetEND() const { return fEND; }
  virtual Int_t       GetErrno() const;
  virtual void        ResetErrno() const;
  Int_t               GetFd() const { return fD; }
  virtual const TUrl *GetEndpointUrl() const { return &fUrl; }
  TObjArray          *GetListOfProcessIDs() const {return fProcessIDs;}
  TList              *GetListOfFree() const { return fFree; }
  virtual Int_t       GetNfree() const { return fFree->GetSize(); }
  virtual Int_t       GetNProcessIDs() const { return fNProcessIDs; }
  Option_t           *GetOption() const { return fOption.Data(); }
  virtual Long64_t    GetBytesRead() const { return fBytesRead; }
  virtual Long64_t    GetBytesReadExtra() const { return fBytesReadExtra; }
  virtual Long64_t    GetBytesWritten() const;
  virtual Int_t       GetReadCalls() const { return fReadCalls; }
  Int_t               GetVersion() const { return fVersion; }
  Int_t               GetRecordHeader(char *buf, Long64_t first, Int_t maxbytes,
                                      Int_t &nbytes, Int_t &objlen, Int_t &keylen);
  virtual Int_t       GetNbytesInfo() const {return fNbytesInfo;}
  virtual Int_t       GetNbytesFree() const {return fNbytesFree;}
  virtual TString     GetNewUrl() { return ""; }
  Long64_t            GetRelOffset() const { return fOffset - fArchiveOffset; }
  virtual Long64_t    GetSeekFree() const {return fSeekFree;}
  virtual Long64_t    GetSeekInfo() const {return fSeekInfo;}
  virtual Long64_t    GetSize() const;
  virtual TList      *GetStreamerInfoList();
  const   TList      *GetStreamerInfoCache();
  virtual void        IncrementProcessIDs() { fNProcessIDs++; }
  virtual Bool_t      IsArchive() const { return fIsArchive; }
  Bool_t      IsBinary() const { return TestBit(kBinaryFile); }
  Bool_t      IsRaw() const { return !fIsRootFile; }
  virtual Bool_t      IsOpen() const;
  virtual void        ls(Option_t *option="") const;
  virtual void        MakeFree(Long64_t first, Long64_t last);
  virtual void        MakeProject(const char *dirname, const char *classes="*",
                                  Option_t *option="new"); // *MENU*
  virtual void        Map(); // *MENU*
  virtual Bool_t      Matches(const char *name);
  virtual Bool_t      MustFlush() const {return fMustFlush;}
  virtual void        Paint(Option_t *option="");
  virtual void        Print(Option_t *option="") const;
  virtual Bool_t      ReadBufferAsync(Long64_t offs, Int_t len);
  virtual Bool_t      ReadBuffer(char *buf, Int_t len);
  virtual Bool_t      ReadBuffer(char *buf, Long64_t pos, Int_t len);
  virtual Bool_t      ReadBuffers(char *buf, Long64_t *pos, Int_t *len, Int_t nbuf);
  virtual void        ReadFree();
  virtual TProcessID *ReadProcessID(UShort_t pidf);
  virtual void        ReadStreamerInfo();
  virtual Int_t       Recover();
  virtual Int_t       ReOpen(Option_t *mode);
  virtual void        Seek(Long64_t offset, ERelativeTo pos = kBeg);
  virtual void        SetCacheRead(TFileCacheRead *cache, TObject* tree = 0, ECacheAction action = kDisconnect);
  virtual void        SetCacheWrite(TFileCacheWrite *cache);
  virtual void        SetCompressionAlgorithm(Int_t algorithm=0);
  virtual void        SetCompressionLevel(Int_t level=1);
  virtual void        SetCompressionSettings(Int_t settings=1);
  virtual void        SetEND(Long64_t last) { fEND = last; }
  virtual void        SetOffset(Long64_t offset, ERelativeTo pos = kBeg);
  virtual void        SetOption(Option_t *option=">") { fOption = option; }
  virtual void        SetReadCalls(Int_t readcalls = 0) { fReadCalls = readcalls; }
  virtual void        ShowStreamerInfo();
  virtual Int_t       Sizeof() const;
  void                SumBuffer(Int_t bufsize);
  virtual Bool_t      WriteBuffer(const char *buf, Int_t len);
  virtual Int_t       Write(const char *name=0, Int_t opt=0, Int_t bufsiz=0);
  virtual Int_t       Write(const char *name=0, Int_t opt=0, Int_t bufsiz=0) const;
  virtual void        WriteFree();
  virtual void        WriteHeader();
  virtual UShort_t    WriteProcessID(TProcessID *pid);
  virtual void        WriteStreamerInfo();

  static TFileOpenHandle
  *AsyncOpen(const char *name, Option_t *option = "",
             const char *ftitle = "", Int_t compress = 1,
             Int_t netopt = 0);
  static TFile       *Open(const char *name, Option_t *option = "",
                           const char *ftitle = "", Int_t compress = 1,
                           Int_t netopt = 0);
  static TFile       *Open(TFileOpenHandle *handle);

  static EFileType    GetType(const char *name, Option_t *option = "", TString *prefix = 0);

  static EAsyncOpenStatus GetAsyncOpenStatus(const char *name);
  static EAsyncOpenStatus GetAsyncOpenStatus(TFileOpenHandle *handle);
  static const TUrl  *GetEndpointUrl(const char *name);

  static Long64_t     GetFileBytesRead();
  static Long64_t     GetFileBytesWritten();
  static Int_t        GetFileReadCalls();
  static Int_t        GetReadaheadSize();

  static void         SetFileBytesRead(Long64_t bytes = 0);
  static void         SetFileBytesWritten(Long64_t bytes = 0);
  static void         SetFileReadCalls(Int_t readcalls = 0);
  static void         SetReadaheadSize(Int_t bufsize = 256000);
  static void         SetReadStreamerInfo(Bool_t readinfo=kTRUE);
  static Bool_t       GetReadStreamerInfo();

  static Long64_t     GetFileCounter();
  static void         IncrementFileCounter();

  static Bool_t       SetCacheFileDir(const char *cacheDir, Bool_t operateDisconnected = kTRUE,
                                      Bool_t forceCacheread = kFALSE);
  static const char  *GetCacheFileDir();
  static Bool_t       ShrinkCacheFileDir(Long64_t shrinkSize, Long_t cleanupInteval = 0);
  static Bool_t       Cp(const char *src, const char *dst, Bool_t progressbar = kTRUE,
                         UInt_t buffersize = 1000000);

  static UInt_t       SetOpenTimeout(UInt_t timeout);  // in ms
  static UInt_t       GetOpenTimeout(); // in ms
  static Bool_t       SetOnlyStaged(Bool_t onlystaged);
  static Bool_t       GetOnlyStaged();
};


class TKey : public TNamed {
public:
  TKey();
  TKey(TDirectory* motherDir);
  TKey(TDirectory* motherDir, const TKey &orig, UShort_t pidOffset);
  TKey(const char *name, const char *title, const TClass *cl, Int_t nbytes, TDirectory* motherDir);
  TKey(const TString &name, const TString &title, const TClass *cl, Int_t nbytes, TDirectory* motherDir);
  TKey(const TObject *obj, const char *name, Int_t bufsize, TDirectory* motherDir);
  TKey(const void *obj, const TClass *cl, const char *name, Int_t bufsize, TDirectory* motherDir);
  TKey(Long64_t pointer, Int_t nbytes, TDirectory* motherDir = 0);
  virtual ~TKey();

  virtual void        Browse(TBrowser *b);
  virtual void        Delete(Option_t *option="");
  virtual void        DeleteBuffer();
  virtual void        FillBuffer(char *&buffer);
  virtual const char *GetClassName() const {return fClassName.Data();}
  virtual const char *GetIconName() const;
  virtual const char *GetTitle() const;
  virtual char       *GetBuffer() const {return fBuffer+fKeylen;}
  TBuffer    *GetBufferRef() const {return fBufferRef;}
  Short_t     GetCycle() const;
  const   TDatime    &GetDatime() const   {return fDatime;}
  TFile      *GetFile() const;
  Short_t     GetKeep() const;
  Int_t       GetKeylen() const   {return fKeylen;}
  TDirectory* GetMotherDir() const { return fMotherDir; }
  Int_t       GetNbytes() const   {return fNbytes;}
  Int_t       GetObjlen() const   {return fObjlen;}
  Int_t       GetVersion() const  {return fVersion;}
  virtual Long64_t    GetSeekKey() const  {return fSeekKey;}
  virtual Long64_t    GetSeekPdir() const {return fSeekPdir;}
  virtual ULong_t     Hash() const;
  virtual void        IncrementPidOffset(UShort_t offset);
  Bool_t      IsFolder() const;
  virtual void        Keep();
  virtual void        ls(Option_t *option="") const;
  virtual void        Print(Option_t *option="") const;
  virtual Int_t       Read(TObject *obj);
  virtual TObject    *ReadObj();
  virtual TObject    *ReadObjWithBuffer(char *bufferRead);
  virtual void       *ReadObjectAny(const TClass *expectedClass);
  virtual void        ReadBuffer(char *&buffer);
  void        ReadKeyBuffer(char *&buffer);
  virtual Bool_t      ReadFile();
  virtual void        SetBuffer() { fBuffer = new char[fNbytes];}
  virtual void        SetParent(const TObject *parent);
  void        SetMotherDir(TDirectory* dir) { fMotherDir = dir; }
  virtual Int_t       Sizeof() const;
  virtual Int_t       WriteFile(Int_t cycle=1, TFile* f = 0);
};
