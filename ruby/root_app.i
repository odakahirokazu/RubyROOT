/**************************************************************************/
/* Application classes                                                    */
/**************************************************************************/


class TApplication : public TObject
{
public:
  TApplication(const char *appClassName, Int_t *argc, char **argv,
               void *options = 0, Int_t numOptions = 0);
  
  virtual void Run(Bool_t retrn = kFALSE);
};


class TRint : public TApplication {
public:
   TRint(const char *appClassName, int *argc, char **argv,
         void *options = 0, int numOptions = 0, Bool_t noLogo = kFALSE);
   virtual             ~TRint();
   virtual void        Run(Bool_t retrn = kFALSE);
};


%inline {
  TApplication* getApplication()
  {
    return gApplication;
  }
}
