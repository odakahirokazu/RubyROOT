/**************************************************************************/
/* Basic classes                                                          */
/**************************************************************************/

class TObject
{
public:
  %rename(KCanDelete) kCanDelete;
  enum EStatusBits {
    kCanDelete
  };
  
public:
  TObject();
  TObject(const TObject &object);
  virtual ~TObject();
  
  virtual void        AppendPad(Option_t *option="");
  virtual void        Browse(TBrowser *b);
  virtual const char *ClassName() const;
  virtual void        Clear(Option_t * /*option*/ ="");
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
  virtual Option_t   *GetOption() const;
  virtual char       *GetObjectInfo(Int_t px, Int_t py) const;
  virtual const char *GetTitle() const;
  virtual Bool_t      HandleTimer(TTimer *timer);
  virtual ULong_t     Hash() const;
  virtual Bool_t      InheritsFrom(const char *classname) const;
  virtual Bool_t      InheritsFrom(const TClass *cl) const;
  virtual void        Inspect() const; // *MENU*
  virtual Bool_t      IsFolder() const;
  virtual Bool_t      IsEqual(const TObject *obj) const;
  virtual Bool_t      IsSortable() const;
  Bool_t      IsOnHeap() const;
  Bool_t      IsZombie() const;
  virtual Bool_t      Notify();
  virtual void        ls(Option_t *option="") const;
  virtual void        Paint(Option_t *option="");
  virtual void        Pop();
  virtual void        Print(Option_t *option="") const;
  virtual Int_t       Read(const char *name);
  virtual void        RecursiveRemove(TObject *obj);
  virtual void        SaveAs(const char *filename="",Option_t *option="") const; // *MENU*
  virtual void        SavePrimitive(ostream &out, Option_t *option = "");
  virtual void        SetDrawOption(Option_t *option="");  // *MENU*
  virtual void        SetUniqueID(UInt_t uid);
  virtual void        UseCurrentStyle();
  virtual Int_t       Write(const char *name=0, Int_t option=0, Int_t bufsize=0);
  virtual Int_t       Write(const char *name=0, Int_t option=0, Int_t bufsize=0) const;

  //----- bit manipulation
  void     SetBit(UInt_t f, Bool_t set);
  void     SetBit(UInt_t f);
  void     ResetBit(UInt_t f);
  Bool_t   TestBit(UInt_t f) const;
  Int_t    TestBits(UInt_t f) const;
  void     InvertBit(UInt_t f);

  void     AbstractMethod(const char *method) const;
  void     MayNotUse(const char *method) const;
  void     Obsolete(const char *method, const char *asOfVers, const char *removedFromVers) const;

  //---- static functions
  static Long_t    GetDtorOnly();
  static void      SetDtorOnly(void *obj);
  static Bool_t    GetObjectStat();
  static void      SetObjectStat(Bool_t stat);
};


class TNamed : public TObject
{
public:
  TNamed();
  TNamed(const char *name, const char *title);
  //// TNamed(const TString &name, const TString &title);
  TNamed(const TNamed &named);
  virtual ~TNamed();
  virtual void     Clear(Option_t *option ="");
  virtual TObject *Clone(const char *newname="") const;
  virtual Int_t    Compare(const TObject *obj) const;
  virtual void     Copy(TObject &named) const;
  virtual void     FillBuffer(char *&buffer);
  virtual const char  *GetName() const;
  virtual const char  *GetTitle() const;
  virtual ULong_t  Hash() const;
  virtual Bool_t   IsSortable() const;
  virtual void     SetName(const char *name); // *MENU*
  virtual void     SetNameTitle(const char *name, const char *title);
  virtual void     SetTitle(const char *title=""); // *MENU*
  virtual void     ls(Option_t *option="") const;
  virtual void     Print(Option_t *option="") const;
  virtual Int_t    Sizeof() const;
};


class TDirectory : public TNamed
{
public:
  /** @class Context
   *
   *  Small helper to keep current directory context.
   *  Automatically reverts to "old" directory
   */
  class TContext;

public:
  TDirectory();
  TDirectory(const char *name, const char *title, Option_t *option="", TDirectory* motherDir = 0);
  virtual ~TDirectory();
  static  void        AddDirectory(Bool_t add=kTRUE);
  static  Bool_t      AddDirectoryStatus();
  virtual void        Append(TObject *obj, Bool_t replace = kFALSE);
  virtual void        Add(TObject *obj, Bool_t replace = kFALSE);
  virtual Int_t       AppendKey(TKey *);
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
  virtual void        Copy(TObject &) const;
  virtual Bool_t      cd(const char *path = 0);
  virtual void        DeleteAll(Option_t *option="");
  virtual void        Delete(const char *namecycle="");
  virtual void        Draw(Option_t *option="");
  virtual TKey       *FindKey(const char * /*keyname*/) const;
  virtual TKey       *FindKeyAny(const char * /*keyname*/) const;
  virtual TObject    *FindObject(const char *name) const;
  virtual TObject    *FindObject(const TObject *obj) const;
  virtual TObject    *FindObjectAny(const char *name) const;
  virtual TObject    *FindObjectAnyFile(const char * /*name*/) const;
  %rename(GetTObject) Get(const char *namecycle);
  virtual TObject    *Get(const char *namecycle);
  virtual TDirectory *GetDirectory(const char *namecycle, Bool_t printError = false, const char *funcname = "GetDirectory");
  template <class T> inline void GetObject(const char* namecycle, T*& ptr);
  virtual void       *GetObjectChecked(const char *namecycle, const char* classname);
  virtual void       *GetObjectChecked(const char *namecycle, const TClass* cl);
  virtual void       *GetObjectUnchecked(const char *namecycle);
  virtual Int_t       GetBufferSize() const;
  virtual TFile      *GetFile() const;
  virtual TKey       *GetKey(const char * /*name */, Short_t /* cycle */=9999) const;
  virtual TList      *GetList() const;
  virtual TList      *GetListOfKeys() const;
  virtual TObject    *GetMother() const;
  virtual TDirectory *GetMotherDir() const;
  virtual Int_t       GetNbytesKeys() const;
  virtual Int_t       GetNkeys() const;
  virtual Long64_t    GetSeekDir() const;
  virtual Long64_t    GetSeekParent() const;
  virtual Long64_t    GetSeekKeys() const;
  virtual const char *GetPathStatic() const;
  virtual const char *GetPath() const;
  TUUID               GetUUID() const;
  virtual Bool_t      IsFolder() const;
  virtual Bool_t      IsModified() const;
  virtual Bool_t      IsWritable() const;
  virtual void        ls(Option_t *option="") const;
  virtual TDirectory *mkdir(const char *name, const char *title="");
  virtual TFile      *OpenFile(const char * /*name*/, Option_t * /*option*/ = "",
                               const char * /*ftitle*/ = "", Int_t /*compress*/ = 1,
                               Int_t /*netopt*/ = 0);
  virtual void        Paint(Option_t *option="");
  virtual void        Print(Option_t *option="") const;
  virtual void        Purge(Short_t /*nkeep*/=1);
  virtual void        pwd() const;
  virtual void        ReadAll(Option_t * /*option*/="");
  virtual Int_t       ReadKeys(Bool_t /*forceRead*/=kTRUE);
  virtual Int_t       ReadTObject(TObject * /*obj*/, const char * /*keyname*/);
  virtual TObject    *Remove(TObject*);
  virtual void        RecursiveRemove(TObject *obj);
  virtual void        rmdir(const char *name);
  virtual void        Save();
  virtual Int_t       SaveObjectAs(const TObject * /*obj*/, const char * /*filename*/="", Option_t * /*option*/="") const;
  virtual void        SaveSelf(Bool_t /*force*/ = kFALSE);
  virtual void        SetBufferSize(Int_t /* bufsize */);
  virtual void        SetModified();
  virtual void        SetMother(TObject *mother);
  virtual void        SetName(const char* newname);
  virtual void        SetTRefAction(TObject * /*ref*/, TObject * /*parent*/);
  virtual void        SetSeekDir(Long64_t);
  virtual void        SetWritable(Bool_t);
  virtual Int_t       Sizeof() const;
  virtual Int_t       Write(const char * /*name*/=0, Int_t /*opt*/=0, Int_t /*bufsize*/=0);
  virtual Int_t       Write(const char * /*name*/=0, Int_t /*opt*/=0, Int_t /*bufsize*/=0) const;
  virtual Int_t       WriteTObject(const TObject *obj, const char *name =0, Option_t * /*option*/="", Int_t /*bufsize*/ =0);
  template <class T> inline Int_t WriteObject(const T* obj, const char* name, Option_t *option="", Int_t bufsize=0);
  virtual Int_t       WriteObjectAny(const void *, const char * /*classname*/, const char * /*name*/, Option_t * /*option*/="", Int_t /*bufsize*/ =0);
  virtual Int_t       WriteObjectAny(const void *, const TClass * /*cl*/, const char * /*name*/, Option_t * /*option*/="", Int_t /*bufsize*/ =0);
  virtual void        WriteDirHeader();
  virtual void        WriteKeys();

  static Bool_t       Cd(const char *path);
  static void         DecodeNameCycle(const char *namecycle, char *name, Short_t &cycle);
  static void         EncodeNameCycle(char *buffer, const char *name, Short_t cycle);
};


%nodefault;
class TROOT : public TDirectory
{
public:
  // TROOT(const char *name, const char *title, VoidFuncPtr_t *initfunc = 0);
  // virtual           ~TROOT();
  void              AddClass(TClass *cl);
  void              AddClassGenerator(TClassGenerator *gen);
  void              Browse(TBrowser *b);
  Bool_t            ClassSaved(TClass *cl);
  void              CloseFiles();
  virtual TObject  *FindObject(const char *name) const;
  virtual TObject  *FindObject(const TObject *obj) const;
  virtual TObject  *FindObjectAny(const char *name) const;
  virtual TObject  *FindObjectAnyFile(const char *name) const;
  TObject          *FindSpecialObject(const char *name, void *&where);
  const char       *FindObjectClassName(const char *name) const;
  const char       *FindObjectPathName(const TObject *obj) const;
  TClass           *FindSTLClass(const char *name, Bool_t load, Bool_t silent = kFALSE) const;
  void              ForceStyle(Bool_t force = kTRUE) ;
  Bool_t            FromPopUp() const ;
  TPluginManager   *GetPluginManager() const ;
  TApplication     *GetApplication() const ;
  TInterpreter     *GetInterpreter() const ;
  TClass           *GetClass(const char *name, Bool_t load = kTRUE, Bool_t silent = kFALSE) const;
  TClass           *GetClass(const type_info &typeinfo, Bool_t load = kTRUE, Bool_t silent = kFALSE) const;
  TColor           *GetColor(Int_t color) const;
  const char       *GetConfigOptions() const ;
  const char       *GetConfigFeatures() const ;
  const char       *GetCutClassName() const ;
  const char       *GetDefCanvasName() const ;
  Bool_t            GetEditHistograms() const ;
  Int_t             GetEditorMode() const ;
  Bool_t            GetForceStyle() const ;
  Int_t             GetBuiltDate() const ;
  Int_t             GetBuiltTime() const ;
  Int_t             GetSvnRevision() const ;
  const char       *GetSvnBranch() const ;
  const char       *GetSvnDate();
  Int_t             GetVersionDate() const ;
  Int_t             GetVersionTime() const ;
  Int_t             GetVersionInt() const ;
  Int_t             GetVersionCode() const ;
  const char       *GetVersion() const ;
  TCollection      *GetListOfClasses() const ;
  TSeqCollection   *GetListOfColors() const ;
  TCollection      *GetListOfTypes(Bool_t load = kFALSE);
  TCollection      *GetListOfGlobals(Bool_t load = kFALSE);
  TCollection      *GetListOfGlobalFunctions(Bool_t load = kFALSE);
  TSeqCollection   *GetListOfClosedObjects() const ;
  TSeqCollection   *GetListOfFiles() const       ;
  TSeqCollection   *GetListOfMappedFiles() const ;
  TSeqCollection   *GetListOfSockets() const     ;
  TSeqCollection   *GetListOfCanvases() const    ;
  TSeqCollection   *GetListOfStyles() const      ;
  TCollection      *GetListOfFunctions() const   ;
  TSeqCollection   *GetListOfGeometries() const  ;
  TSeqCollection   *GetListOfBrowsers() const    ;
  TSeqCollection   *GetListOfSpecials() const    ;
  TSeqCollection   *GetListOfTasks() const       ;
  TSeqCollection   *GetListOfCleanups() const    ;
  TSeqCollection   *GetListOfStreamerInfo() const ;
  TSeqCollection   *GetListOfMessageHandlers() const ;
  TCollection      *GetListOfClassGenerators() const ;
  TSeqCollection   *GetListOfSecContexts() const ;
  TSeqCollection   *GetListOfProofs() const ;
  TSeqCollection   *GetClipboard() const ;
  TSeqCollection   *GetListOfDataSets() const ;
  TList            *GetListOfBrowsables() const ;
  TDataType        *GetType(const char *name, Bool_t load = kFALSE) const;
  TFile            *GetFile() const ;
  TFile            *GetFile(const char *name) const;
  TStyle           *GetStyle(const char *name) const;
  TObject          *GetFunction(const char *name) const;
  TGlobal          *GetGlobal(const char *name, Bool_t load = kFALSE) const;
  TGlobal          *GetGlobal(const TObject *obj, Bool_t load = kFALSE) const;
  TFunction        *GetGlobalFunction(const char *name, const char *params = 0, Bool_t load = kFALSE);
  TFunction        *GetGlobalFunctionWithPrototype(const char *name, const char *proto = 0, Bool_t load = kFALSE);
  TObject          *GetGeometry(const char *name) const;
  const TObject    *GetSelectedPrimitive() const ;
  TVirtualPad      *GetSelectedPad() const ;
  Int_t             GetNclasses() const ;
  Int_t             GetNtypes() const ;
  TFolder          *GetRootFolder() const ;
  TProcessUUID     *GetUUIDs() const ;
  void              Idle(UInt_t idleTimeInSec, const char *command = 0);
  Int_t             IgnoreInclude(const char *fname, const char *expandedfname);
  Bool_t            IsBatch() const ;
  Bool_t            IsExecutingMacro() const ;
  Bool_t            IsFolder() const ;
  Bool_t            IsInterrupted() const ;
  Bool_t            IsEscaped() const ;
  Bool_t            IsLineProcessing() const ;
  Bool_t            IsProofServ() const ;
  void              ls(Option_t *option = "") const;
  Int_t             LoadClass(const char *classname, const char *libname, Bool_t check = kFALSE);
  TClass           *LoadClass(const char *name, Bool_t silent = kFALSE) const;
  Int_t             LoadMacro(const char *filename, Int_t *error = 0, Bool_t check = kFALSE);
  Long_t            Macro(const char *filename, Int_t *error = 0, Bool_t padUpdate = kTRUE);
  TCanvas          *MakeDefCanvas() const;
  void              Message(Int_t id, const TObject *obj);
  Bool_t            MustClean() const ;
  Long_t            ProcessLine(const char *line, Int_t *error = 0);
  Long_t            ProcessLineSync(const char *line, Int_t *error = 0);
  Long_t            ProcessLineFast(const char *line, Int_t *error = 0);
  Bool_t            ReadingObject() const ;
  void              RefreshBrowsers();
  void              RemoveClass(TClass *);
  void              Reset(Option_t *option="");
  void              SaveContext();
  void              SetApplication(TApplication *app) ;
  void              SetBatch(Bool_t batch = kTRUE) ;
  void              SetCutClassName(const char *name = "TCutG");
  void              SetDefCanvasName(const char *name = "c1") ;
  void              SetEditHistograms(Bool_t flag = kTRUE) ;
  void              SetEditorMode(const char *mode = "");
  void              SetExecutingMacro(Bool_t flag = kTRUE) ;
  void              SetFromPopUp(Bool_t flag = kTRUE) ;
  void              SetInterrupt(Bool_t flag = kTRUE) ;
  void              SetEscape(Bool_t flag = kTRUE) ;
  void              SetLineIsProcessing() ;
  void              SetLineHasBeenProcessed() ;
  void              SetReadingObject(Bool_t flag = kTRUE) ;
  void              SetMustClean(Bool_t flag = kTRUE) ;
  void              SetSelectedPrimitive(const TObject *obj) ;
  void              SetSelectedPad(TVirtualPad *pad) ;
  void              SetStyle(const char *stylename = "Default");
  void              Time(Int_t casetime=1) ;
  Int_t             Timer() const ;

  //---- static functions
  static Int_t       DecreaseDirLevel();
  static Int_t       GetDirLevel();
  static const char *GetMacroPath();
  static void        SetMacroPath(const char *newpath);
  static Int_t       IncreaseDirLevel();
  static void        IndentLevel();
  static Bool_t      Initialized();
  static Bool_t      MemCheck();
  static void        SetDirLevel(Int_t level = 0);
  static Int_t       ConvertVersionCode2Int(Int_t code);
  static Int_t       ConvertVersionInt2Code(Int_t v);
  static Int_t       RootVersionCode();
};
%default;


namespace ROOT {
TROOT *GetROOT();
}
