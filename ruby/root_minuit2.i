/**************************************************************************/
/* Minuit2 classes                                                       */
/**************************************************************************/

namespace ROOT {

namespace Math {

class IOptions;

class MinimizerOptions {

public:

  // static methods for setting and retrieving the default options 

  static void SetDefaultMinimizer(const char * type, const char * algo = 0);
  static void SetDefaultErrorDef( double up); 
  static void SetDefaultTolerance(double tol); 
  static void SetDefaultPrecision(double prec); 
  static void SetDefaultMaxFunctionCalls(int maxcall);
  static void SetDefaultMaxIterations(int maxiter);
  static void SetDefaultStrategy(int strat);
  static void SetDefaultPrintLevel(int level);

  static const std::string & DefaultMinimizerType();
  static const std::string & DefaultMinimizerAlgo(); 
  static double DefaultErrorDef();
  static double DefaultTolerance(); 
  static double DefaultPrecision(); 
  static int DefaultMaxFunctionCalls(); 
  static int DefaultMaxIterations(); 
  static int DefaultStrategy(); 
  static int DefaultPrintLevel(); 

  /// retrieve extra options - if not existing create a IOptions 
  static ROOT::Math::IOptions & Default(const char * name);

  // find extra options - return 0 if not existing 
  static ROOT::Math::IOptions * FindDefault(const char * name);

  /// print all the default options for the name given
  static void PrintDefault(const char * name, std::ostream & os = std::cout); 

public:

  // constructor using the default options 
  // pass optionally a pointer to the additional options
  // otehrwise look if they exist for this default minimizer
  // and in that case they are copied in the constructed instance
  MinimizerOptions(IOptions * extraOpts = 0);

  // destructor  
  ~MinimizerOptions();

  // copy constructor 
  MinimizerOptions(const MinimizerOptions & opt);

  /// assignment operators 
  // MinimizerOptions & operator=(const MinimizerOptions & opt);

  /** non-static methods for  retrivieng options */

  /// set print level
  int PrintLevel() const ;

  ///  max number of function calls
  unsigned int MaxFunctionCalls() const ; 

  /// max iterations
  unsigned int MaxIterations() const ; 

  /// strategy
  int Strategy() const ; 

  /// absolute tolerance 
  double Tolerance() const ;

  /// precision in the objective funciton calculation (value <=0 means left to default)
  double Precision() const ;

  /// error definition 
  double ErrorDef() const ;

  /// return extra options (NULL pointer if they are not present)
  IOptions * ExtraOptions() const ;

  /// type of minimizer
  const std::string & MinimizerType() const ;

  /// type of algorithm
  const std::string & MinimizerAlgorithm() const ;

  /// print all the options 
  void Print(std::ostream & os = std::cout) const; 

  /** non-static methods for setting options */

  /// set print level
  void SetPrintLevel(int level) ;

  ///set maximum of function calls 
  void SetMaxFunctionCalls(unsigned int maxfcn) ;

  /// set maximum iterations (one iteration can have many function calls) 
  void SetMaxIterations(unsigned int maxiter) ; 

  /// set the tolerance
  void SetTolerance(double tol) ;

  /// set the precision
  void SetPrecision(double prec) ;

  /// set the strategy
  void SetStrategy(int stra) ;

  /// set error def
  void SetErrorDef(double err) ;

  /// set minimizer type
  void SetMinimizerType(const char * type) ;

  /// set minimizer algorithm
  void SetMinimizerAlgorithm(const char *type) ;

  /// set extra options (in this case pointer is cloned)
  void  SetExtraOptions(const IOptions & opt); 
};

} // end namespace Math


namespace Math { 

/**
   @defgroup MultiMin Multi-dimensional Minimization
   @ingroup NumAlgo

   Classes implementing algorithms for multi-dimensional minimization 
*/



//_______________________________________________________________________________
/** 
    Abstract Minimizer class, defining  the interface for the various minimizer
    (like Minuit2, Minuit, GSL, etc..) 
    Plug-in's exist in ROOT to be able to instantiate the derived classes like 
    ROOT::Math::GSLMinimizer or ROOT::Math::Minuit2Minimizer via the 
    plug-in manager.

    Provides interface for setting the function to be minimized. 
    The function must  implemente the multi-dimensional generic interface
    ROOT::Math::IBaseFunctionMultiDim. 
    If the function provides gradient calculation 
    (implements the ROOT::Math::IGradientFunctionMultiDim interface) this will be 
    used by the Minimizer. 

    It Defines also interface for setting the initial values for the function variables (which are the parameters in 
    of the model function in case of solving for fitting) and especifying their limits. 

    It defines the interface to set and retrieve basic minimization parameters 
    (for specific Minimizer parameters one must use the derived classes). 

    Then it defines the interface to retrieve the result of minimization ( minimum X values, function value, 
    gradient, error on the mimnimum, etc...)

    @ingroup MultiMin
*/

%nodefault;
 
class Minimizer {

public: 
   
  /// reset for consecutive minimizations - implement if needed 
  virtual void Clear() ;

  /// set the function to minimize
  virtual void SetFunction(const ROOT::Math::IMultiGenFunction & func); 

  /// set a function to minimize using gradient 
  virtual void SetFunction(const ROOT::Math::IMultiGradFunction & func); 
   

  /// add variables  . Return number of variables successfully added
  template<class VariableIterator> 
  int SetVariables(const VariableIterator & begin, const VariableIterator & end);

  /// set free variable 
  virtual bool SetVariable(unsigned int ivar, const std::string & name, double val, double step); 
  /// set lower limit variable  (override if minimizer supports them )
  virtual bool SetLowerLimitedVariable(unsigned int  ivar , const std::string & name , double val , double step , double lower );

  /// set upper limit variable (override if minimizer supports them )
  virtual bool SetUpperLimitedVariable(unsigned int ivar , const std::string & name , double val , double step , double upper );

  /// set upper/lower limited variable (override if minimizer supports them )
  virtual bool SetLimitedVariable(unsigned int /* ivar */ , const std::string & /* name */ , double /*val */ , double /* step  */, double /* lower */, double /* upper */);

  /// set fixed variable (override if minimizer supports them )
  virtual bool SetFixedVariable(unsigned int /* ivar */ , const std::string & /* name */ , double /* val */ );

  /// set the value of an existing variable 
  virtual bool SetVariableValue(unsigned int , double ) ;
  /// set the values of all existing variables (array must be dimensioned to the size of the existing parameters)
  virtual bool SetVariableValues(const double * x);

  /// method to perform the minimization
  virtual  bool Minimize();

  /// return minimum function value
  virtual double MinValue() const;

  /// return expected distance reached from the minimum
  virtual double Edm() const; 

  /// return  pointer to X values at the minimum 
  virtual const double *  X() const; 

  /// return pointer to gradient values at the minimum 
  virtual const double *  MinGradient() const;  

  /// number of function calls to reach the minimum 
  virtual unsigned int NCalls() const;    

  /// this is <= Function().NDim() which is the total 
  /// number of variables (free+ constrained ones) 
  virtual unsigned int NDim() const;  

  /// number of free variables (real dimension of the problem) 
  /// this is <= Function().NDim() which is the total 
  virtual unsigned int NFree() const;  

  /// minimizer provides error and error matrix
  virtual bool ProvidesError() const; 

  /// return errors at the minimum 
  virtual const double * Errors() const;

  /** return covariance matrices elements 
      if the variable is fixed the matrix is zero
      The ordering of the variables is the same as in errors
  */ 
  virtual double CovMatrix(unsigned int i, unsigned int j) const;  

  /** 
      Fill the passed array with the  covariance matrix elements 
      if the variable is fixed or const the value is zero. 
      The array will be filled as cov[i *ndim + j]
      The ordering of the variables is the same as in errors and parameter value. 
      This is different from the direct interface of Minuit2 or TMinuit where the 
      values were obtained only to variable parameters
  */ 
  virtual bool GetCovMatrix(double * /*cov*/) const ; 

  /** 
      Fill the passed array with the Hessian matrix elements 
      The Hessian matrix is the matrix of the second derivatives 
      and is the inverse of the covariance matrix
      If the variable is fixed or const the values for that variables are zero. 
      The array will be filled as h[i *ndim + j]
  */ 
  virtual bool GetHessianMatrix(double * /* h */) const ;


  ///return status of covariance matrix 
  /// using Minuit convention ;
  /// Minimizer who implements covariance matrix calculation will re-implement the method
  virtual int CovMatrixStatus() const ;

  /**
     return correlation coefficient between variable i and j.
     If the variable is fixed or const the return value is zero
  */
  virtual double Correlation(unsigned int i, unsigned int j ) const;

  /**
     return global correlation coefficient for variable i
     This is a number between zero and one which gives 
     the correlation between the i-th parameter  and that linear combination of all 
     other parameters which is most strongly correlated with i.
     Minimizer must overload method if implemented 
  */
  virtual double GlobalCC(unsigned int ) const ;

  /**
     minos error for variable i, return false if Minos failed or not supported 
     and the lower and upper errors are returned in errLow and errUp
     An extra flag  specifies if only the lower (runopt=-1) or the upper (runopt=+1) error calculation is run
     (This feature isnot yet implemented)
  */
  virtual bool GetMinosError(unsigned int /* i */, double & errLow, double & errUp, int  = 0);

  /**
     perform a full calculation of the Hessian matrix for error calculation
  */
  virtual bool Hesse() ;

  /**
     scan function minimum for variable i. Variable and function must be set before using Scan 
     Return false if an error or if minimizer does not support this functionality
  */
  virtual bool Scan(unsigned int /* i */, unsigned int & /* nstep */, double * /* x */, double * /* y */, 
                    double /*xmin */ = 0, double /*xmax*/ = 0);

  /**
     find the contour points (xi,xj) of the function for parameter i and j around the minimum
     The contour will be find for value of the function = Min + ErrorUp();
  */
  virtual bool Contour(unsigned int /* i */, unsigned int /* j */, unsigned int &/* np */, 
                       double * /* xi */, double * /* xj */);

  /// return reference to the objective function
  ///virtual const ROOT::Math::IGenFunction & Function() const = 0; 

  /// print the result according to set level (implemented for TMinuit for mantaining Minuit-style printing)
  virtual void PrintResults() ;

  /// get name of variables (override if minimizer support storing of variable names)
  /// return an empty string if variable is not found
  virtual std::string VariableName(unsigned int ) const ;  // return empty string 

  /// get index of variable given a variable given a name
  /// return -1 if variable is not found
  virtual int VariableIndex(const std::string &) const ;
      
  /** minimizer configuration parameters **/

  /// set print level
  int PrintLevel() const ;

  ///  max number of function calls
  unsigned int MaxFunctionCalls() const ; 

  /// max iterations
  unsigned int MaxIterations() const ; 

  /// absolute tolerance 
  double Tolerance() const ;

  /// precision of minimizer in the evaluation of the objective function
  /// ( a value <=0 corresponds to the let the minimizer choose its default one)
  double Precision() const ;
   
  /// strategy 
  int Strategy() const ;

  /// status code of minimizer 
  int Status() const ; 

  /// return the statistical scale used for calculate the error
  /// is typically 1 for Chi2 and 0.5 for likelihood minimization
  double ErrorDef() const ; 

  ///return true if Minimizer has performed a detailed error validation (e.g. run Hesse for Minuit)
  bool IsValidError() const ;

  /// retrieve the minimizer options (implement derived class if needed)
  virtual MinimizerOptions  Options() const;

  /// set print level
  void SetPrintLevel(int level) ;

  ///set maximum of function calls 
  void SetMaxFunctionCalls(unsigned int maxfcn) ;

  /// set maximum iterations (one iteration can have many function calls) 
  void SetMaxIterations(unsigned int maxiter) ; 

  /// set the tolerance
  void SetTolerance(double tol) ;

  /// set in the minimizer the objective function evaluation precision 
  /// ( a value <=0 means the minimizer will choose its optimal value automatically, i.e. default case)
  void SetPrecision(double prec) ;

  ///set the strategy 
  void SetStrategy(int strategyLevel) ;  

  /// set scale for calculating the errors
  void SetErrorDef(double up) ;

  /// flag to check if minimizer needs to perform accurate error analysis (e.g. run Hesse for Minuit)
  void SetValidError(bool on) ; 

  /// set all options in one go
  void SetOptions(const MinimizerOptions & opt);

  /// reset the defaut options (defined in MinimizerOptions)
  void SetDefaultOptions();

}; 

%default;

} // end namespace Math




namespace Minuit2 { 

class ModularFunctionMinimizer; 
class FCNBase; 
class FunctionMinimum;

// enumeration specifying the type of Minuit2 minimizers
%rename(KMigrad) kMigrad;
%rename(KSimplex) kSimplex;
%rename(KCombined) kCombined;
%rename(KScan) kScan;
%rename(KFumili) kFumili;
enum EMinimizerType { 
  kMigrad, 
  kSimplex, 
  kCombined, 
  kScan,
  kFumili
};

}

namespace Minuit2 { 
//_____________________________________________________________________________________________________
/** 
    Minuit2Minimizer class implementing the ROOT::Math::Minimizer interface for 
    Minuit2 minimization algorithm. 
    In ROOT it can be instantiated using the plug-in manager (plug-in "Minuit2")
    Using a string  (used by the plugin manager) or via an enumeration 
    an one can set all the possible minimization algorithms (Migrad, Simplex, Combined, Scan and Fumili).  
*/ 
class Minuit2Minimizer : public ROOT::Math::Minimizer {
public: 

  /** 
      Default constructor
  */ 
  Minuit2Minimizer (ROOT::Minuit2::EMinimizerType type = ROOT::Minuit2::kMigrad); 

  /** 
      Constructor with a char (used by PM) 
  */ 
  Minuit2Minimizer (const char *  type); 

  /** 
      Destructor (no operations)
  */ 
  virtual ~Minuit2Minimizer (); 

public: 

  // clear resources (parameters) for consecutives minimizations
  virtual void Clear();

  /// set the function to minimize
  virtual void SetFunction(const ROOT::Math::IMultiGenFunction & func); 

  /// set gradient the function to minimize
  virtual void SetFunction(const ROOT::Math::IMultiGradFunction & func); 

  /// set free variable 
  virtual bool SetVariable(unsigned int ivar, const std::string & name, double val, double step); 

  /// set lower limit variable  (override if minimizer supports them )
  virtual bool SetLowerLimitedVariable(unsigned int  ivar , const std::string & name , double val , double step , double lower );
  /// set upper limit variable (override if minimizer supports them )
  virtual bool SetUpperLimitedVariable(unsigned int ivar , const std::string & name , double val , double step , double upper ); 
  /// set upper/lower limited variable (override if minimizer supports them )
  virtual bool SetLimitedVariable(unsigned int ivar , const std::string & name , double val , double step , double /* lower */, double /* upper */); 
  /// set fixed variable (override if minimizer supports them )
  virtual bool SetFixedVariable(unsigned int /* ivar */, const std::string & /* name */, double /* val */);  
  /// set variable
  virtual bool SetVariableValue(unsigned int ivar, double val);
  virtual bool SetVariableValues(const double * val);

  /// get name of variables (override if minimizer support storing of variable names)
  virtual std::string VariableName(unsigned int ivar) const;

  /// get index of variable given a variable given a name
  /// return -1 if variable is not found
  virtual int VariableIndex(const std::string & name) const;

  /** 
      method to perform the minimization. 
      Return false in case the minimization did not converge. In this case a 
      status code different than zero is set 
      (retrieved by the derived method Minimizer::Status() )" 
       
      status = 1    : Covariance was made pos defined
      status = 2    : Hesse is invalid
      status = 3    : Edm is above max 
      status = 4    : Reached call limit
      status = 5    : Any other failure 
  */
  virtual  bool Minimize(); 

  /// return minimum function value
  virtual double MinValue() const ; 

  /// return expected distance reached from the minimum
  virtual double Edm() const ;

  /// return  pointer to X values at the minimum 
  virtual const double *  X() const; 
 
  /// return pointer to gradient values at the minimum 
  virtual const double *  MinGradient() const ; // not available in Minuit2 

  /// number of function calls to reach the minimum 
  virtual unsigned int NCalls() const ; 

  /// this is <= Function().NDim() which is the total 
  /// number of variables (free+ constrained ones) 
  virtual unsigned int NDim() const ;   

  /// number of free variables (real dimension of the problem) 
  /// this is <= Function().NDim() which is the total 
  virtual unsigned int NFree() const ;  

  /// minimizer provides error and error matrix
  virtual bool ProvidesError() const ; 

  /// return errors at the minimum 
  virtual const double * Errors() const; 

  /** 
      return covariance matrix elements 
      if the variable is fixed or const the value is zero
      The ordering of the variables is the same as in errors and parameter value. 
      This is different from the direct interface of Minuit2 or TMinuit where the 
      values were obtained only to variable parameters
  */ 
  virtual double CovMatrix(unsigned int i, unsigned int j) const;  


  /** 
      Fill the passed array with the  covariance matrix elements 
      if the variable is fixed or const the value is zero. 
      The array will be filled as cov[i *ndim + j]
      The ordering of the variables is the same as in errors and parameter value. 
      This is different from the direct interface of Minuit2 or TMinuit where the 
      values were obtained only to variable parameters
  */ 
  virtual bool GetCovMatrix(double * cov) const;  

  /** 
      Fill the passed array with the Hessian matrix elements 
      The Hessian matrix is the matrix of the second derivatives 
      and is the inverse of the covariance matrix
      If the variable is fixed or const the values for that variables are zero. 
      The array will be filled as h[i *ndim + j]
  */ 
  virtual bool GetHessianMatrix(double * h) const;  


  /**
     return the status of the covariance matrix 
     status = -1 :  not available (inversion failed or Hesse failed) 
     status =  0 : available but not positive defined
     status =  1 : covariance only approximate
     status =  2 : full matrix but forced pos def 
     status =  3 : full accurate matrix 

  */
  virtual int CovMatrixStatus() const;
  /**
     return correlation coefficient between variable i and j.
     If the variable is fixed or const the return value is zero
  */
  virtual double Correlation(unsigned int i, unsigned int j ) const; 

  /**
     get global correlation coefficient for the variable i. This is a number between zero and one which gives 
     the correlation between the i-th variable  and that linear combination of all other variables which 
     is most strongly correlated with i.
     If the variable is fixed or const the return value is zero
  */
  virtual double GlobalCC(unsigned int i) const;

  /**
     get the minos error for parameter i, return false if Minos failed
     A minimizaiton must be performed befre, return false if no minimization has been done
     In case of Minos failed the status error is updated as following 
     status += 10 * minosStatus where the minos status is:
     status = 1    : maximum number of function calls exceeded when running for lower error
     status = 2    : maximum number of function calls exceeded when running for upper error
     status = 3    : new minimum found when running for lower error
     status = 4    : new minimum found when running for upper error
     status = 5    : any other failure 

  */
  virtual bool GetMinosError(unsigned int i, double & errLow, double & errUp, int = 0); 

  /**
     scan a parameter i around the minimum. A minimization must have been done before, 
     return false if it is not the case
  */
  virtual bool Scan(unsigned int i, unsigned int & nstep, double * x, double * y, double xmin = 0, double xmax = 0); 

  /**
     find the contour points (xi,xj) of the function for parameter i and j around the minimum
     The contour will be find for value of the function = Min + ErrorUp();
  */
  virtual bool Contour(unsigned int i, unsigned int j, unsigned int & npoints, double *xi, double *xj); 

   
  /**
     perform a full calculation of the Hessian matrix for error calculation
     If a valid minimum exists the calculation is done on the minimum point otherwise is performed 
     in the current set values of parameters
     Status code of minimizer is updated according to the following convention (in case Hesse failed)
     status += 100*hesseStatus where hesse status is: 
     status = 1 : hesse failed
     status = 2 : matrix inversion failed
     status = 3 : matrix is not pos defined 
  */
  virtual bool Hesse();


  /// return reference to the objective function
  ///virtual const ROOT::Math::IGenFunction & Function() const; 

  /// print result of minimization
  virtual void PrintResults(); 

}; 

} // end namespace Fit

} // end namespace ROOT


namespace rubyroot {

class Minuit2FunctionMinimizer : public ROOT::Minuit2::Minuit2Minimizer
{
public:
  Minuit2FunctionMinimizer(ROOT::Minuit2::EMinimizerType type=ROOT::Minuit2::kMigrad);
  Minuit2FunctionMinimizer(const char* type);
  virtual ~Minuit2FunctionMinimizer();

  virtual void SetFunctionObject(VALUE func, int nx);
  double GetParameter(int i) const;
  double GetError(int i) const;
};

}
