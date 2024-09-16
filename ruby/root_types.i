/**************************************************************************/
/* Definitions of ROOT types                                              */
/**************************************************************************/

// Begin copy from RtypesCore.h

//---- types -------------------------------------------------------------------

typedef char           Char_t;      //Signed Character 1 byte (char)
typedef unsigned char  UChar_t;     //Unsigned Character 1 byte (unsigned char)
typedef short          Short_t;     //Signed Short integer 2 bytes (short)
typedef unsigned short UShort_t;    //Unsigned Short integer 2 bytes (unsigned short)
#ifdef R__INT16
typedef long           Int_t;       //Signed integer 4 bytes
typedef unsigned long  UInt_t;      //Unsigned integer 4 bytes
#else
typedef int            Int_t;       //Signed integer 4 bytes (int)
typedef unsigned int   UInt_t;      //Unsigned integer 4 bytes (unsigned int)
#endif
#ifdef R__B64    // Note: Long_t and ULong_t are currently not portable types
typedef int            Seek_t;      //File pointer (int)
typedef long           Long_t;      //Signed long integer 8 bytes (long)
typedef unsigned long  ULong_t;     //Unsigned long integer 8 bytes (unsigned long)
#else
typedef int            Seek_t;      //File pointer (int)
typedef long           Long_t;      //Signed long integer 4 bytes (long)
typedef unsigned long  ULong_t;     //Unsigned long integer 4 bytes (unsigned long)
#endif
typedef float          Float_t;     //Float 4 bytes (float)
typedef float          Float16_t;   //Float 4 bytes written with a truncated mantissa
typedef double         Double_t;    //Double 8 bytes
typedef double         Double32_t;  //Double 8 bytes in memory, written as a 4 bytes float
typedef long double    LongDouble_t;//Long Double
typedef char           Text_t;      //General string (char)
typedef bool           Bool_t;      //Boolean (0=false, 1=true) (bool)
typedef unsigned char  Byte_t;      //Byte (8 bits) (unsigned char)
typedef short          Version_t;   //Class version identifier (short)
typedef const char     Option_t;    //Option string (const char)
typedef int            Ssiz_t;      //String size (int)
typedef float          Real_t;      //TVector and TMatrix element type (float)
#if defined(R__WIN32) && !defined(__CINT__)
typedef __int64          Long64_t;  //Portable signed long integer 8 bytes
typedef unsigned __int64 ULong64_t; //Portable unsigned long integer 8 bytes
#else
typedef long long          Long64_t; //Portable signed long integer 8 bytes
typedef unsigned long long ULong64_t;//Portable unsigned long integer 8 bytes
#endif
typedef double         Axis_t;      //Axis values type (double)
typedef double         Stat_t;      //Statistics type (double)

typedef short          Font_t;      //Font number (short)
typedef short          Style_t;     //Style number (short)
typedef short          Marker_t;    //Marker number (short)
typedef short          Width_t;     //Line width (short)
typedef short          Color_t;     //Color number (short)
typedef short          SCoord_t;    //Screen coordinates (short)
typedef double         Coord_t;     //Pad world coordinates (double)
typedef float          Angle_t;     //Graphics angle (float)
typedef float          Size_t;      //Attribute size (float)

// End copy from RtypesCore.h

// color enum, from Rtypes.h
%rename(KWhite) kWhite;
%rename(KBlack) kBlack;
%rename(KGray) kGray;
%rename(KRed) kRed;
%rename(KGreen) kGreen;
%rename(KBlue) kBlue;
%rename(KYellow) kYellow;
%rename(KMagenta) kMagenta;
%rename(KCyan) kCyan;
%rename(KOrange) kOrange;
%rename(KSpring) kSpring;
%rename(KTeal) kTeal;
%rename(KAzure) kAzure;
%rename(KViolet) kViolet;
%rename(KPink) kPink;
enum EColor{ kWhite, kBlack, kGray, kRed, kGreen, kBlue,
             kYellow, kMagenta, kCyan, kOrange,
             kSpring, kTeal, kAzure, kViolet, kPink };

// marker style enum, from TAttMarker.h
%rename(KDot) kDot;
%rename(KPlus) kPlus;
%rename(KStar) kStar;
%rename(KCircle) kCircle;
%rename(KMultiply) kMultiply;
%rename(KFullDotSmall) kFullDotSmall;
%rename(KFullDotMedium) kFullDotMedium;
%rename(KFullDotLarge) kFullDotLarge;
%rename(KFullCircle) kFullCircle;
%rename(KFullSquare) kFullSquare;
%rename(KFullTriangleUp) kFullTriangleUp;
%rename(KFullTriangleDown) kFullTriangleDown;
%rename(KOpenCircle) kOpenCircle;
%rename(KOpenSquare) kOpenSquare;
%rename(KOpenTriangleUp) kOpenTriangleUp;
%rename(KOpenDiamond) kOpenDiamond;
%rename(KOpenCross) kOpenCross;
%rename(KFullStar) kFullStar;
%rename(KOpenStar) kOpenStar;
%rename(KOpenTriangleDown) kOpenTriangleDown;
%rename(KFullDiamond) kFullDiamond;
%rename(KFullCross) kFullCross;
%rename(KOpenDiamondCross) kOpenDiamondCross;
%rename(KOpenSquareDiagonal) kOpenSquareDiagonal;
%rename(KOpenThreeTriangles) kOpenThreeTriangles;
%rename(KOctagonCross) kOctagonCross;
%rename(KFullThreeTriangles) kFullThreeTriangles;
%rename(KOpenFourTrianglesX) kOpenFourTrianglesX;
%rename(KFullFourTrianglesX) kFullFourTrianglesX;
%rename(KOpenDoubleDiamond) kOpenDoubleDiamond;
%rename(KFullDoubleDiamond) kFullDoubleDiamond;
%rename(KOpenFourTrianglesPlus) kOpenFourTrianglesPlus;
%rename(KFullFourTrianglesPlus) kFullFourTrianglesPlus;
%rename(KOpenCrossX) kOpenCrossX;
%rename(KFullCrossX) kFullCrossX;
%rename(KFourSquaresX) kFourSquaresX;
%rename(KFourSquaresPlus) kFourSquaresPlus;
enum EMarkerStyle{ kDot, kPlus, kStar, kCircle, kMultiply,
                   kFullDotSmall, kFullDotMedium, kFullDotLarge,
                   kFullCircle, kFullSquare, kFullTriangleUp,
                   kFullTriangleDown, kOpenCircle, kOpenSquare,
                   kOpenTriangleUp, kOpenDiamond, kOpenCross,
                   kFullStar, kOpenStar, kOpenTriangleDown,
                   kFullDiamond, kFullCross, kOpenDiamondCross,
                   kOpenSquareDiagonal, kOpenThreeTriangles,
                   kOctagonCross, kFullThreeTriangles,
                   kOpenFourTrianglesX, kFullFourTrianglesX,
                   kOpenDoubleDiamond, kFullDoubleDiamond,
                   kOpenFourTrianglesPlus, kFullFourTrianglesPlus,
                   kOpenCrossX, kFullCrossX, kFourSquaresX,
                   kFourSquaresPlus };

// line style enum, from TAttLine.h
%rename(KSolid) kSolid;
%rename(KDashed) kDashed;
%rename(KDotted) kDotted;
%rename(KDashDotted) kDashDotted;
enum ELineStyle { kSolid, kDashed, kDotted, kDashDotted };
