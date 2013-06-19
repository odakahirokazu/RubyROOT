/**************************************************************************/
/* Math
/**************************************************************************/

namespace TMath {

/* ************************* */
/* * Fundamental constants * */
/* ************************* */

inline Double_t Pi()       ;
inline Double_t TwoPi()    ;
inline Double_t PiOver2()  ;
inline Double_t PiOver4()  ;
inline Double_t InvPi()    ;
inline Double_t RadToDeg() ;
inline Double_t DegToRad() ;
inline Double_t Sqrt2()    ;

// e (base of natural log)
inline Double_t E()        ;

// natural log of 10 (to convert log to ln)
inline Double_t Ln10()     ;

// base-10 log of e  (to convert ln to log)
inline Double_t LogE()     ;

// velocity of light
inline Double_t C()        ;        // m s^-1
inline Double_t Ccgs()     ;         // cm s^-1
inline Double_t CUncertainty() ;             // exact

// gravitational constant
inline Double_t G()        ;           // m^3 kg^-1 s^-2
inline Double_t Gcgs()     ;        // cm^3 g^-1 s^-2
inline Double_t GUncertainty() ;

// G over h-bar C
inline Double_t GhbarC()   ;           // (GeV/c^2)^-2
inline Double_t GhbarCUncertainty() ;

// standard acceleration of gravity
inline Double_t Gn()       ;             // m s^-2
inline Double_t GnUncertainty() ;            // exact

// Planck's constant
inline Double_t H()        ;      // J s
inline Double_t Hcgs()     ;         // erg s
inline Double_t HUncertainty() ;

// h-bar (h over 2 pi)
inline Double_t Hbar()     ;     // J s
inline Double_t Hbarcgs()  ;      // erg s
inline Double_t HbarUncertainty() ;

// hc (h * c)
inline Double_t HC()       ;           // J m
inline Double_t HCcgs()    ;     // erg cm

// Boltzmann's constant
inline Double_t K()        ;       // J K^-1
inline Double_t Kcgs()     ;         // erg K^-1
inline Double_t KUncertainty() ;

// Stefan-Boltzmann constant
inline Double_t Sigma()    ;           // W m^-2 K^-4
inline Double_t SigmaUncertainty() ;

// Avogadro constant (Avogadro's Number)
inline Double_t Na()       ;      // mol^-1
inline Double_t NaUncertainty() ;

// universal gas constant (Na * K)
// http://scienceworld.wolfram.com/physics/UniversalGasConstant.html
inline Double_t R()        ;          // J K^-1 mol^-1
inline Double_t RUncertainty() ;

// Molecular weight of dry air
// 1976 US Standard Atmosphere,
// also see http://atmos.nmsu.edu/jsdap/encyclopediawork.html
inline Double_t MWair()    ;             // kg kmol^-1 (or gm mol^-1)

// Dry Air Gas Constant (R / MWair)
// http://atmos.nmsu.edu/education_and_outreach/encyclopedia/gas_constant.htm
inline Double_t Rgair()    ;  // J kg^-1 K^-1

// Euler-Mascheroni Constant
inline Double_t EulerGamma() ;

// Elementary charge
inline Double_t Qe()       ;     // C
inline Double_t QeUncertainty() ;

/* ************************** */
/* * Mathematical Functions * */
/* ************************** */

/* ***************************** */
/* * Trigonometrical Functions * */
/* ***************************** */
inline Double_t Sin(Double_t);
inline Double_t Cos(Double_t);
inline Double_t Tan(Double_t);
inline Double_t SinH(Double_t);
inline Double_t CosH(Double_t);
inline Double_t TanH(Double_t);
inline Double_t ASin(Double_t);
inline Double_t ACos(Double_t);
inline Double_t ATan(Double_t);
inline Double_t ATan2(Double_t, Double_t);
Double_t ASinH(Double_t);
Double_t ACosH(Double_t);
Double_t ATanH(Double_t);
Double_t Hypot(Double_t x, Double_t y);


/* ************************ */
/* * Elementary Functions * */
/* ************************ */
inline Double_t Sqrt(Double_t x);
inline Double_t Ceil(Double_t x);
inline Int_t    CeilNint(Double_t x);
inline Double_t Floor(Double_t x);
inline Int_t    FloorNint(Double_t x);
inline Double_t Exp(Double_t x);
inline Double_t Ldexp(Double_t x, Int_t exp);
Double_t Factorial(Int_t i);
inline Double_t Power(Double_t x, Double_t y);
inline Double_t Power(Double_t x, Int_t y);
inline Double_t Log(Double_t x);
Double_t Log2(Double_t x);
inline Double_t Log10(Double_t x);
Int_t    Nint(Float_t x);
Int_t    Nint(Double_t x);
inline Int_t    Finite(Double_t x);
inline Int_t    IsNaN(Double_t x);

inline Double_t QuietNaN(); 
inline Double_t SignalingNaN(); 
inline Double_t Infinity(); 

template <typename T> 
struct Limits { 
  inline static T Min(); 
  inline static T Max(); 
  inline static T Epsilon(); 
};

// Some integer math
Long_t   Hypot(Long_t x, Long_t y);     // sqrt(px*px + py*py)

// Comparing floating points
inline Bool_t AreEqualAbs(Double_t af, Double_t bf, Double_t epsilon) {
  //return kTRUE if absolute difference between af and bf is less than epsilon
  return TMath::Abs(af-bf) < epsilon;
}
inline Bool_t AreEqualRel(Double_t af, Double_t bf, Double_t relPrec) {
  //return kTRUE if relative difference between af and bf is less than relPrec
  return TMath::Abs(af-bf) <= 0.5*relPrec*(TMath::Abs(af)+TMath::Abs(bf));
}

/* ******************** */
/* * Array Algorithms * */
/* ******************** */

// Min, Max of an array
template <typename T> T MinElement(Long64_t n, const T *a);
template <typename T> T MaxElement(Long64_t n, const T *a);

// Locate Min, Max element number in an array
template <typename T> Long64_t  LocMin(Long64_t n, const T *a);
template <typename Iterator> Iterator LocMin(Iterator first, Iterator last);
template <typename T> Long64_t  LocMax(Long64_t n, const T *a);
template <typename Iterator> Iterator LocMax(Iterator first, Iterator last);

// Binary search
template <typename T> Long64_t BinarySearch(Long64_t n, const T  *array, T value);
template <typename T> Long64_t BinarySearch(Long64_t n, const T **array, T value);
template <typename Iterator, typename Element> Iterator BinarySearch(Iterator first, Iterator last, Element value);

// Hashing
ULong_t Hash(const void *txt, Int_t ntxt);
ULong_t Hash(const char *str);

// Sorting
template <typename Element, typename Index>
void Sort(Index n, const Element* a, Index* index, Bool_t down=kTRUE);
template <typename Iterator, typename IndexIterator>
void SortItr(Iterator first, Iterator last, IndexIterator index, Bool_t down=kTRUE);

void BubbleHigh(Int_t Narr, Double_t *arr1, Int_t *arr2);
void BubbleLow (Int_t Narr, Double_t *arr1, Int_t *arr2);

Bool_t   Permute(Int_t n, Int_t *a); // Find permutations

/* ************************* */
/* * Geometrical Functions * */
/* ************************* */

//Sample quantiles
void      Quantiles(Int_t n, Int_t nprob, Double_t *x, Double_t *quantiles, Double_t *prob,
                    Bool_t isSorted=kTRUE, Int_t *index = 0, Int_t type=7);

// IsInside
template <typename T> Bool_t IsInside(T xp, T yp, Int_t np, T *x, T *y);

// Calculate the Cross Product of two vectors
template <typename T> T *Cross(const T v1[3],const T v2[3], T out[3]);

Float_t   Normalize(Float_t v[3]);  // Normalize a vector
Double_t  Normalize(Double_t v[3]); // Normalize a vector

//Calculate the Normalized Cross Product of two vectors
template <typename T> inline T NormCross(const T v1[3],const T v2[3],T out[3]);

// Calculate a normal vector of a plane
template <typename T> T *Normal2Plane(const T v1[3],const T v2[3],const T v3[3], T normal[3]);

/* ************************ */
/* * Polynomial Functions * */
/* ************************ */

Bool_t    RootsCubic(const Double_t coef[4],Double_t &a, Double_t &b, Double_t &c);

/* *********************** */
/* * Statistic Functions * */
/* *********************** */

Double_t Binomial(Int_t n,Int_t k);  // Calculate the binomial coefficient n over k
Double_t BinomialI(Double_t p, Int_t n, Int_t k);
Double_t BreitWigner(Double_t x, Double_t mean=0, Double_t gamma=1);
Double_t CauchyDist(Double_t x, Double_t t=0, Double_t s=1);
Double_t ChisquareQuantile(Double_t p, Double_t ndf);
Double_t FDist(Double_t F, Double_t N, Double_t M);
Double_t FDistI(Double_t F, Double_t N, Double_t M);
Double_t Gaus(Double_t x, Double_t mean=0, Double_t sigma=1, Bool_t norm=kFALSE);
Double_t KolmogorovProb(Double_t z);
Double_t KolmogorovTest(Int_t na, const Double_t *a, Int_t nb, const Double_t *b, Option_t *option);
Double_t Landau(Double_t x, Double_t mpv=0, Double_t sigma=1, Bool_t norm=kFALSE);
Double_t LandauI(Double_t x);
Double_t LaplaceDist(Double_t x, Double_t alpha=0, Double_t beta=1);
Double_t LaplaceDistI(Double_t x, Double_t alpha=0, Double_t beta=1);
Double_t LogNormal(Double_t x, Double_t sigma, Double_t theta=0, Double_t m=1);
Double_t NormQuantile(Double_t p);
Double_t Poisson(Double_t x, Double_t par);
Double_t PoissonI(Double_t x, Double_t par);
Double_t Prob(Double_t chi2,Int_t ndf);
Double_t Student(Double_t T, Double_t ndf);
Double_t StudentI(Double_t T, Double_t ndf);
Double_t StudentQuantile(Double_t p, Double_t ndf, Bool_t lower_tail=kTRUE);
Double_t Vavilov(Double_t x, Double_t kappa, Double_t beta2);
Double_t VavilovI(Double_t x, Double_t kappa, Double_t beta2);
Double_t Voigt(Double_t x, Double_t sigma, Double_t lg, Int_t r = 4);

/* ************************** */
/* * Statistics over arrays * */
/* ************************** */

//Mean, Geometric Mean, Median, RMS(sigma)

template <typename T> Double_t Mean(Long64_t n, const T *a, const Double_t *w=0);
template <typename Iterator> Double_t Mean(Iterator first, Iterator last);
template <typename Iterator, typename WeightIterator> Double_t Mean(Iterator first, Iterator last, WeightIterator w);

template <typename T> Double_t GeomMean(Long64_t n, const T *a);
template <typename Iterator> Double_t GeomMean(Iterator first, Iterator last);

template <typename T> Double_t RMS(Long64_t n, const T *a);
template <typename Iterator> Double_t RMS(Iterator first, Iterator last);

template <typename T> Double_t StdDev(Long64_t n, const T *a) ;
template <typename Iterator> Double_t StdDev(Iterator first, Iterator last) ;

template <typename T> Double_t Median(Long64_t n, const T *a,  const Double_t *w=0, Long64_t *work=0);

//k-th order statistic
template <class Element, typename Size> Element KOrdStat(Size n, const Element *a, Size k, Size *work = 0);

/* ******************* */
/* * Special Functions */
/* ******************* */

Double_t Beta(Double_t p, Double_t q);
Double_t BetaCf(Double_t x, Double_t a, Double_t b);
Double_t BetaDist(Double_t x, Double_t p, Double_t q);
Double_t BetaDistI(Double_t x, Double_t p, Double_t q);
Double_t BetaIncomplete(Double_t x, Double_t a, Double_t b);

// Bessel functions
Double_t BesselI(Int_t n,Double_t x);  // integer order modified Bessel function I_n(x)
Double_t BesselK(Int_t n,Double_t x);  // integer order modified Bessel function K_n(x)
Double_t BesselI0(Double_t x);         // modified Bessel function I_0(x)
Double_t BesselK0(Double_t x);         // modified Bessel function K_0(x)
Double_t BesselI1(Double_t x);         // modified Bessel function I_1(x)
Double_t BesselK1(Double_t x);         // modified Bessel function K_1(x)
Double_t BesselJ0(Double_t x);         // Bessel function J0(x) for any real x
Double_t BesselJ1(Double_t x);         // Bessel function J1(x) for any real x
Double_t BesselY0(Double_t x);         // Bessel function Y0(x) for positive x
Double_t BesselY1(Double_t x);         // Bessel function Y1(x) for positive x
Double_t StruveH0(Double_t x);         // Struve functions of order 0
Double_t StruveH1(Double_t x);         // Struve functions of order 1
Double_t StruveL0(Double_t x);         // Modified Struve functions of order 0
Double_t StruveL1(Double_t x);         // Modified Struve functions of order 1

Double_t DiLog(Double_t x);
Double_t Erf(Double_t x);
Double_t ErfInverse(Double_t x);
Double_t Erfc(Double_t x);
Double_t ErfcInverse(Double_t x);
Double_t Freq(Double_t x);
Double_t Gamma(Double_t z);
Double_t Gamma(Double_t a,Double_t x);
Double_t GammaDist(Double_t x, Double_t gamma, Double_t mu=0, Double_t beta=1);
Double_t LnGamma(Double_t z);
}
