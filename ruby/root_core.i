/**************************************************************************/
/* Basic classes                                                          */
/**************************************************************************/

class TObject {
protected:
  void MakeZombie();
  virtual void DoError(int level, const char *location, const char *fmt, va_list va) const;

public:
  TObject();
  TObject(const TObject &object);
  virtual ~TObject();

  virtual void        AppendPad(Option_t *option="");
  virtual void        Browse(TBrowser *b);
  virtual const char *ClassName() const;
  virtual void        Clear(Option_t * /*option*/ ="") { }
  virtual TObject    *Clone(const char *newname="") const;
  virtual Int_t       Compare(const TObject *obj) const;
  virtual void        Copy(TObject &object) const;
  virtual void        Delete(Option_t *option=""); // *MENU*
  virtual Int_t       DistancetoPrimitive(Int_t px, Int_t py);
  virtual void        Draw(Option_t *option="");
  virtual void        DrawClass() const; // *MENU*
  virtual TObject    *DrawClone(Option_t *option="") const; // *MENU*
  virtual void        Dump() const; // *MENU*
  virtual void        Execute(const char *method,  const char *params, Int_t *error=0);
  virtual void        Execute(TMethod *method, TObjArray *params, Int_t *error=0);
  virtual void        ExecuteEvent(Int_t event, Int_t px, Int_t py);
  virtual TObject    *FindObject(const char *name) const;
  virtual TObject    *FindObject(const TObject *obj) const;
  virtual Option_t   *GetDrawOption() const;
  virtual UInt_t      GetUniqueID() const;
  virtual const char *GetName() const;
  virtual const char *GetIconName() const;
  virtual Option_t   *GetOption() const { return ""; }
  virtual char       *GetObjectInfo(Int_t px, Int_t py) const;
  virtual const char *GetTitle() const;
  virtual Bool_t      HandleTimer(TTimer *timer);
  virtual ULong_t     Hash() const;
  virtual Bool_t      InheritsFrom(const char *classname) const;
  virtual Bool_t      InheritsFrom(const TClass *cl) const;
  virtual void        Inspect() const; // *MENU*
  virtual Bool_t      IsFolder() const;
  virtual Bool_t      IsEqual(const TObject *obj) const;
  virtual Bool_t      IsSortable() const { return kFALSE; }
  Bool_t      IsOnHeap() const { return TestBit(kIsOnHeap); }
  Bool_t      IsZombie() const { return TestBit(kZombie); }
  virtual Bool_t      Notify();
  virtual void        ls(Option_t *option="") const;
  virtual void        Paint(Option_t *option="");
  virtual void        Pop();
  virtual void        Print(Option_t *option="") const;
  virtual Int_t       Read(const char *name);
  virtual void        RecursiveRemove(TObject *obj);
  virtual void        SaveAs(const char *filename="",Option_t *option="") const; // *MENU*
  virtual void        SavePrimitive(std::ostream &out, Option_t *option = "");
  virtual void        SetDrawOption(Option_t *option="");  // *MENU*
  virtual void        SetUniqueID(UInt_t uid);
  virtual void        UseCurrentStyle();
  virtual Int_t       Write(const char *name=0, Int_t option=0, Int_t bufsize=0);
  virtual Int_t       Write(const char *name=0, Int_t option=0, Int_t bufsize=0) const;
  
  //----- bit manipulation
  void     SetBit(UInt_t f, Bool_t set);
  void     SetBit(UInt_t f) { fBits |= f & kBitMask; }
  void     ResetBit(UInt_t f) { fBits &= ~(f & kBitMask); }
  Bool_t   TestBit(UInt_t f) const { return (Bool_t) ((fBits & f) != 0); }
  Int_t    TestBits(UInt_t f) const { return (Int_t) (fBits & f); }
  void     InvertBit(UInt_t f) { fBits ^= f & kBitMask; }
  
  void     AbstractMethod(const char *method) const;
  void     MayNotUse(const char *method) const;
  void     Obsolete(const char *method, const char *asOfVers, const char *removedFromVers) const;

  //---- static functions
  static Long_t    GetDtorOnly();
  static void      SetDtorOnly(void *obj);
  static Bool_t    GetObjectStat();
  static void      SetObjectStat(Bool_t stat);
};

class TNamed : public TObject {
public:
  TNamed(): fName(), fTitle() { }
  TNamed(const char *name, const char *title) : fName(name), fTitle(title) { }
  TNamed(const TString &name, const TString &title) : fName(name), fTitle(title) { }
  TNamed(const TNamed &named);

  virtual ~TNamed() { }
  virtual void     Clear(Option_t *option ="");
  virtual TObject *Clone(const char *newname="") const;
  virtual Int_t    Compare(const TObject *obj) const;
  virtual void     Copy(TObject &named) const;
  virtual void     FillBuffer(char *&buffer);
  virtual const char  *GetName() const { return fName; }
  virtual const char  *GetTitle() const { return fTitle; }
  virtual ULong_t  Hash() const { return fName.Hash(); }
  virtual Bool_t   IsSortable() const { return kTRUE; }
  virtual void     SetName(const char *name); // *MENU*
  virtual void     SetNameTitle(const char *name, const char *title);
  virtual void     SetTitle(const char *title=""); // *MENU*
  virtual void     ls(Option_t *option="") const;
  virtual void     Print(Option_t *option="") const;
  virtual Int_t    Sizeof() const;
};


class TDirectory : public TNamed {
protected:
  TDirectory(const TDirectory &directory);  //Directories cannot be copied

public:
  TDirectory();
  TDirectory(const char *name, const char *title, Option_t *option="", TDirectory* motherDir = 0);
  virtual ~TDirectory();
  static  void        AddDirectory(Bool_t add=kTRUE);
  static  Bool_t      AddDirectoryStatus();
  virtual void        Append(TObject *obj, Bool_t replace = kFALSE);
  virtual void        Add(TObject *obj, Bool_t replace = kFALSE) { Append(obj,replace); }
  virtual Int_t       AppendKey(TKey *) {return 0;}
  virtual void        Browse(TBrowser *b);
  virtual void        Build(TFile* motherFile = 0, TDirectory* motherDir = 0);
  virtual void        Clear(Option_t *option="");
  virtual TObject    *CloneObject(const TObject *obj, Bool_t autoadd = kTRUE);
  virtual void        Close(Option_t *option="");

  // static TDirectory *&CurrentDirectory();  // Return the current directory for this thread.
  %extend {
    static TDirectory* CurrentDirectory()
    {
      TDirectory* dir = 0;
      dir = TDirectory::CurrentDirectory();
      return dir;
    }
  }

  virtual void        Copy(TObject &) const { MayNotUse("Copy(TObject &)"); }
  virtual Bool_t      cd(const char *path = 0);
  virtual void        DeleteAll(Option_t *option="");
  virtual void        Delete(const char *namecycle="");
  virtual void        Draw(Option_t *option="");
  virtual TKey       *FindKey(const char * /*keyname*/) const {return 0;}
  virtual TKey       *FindKeyAny(const char * /*keyname*/) const {return 0;}
  virtual TObject    *FindObject(const char *name) const;
  virtual TObject    *FindObject(const TObject *obj) const;
  virtual TObject    *FindObjectAny(const char *name) const;
  virtual TObject    *FindObjectAnyFile(const char * /*name*/) const {return 0;}
  virtual TObject    *Get(const char *namecycle);
  virtual TDirectory *GetDirectory(const char *namecycle, Bool_t printError = false, const char *funcname = "GetDirectory");

  %rename(GetTObject) Get(const char *namecycle);

  template <class T> inline void GetObject(const char* namecycle, T*& ptr) // See TDirectory::Get for information
  {
    ptr = (T*)GetObjectChecked(namecycle,TBuffer::GetClass(typeid(T)));
  }
  virtual void       *GetObjectChecked(const char *namecycle, const char* classname);
  virtual void       *GetObjectChecked(const char *namecycle, const TClass* cl);
  virtual void       *GetObjectUnchecked(const char *namecycle);
  virtual Int_t       GetBufferSize() const {return 0;}
  virtual TFile      *GetFile() const { return 0; }
  virtual TKey       *GetKey(const char * /*name */, Short_t /* cycle */=9999) const {return 0;}
  virtual TList      *GetList() const { return fList; }
  virtual TList      *GetListOfKeys() const { return 0; }
  virtual TObject    *GetMother() const { return fMother; }
  virtual TDirectory *GetMotherDir() const { return fMother==0 ? 0 : dynamic_cast<TDirectory*>(fMother); }
  virtual Int_t       GetNbytesKeys() const { return 0; }
  virtual Int_t       GetNkeys() const { return 0; }
  virtual Long64_t    GetSeekDir() const { return 0; }
  virtual Long64_t    GetSeekParent() const { return 0; }
  virtual Long64_t    GetSeekKeys() const { return 0; }
  virtual const char *GetPathStatic() const;
  virtual const char *GetPath() const;
  TUUID               GetUUID() const {return fUUID;}
  virtual Bool_t      IsFolder() const { return kTRUE; }
  virtual Bool_t      IsModified() const { return kFALSE; }
  virtual Bool_t      IsWritable() const { return kFALSE; }
  virtual void        ls(Option_t *option="") const;
  virtual TDirectory *mkdir(const char *name, const char *title="");
  virtual TFile      *OpenFile(const char * /*name*/, Option_t * /*option*/ = "",
                               const char * /*ftitle*/ = "", Int_t /*compress*/ = 1,
                               Int_t /*netopt*/ = 0) {return 0;}
  virtual void        Paint(Option_t *option="");
  virtual void        Print(Option_t *option="") const;
  virtual void        Purge(Short_t /*nkeep*/=1) {}
  virtual void        pwd() const;
  virtual void        ReadAll(Option_t * /*option*/="") {}
  virtual Int_t       ReadKeys(Bool_t /*forceRead*/=kTRUE) {return 0;}
  virtual Int_t       ReadTObject(TObject * /*obj*/, const char * /*keyname*/) {return 0;}
  virtual TObject    *Remove(TObject*);
  virtual void        RecursiveRemove(TObject *obj);
  virtual void        rmdir(const char *name);
  virtual void        Save() {}
  virtual Int_t       SaveObjectAs(const TObject * /*obj*/, const char * /*filename*/="", Option_t * /*option*/="") const;
  virtual void        SaveSelf(Bool_t /*force*/ = kFALSE) {}
  virtual void        SetBufferSize(Int_t /* bufsize */) {}
  virtual void        SetModified() {}
  virtual void        SetMother(TObject *mother) {fMother = (TObject*)mother;}
  virtual void        SetName(const char* newname);
  virtual void        SetTRefAction(TObject * /*ref*/, TObject * /*parent*/) {}
  virtual void        SetSeekDir(Long64_t) {}
  virtual void        SetWritable(Bool_t) {}
  virtual Int_t       Sizeof() const {return 0;}
  virtual Int_t       Write(const char * /*name*/=0, Int_t /*opt*/=0, Int_t /*bufsize*/=0){return 0;}
  virtual Int_t       Write(const char * /*name*/=0, Int_t /*opt*/=0, Int_t /*bufsize*/=0) const {return 0;}
  virtual Int_t       WriteTObject(const TObject *obj, const char *name =0, Option_t * /*option*/="", Int_t /*bufsize*/ =0);
private:
  Int_t       WriteObject(void *obj, const char* name, Option_t *option="", Int_t bufsize=0); // Intentionaly not implemented.
public:
  template <class T> inline Int_t WriteObject(const T* obj, const char* name, Option_t *option="", Int_t bufsize=0) // see TDirectory::WriteTObject or TDirectoryWriteObjectAny for explanation
  {
    return WriteObjectAny(obj,TBuffer::GetClass(typeid(T)),name,option,bufsize);
  }
  virtual Int_t       WriteObjectAny(const void *, const char * /*classname*/, const char * /*name*/, Option_t * /*option*/="", Int_t /*bufsize*/ =0) {return 0;}
  virtual Int_t       WriteObjectAny(const void *, const TClass * /*cl*/, const char * /*name*/, Option_t * /*option*/="", Int_t /*bufsize*/ =0) {return 0;}
  virtual void        WriteDirHeader() {}
  virtual void        WriteKeys() {}

  static Bool_t       Cd(const char *path);
  // static void         DecodeNameCycle(const char *namecycle, char *name, Short_t &cycle, const size_t namesize = 0);
  // static void         EncodeNameCycle(char *buffer, const char *name, Short_t cycle);
};

%nodefault;
class TROOT : public TDirectory {
public:
  // TROOT(const char *name, const char *title, VoidFuncPtr_t *initfunc = 0);
  virtual           ~TROOT();
  void              AddClass(TClass *cl);
  void              AddClassGenerator(TClassGenerator *gen);
  void              Browse(TBrowser *b);
  Bool_t            ClassSaved(TClass *cl);
  void              CloseFiles();
  void              EndOfProcessCleanups();
  virtual TObject  *FindObject(const char *name) const;
  virtual TObject  *FindObject(const TObject *obj) const;
  virtual TObject  *FindObjectAny(const char *name) const;
  virtual TObject  *FindObjectAnyFile(const char *name) const;
  TObject          *FindSpecialObject(const char *name, void *&where);
  const char       *FindObjectClassName(const char *name) const;
  const char       *FindObjectPathName(const TObject *obj) const;
  TClass           *FindSTLClass(const char *name, Bool_t load, Bool_t silent = kFALSE) const;
  void              ForceStyle(Bool_t force = kTRUE) { fForceStyle = force; }
  Bool_t            FromPopUp() const { return fFromPopUp; }
  TPluginManager   *GetPluginManager() const { return fPluginManager; }
  TApplication     *GetApplication() const { return fApplication; }
  TInterpreter     *GetInterpreter() const { return fInterpreter; }
  TClass           *GetClass(const char *name, Bool_t load = kTRUE, Bool_t silent = kFALSE) const;
  TClass           *GetClass(const std::type_info &typeinfo, Bool_t load = kTRUE, Bool_t silent = kFALSE) const;
  TColor           *GetColor(Int_t color) const;
  const char       *GetConfigOptions() const { return fConfigOptions; }
  const char       *GetConfigFeatures() const { return fConfigFeatures; }
  const char       *GetCutClassName() const { return fCutClassName; }
  const char       *GetDefCanvasName() const { return fDefCanvasName; }
  Bool_t            GetEditHistograms() const { return fEditHistograms; }
  Int_t             GetEditorMode() const { return fEditorMode; }
  Bool_t            GetForceStyle() const { return fForceStyle; }
  Int_t             GetBuiltDate() const { return fBuiltDate; }
  Int_t             GetBuiltTime() const { return fBuiltTime; }
  const char       *GetGitCommit() const { return fGitCommit; }
  const char       *GetGitBranch() const { return fGitBranch; }
  const char       *GetGitDate();
  Int_t             GetVersionDate() const { return fVersionDate; }
  Int_t             GetVersionTime() const { return fVersionTime; }
  Int_t             GetVersionInt() const { return fVersionInt; }
  Int_t             GetVersionCode() const { return fVersionCode; }
  const char       *GetVersion() const { return fVersion; }
  TCollection      *GetListOfClasses() const { return fClasses; }
  TSeqCollection   *GetListOfColors() const { return fColors; }
  TCollection      *GetListOfTypes(Bool_t load = kFALSE);
  TCollection      *GetListOfGlobals(Bool_t load = kFALSE);
  TCollection      *GetListOfGlobalFunctions(Bool_t load = kFALSE);
  TSeqCollection   *GetListOfClosedObjects() const { return fClosedObjects; }
  TSeqCollection   *GetListOfFiles() const       { return fFiles; }
  TSeqCollection   *GetListOfMappedFiles() const { return fMappedFiles; }
  TSeqCollection   *GetListOfSockets() const     { return fSockets; }
  TSeqCollection   *GetListOfCanvases() const    { return fCanvases; }
  TSeqCollection   *GetListOfStyles() const      { return fStyles; }
  TCollection      *GetListOfFunctions() const   { return fFunctions; }
  TCollection      *GetListOfFunctionOverloads(const char* name) const;
  TSeqCollection   *GetListOfGeometries() const  { return fGeometries; }
  TSeqCollection   *GetListOfBrowsers() const    { return fBrowsers; }
  TSeqCollection   *GetListOfSpecials() const    { return fSpecials; }
  TSeqCollection   *GetListOfTasks() const       { return fTasks; }
  TSeqCollection   *GetListOfCleanups() const    { return fCleanups; }
  TSeqCollection   *GetListOfStreamerInfo() const { return fStreamerInfo; }
  TSeqCollection   *GetListOfMessageHandlers() const { return fMessageHandlers; }
  TCollection      *GetListOfClassGenerators() const { return fClassGenerators; }
  TSeqCollection   *GetListOfSecContexts() const { return fSecContexts; }
  TSeqCollection   *GetListOfProofs() const { return fProofs; }
  TSeqCollection   *GetClipboard() const { return fClipboard; }
  TSeqCollection   *GetListOfDataSets() const { return fDataSets; }
  TCollection      *GetListOfEnums(Bool_t load = kFALSE);
  TCollection      *GetListOfFunctionTemplates();
  TList            *GetListOfBrowsables() const { return fBrowsables; }
  TDataType        *GetType(const char *name, Bool_t load = kFALSE) const;
  TFile            *GetFile() const { if (gDirectory != this) return gDirectory->GetFile(); else return 0;}
  TFile            *GetFile(const char *name) const;
  TFunctionTemplate*GetFunctionTemplate(const char *name);
  TStyle           *GetStyle(const char *name) const;
  TObject          *GetFunction(const char *name) const;
  TGlobal          *GetGlobal(const char *name, Bool_t load = kFALSE) const;
  TGlobal          *GetGlobal(const TObject *obj, Bool_t load = kFALSE) const;
  TFunction        *GetGlobalFunction(const char *name, const char *params = 0, Bool_t load = kFALSE);
  TFunction        *GetGlobalFunctionWithPrototype(const char *name, const char *proto = 0, Bool_t load = kFALSE);
  TObject          *GetGeometry(const char *name) const;
  const TObject    *GetSelectedPrimitive() const { return fPrimitive; }
  TVirtualPad      *GetSelectedPad() const { return fSelectPad; }
  Int_t             GetNclasses() const { return fClasses->GetSize(); }
  Int_t             GetNtypes() const { return fTypes->GetSize(); }
  TFolder          *GetRootFolder() const { return fRootFolder; }
  TProcessUUID     *GetUUIDs() const { return fUUIDs; }
  void              Idle(UInt_t idleTimeInSec, const char *command = 0);
  Int_t             IgnoreInclude(const char *fname, const char *expandedfname);
  Bool_t            IsBatch() const { return fBatch; }
  Bool_t            IsExecutingMacro() const { return fExecutingMacro; }
  Bool_t            IsFolder() const { return kTRUE; }
  Bool_t            IsInterrupted() const { return fInterrupt; }
  Bool_t            IsEscaped() const { return fEscape; }
  Bool_t            IsLineProcessing() const { return fLineIsProcessing ? kTRUE : kFALSE; }
  Bool_t            IsProofServ() const { return fName == "proofserv" ? kTRUE : kFALSE; }
  Bool_t            IsRootFile(const char *filename) const;
  void              ls(Option_t *option = "") const;
  Int_t             LoadClass(const char *classname, const char *libname, Bool_t check = kFALSE);
  TClass           *LoadClass(const char *name, Bool_t silent = kFALSE) const;
  Int_t             LoadMacro(const char *filename, Int_t *error = 0, Bool_t check = kFALSE);
  Long_t            Macro(const char *filename, Int_t *error = 0, Bool_t padUpdate = kTRUE);
  TCanvas          *MakeDefCanvas() const;
  void              Message(Int_t id, const TObject *obj);
  Bool_t            MustClean() const { return fMustClean; }
  Long_t            ProcessLine(const char *line, Int_t *error = 0);
  Long_t            ProcessLineSync(const char *line, Int_t *error = 0);
  Long_t            ProcessLineFast(const char *line, Int_t *error = 0);
  Bool_t            ReadingObject() const;
  void              RefreshBrowsers();
  //  static void       RegisterModule();
  void              RemoveClass(TClass *);
  void              Reset(Option_t *option="");
  void              SaveContext();
  void              SetApplication(TApplication *app) { fApplication = app; }
  void              SetBatch(Bool_t batch = kTRUE) { fBatch = batch; }
  void              SetCutClassName(const char *name = "TCutG");
  void              SetDefCanvasName(const char *name = "c1") { fDefCanvasName = name; }
  void              SetEditHistograms(Bool_t flag = kTRUE) { fEditHistograms = flag; }
  void              SetEditorMode(const char *mode = "");
  void              SetExecutingMacro(Bool_t flag = kTRUE) { fExecutingMacro = flag; }
  void              SetFromPopUp(Bool_t flag = kTRUE) { fFromPopUp = flag; }
  void              SetInterrupt(Bool_t flag = kTRUE) { fInterrupt = flag; }
  void              SetEscape(Bool_t flag = kTRUE) { fEscape = flag; }
  void              SetLineIsProcessing() { fLineIsProcessing++; }
  void              SetLineHasBeenProcessed() { if (fLineIsProcessing) fLineIsProcessing--; }
  void              SetReadingObject(Bool_t flag = kTRUE);
  void              SetMustClean(Bool_t flag = kTRUE) { fMustClean=flag; }
  void              SetSelectedPrimitive(const TObject *obj) { fPrimitive = obj; }
  void              SetSelectedPad(TVirtualPad *pad) { fSelectPad = pad; }
  void              SetStyle(const char *stylename = "Default");
  void              Time(Int_t casetime=1) { fTimer = casetime; }
  Int_t             Timer() const { return fTimer; }

  //---- static functions
  static Int_t       DecreaseDirLevel();
  static Int_t       GetDirLevel();
  static const char *GetMacroPath();
  static void        SetMacroPath(const char *newpath);
  static Int_t       IncreaseDirLevel();
  static void        IndentLevel();
  static Bool_t      Initialized();
  // static Bool_t      MemCheck();
  static void        SetDirLevel(Int_t level = 0);
  static Int_t       ConvertVersionCode2Int(Int_t code);
  static Int_t       ConvertVersionInt2Code(Int_t v);
  static Int_t       RootVersionCode();
  static const char**&GetExtraInterpreterArgs();
  static const char *GetTutorialsDir();
};
%default;

namespace ROOT {
TROOT *GetROOT();
}
