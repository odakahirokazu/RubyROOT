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

%inline {
  TApplication* getApplication()
  {
    return gApplication;
  }
}
