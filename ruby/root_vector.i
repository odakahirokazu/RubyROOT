/**************************************************************************/
/* Vector
/**************************************************************************/

class TVector2 : public TObject {
public:
  TVector2 ();
  TVector2 (Double_t x0, Double_t y0);
  virtual ~TVector2();

  // TVector2&       operator  = (TVector2 const & v);
  // TVector2&       operator += (TVector2 const & v);
  // TVector2&       operator -= (TVector2 const & v);
  // Double_t        operator *= (TVector2 const & v);
  // TVector2&       operator *= (Double_t s);
  // TVector2&       operator /= (Double_t s);

  void Set(const TVector2& v);
  void Set(Double_t x0, Double_t y0);
  void SetX(Double_t x0);
  void SetY(Double_t y0);

  Double_t Mod2() const { return fX*fX+fY*fY; };
  Double_t Mod () const;

  Double_t Px()   const { return fX; };
  Double_t Py()   const { return fY; };
  Double_t X ()   const { return fX; };
  Double_t Y ()   const { return fY; };

  Double_t Phi           () const;
  Double_t DeltaPhi(const TVector2& v) const;
  void     SetMagPhi(Double_t mag, Double_t phi);

  TVector2 Unit() const;
  TVector2 Ort () const;
  TVector2 Proj(const TVector2& v) const;
  TVector2 Norm(const TVector2& v) const;
  TVector2 Rotate (Double_t phi) const;

  static Double_t Phi_0_2pi(Double_t x);
  static Double_t Phi_mpi_pi(Double_t x);

  void Print(Option_t* option="") const;

  %extend {
    TVector2 operator + (const TVector2& v) { return *$self + v; }
    TVector2 operator - (const TVector2& v) { return *$self - v; }
    Double_t operator * (const TVector2& v) { return ($self->X())*(v.X())+($self->Y())*(v.Y()); }
    TVector2 operator * (Double_t s) { return *$self*s; }
    TVector2 operator / (Double_t s) { return *$self/s; }
  }
};

class TVector3 : public TObject {
public:
  TVector3();
  TVector3(Double_t x, Double_t y, Double_t z);
  TVector3(const TVector3 &);
  virtual ~TVector3();

  // Double_t operator () (int) const;
  // inline Double_t operator [] (int) const;
  // Double_t & operator () (int);
  // inline Double_t & operator [] (int);
  
  inline Double_t x()  const;
  inline Double_t y()  const;
  inline Double_t z()  const;
  inline Double_t X()  const;
  inline Double_t Y()  const;
  inline Double_t Z()  const;
  inline Double_t Px() const;
  inline Double_t Py() const;
  inline Double_t Pz() const;
  
  inline void SetX(Double_t);
  inline void SetY(Double_t);
  inline void SetZ(Double_t);
  inline void SetXYZ(Double_t x, Double_t y, Double_t z);
  void        SetPtEtaPhi(Double_t pt, Double_t eta, Double_t phi);
  void        SetPtThetaPhi(Double_t pt, Double_t theta, Double_t phi);

  inline void GetXYZ(Double_t *carray) const;
  inline void GetXYZ(Float_t *carray) const;

  Double_t Phi() const;
  Double_t Theta() const;
  inline Double_t CosTheta() const;
  inline Double_t Mag2() const;
  Double_t Mag() const { return TMath::Sqrt(Mag2()); }
  void SetPhi(Double_t);
  void SetTheta(Double_t);
  inline void SetMag(Double_t);
  inline Double_t Perp2() const;
  inline Double_t Pt() const;
  Double_t Perp() const;
  inline void SetPerp(Double_t);
  inline Double_t Perp2(const TVector3 &) const;
  inline Double_t Pt(const TVector3 &) const;
  Double_t Perp(const TVector3 &) const;
  inline Double_t DeltaPhi(const TVector3 &) const;
  Double_t DeltaR(const TVector3 &) const;
  inline Double_t DrEtaPhi(const TVector3 &) const;
  inline TVector2 EtaPhiVector() const;
  void SetMagThetaPhi(Double_t mag, Double_t theta, Double_t phi);

  // inline TVector3 & operator = (const TVector3 &);
  // inline Bool_t operator == (const TVector3 &) const;
  // inline Bool_t operator != (const TVector3 &) const;
  // inline TVector3 & operator += (const TVector3 &);
  // inline TVector3 & operator -= (const TVector3 &);
  // inline TVector3 operator - () const;
  // inline TVector3 & operator *= (Double_t);

  TVector3 Unit() const;
  inline TVector3 Orthogonal() const;
  inline Double_t Dot(const TVector3 &) const;
  inline TVector3 Cross(const TVector3 &) const;
  Double_t Angle(const TVector3 &) const;
  Double_t PseudoRapidity() const;
  inline Double_t Eta() const;
  void RotateX(Double_t);
  void RotateY(Double_t);
  void RotateZ(Double_t);
  void RotateUz(const TVector3&);
  void Rotate(Double_t, const TVector3 &);
  
  TVector3 & Transform(const TRotation &);
  inline TVector2 XYvector() const;
  void Print(Option_t* option="") const;

  %extend {
    TVector3 operator + (const TVector3& v) { return *$self + v; }
    TVector3 operator - (const TVector3& v) { return *$self - v; }
    TVector3 operator - () { return -(*$self); }
    TVector3 operator * (Double_t s) { return *$self*s; }
    Double_t operator * (const TVector3& v) { return $self->Dot(v); }
    TVector3 operator / (Double_t s) { return *$self*(1.0/s); }
  }
};

class TRotation : public TObject {
public:
  TRotation();
  TRotation(const TRotation &);
  virtual ~TRotation();

  inline Double_t XX() const;
  inline Double_t XY() const;
  inline Double_t XZ() const;
  inline Double_t YX() const;
  inline Double_t YY() const;
  inline Double_t YZ() const;
  inline Double_t ZX() const;
  inline Double_t ZY() const;
  inline Double_t ZZ() const;
  
  // inline TRotationRow operator [] (int) const;
  // Double_t operator () (int, int) const;
  // inline TRotation & operator = (const TRotation &);
  // inline Bool_t operator == (const TRotation &) const;
  // inline Bool_t operator != (const TRotation &) const;

  inline Bool_t IsIdentity() const;

  inline TVector3 operator * (const TVector3 &) const;
  TRotation operator * (const TRotation &) const;
  // inline TRotation & operator *= (const TRotation &);
  inline TRotation & Transform(const TRotation &);
  
  inline TRotation Inverse() const;
  inline TRotation & Invert();
  
  TRotation & RotateX(Double_t);
  TRotation & RotateY(Double_t);
  TRotation & RotateZ(Double_t);
  
  TRotation & Rotate(Double_t, const TVector3 &);
  
  TRotation & RotateAxes(const TVector3 & newX,
                         const TVector3 & newY,
                         const TVector3 & newZ);
  
  Double_t PhiX() const;
  Double_t PhiY() const;
  Double_t PhiZ() const;
  Double_t ThetaX() const;
  Double_t ThetaY() const;
  Double_t ThetaZ() const;
  
  void AngleAxis(Double_t &, TVector3 &) const;
  
  inline TRotation & SetToIdentity();
  
  TRotation & SetXEulerAngles(Double_t phi, Double_t theta, Double_t psi);
  void SetXPhi(Double_t);
  void SetXTheta(Double_t);
  void SetXPsi(Double_t);
  
  TRotation & RotateXEulerAngles(Double_t phi, Double_t theta, Double_t psi);
  
  Double_t GetXPhi(void) const;
  Double_t GetXTheta(void) const;
  Double_t GetXPsi(void) const;
  
  TRotation & SetYEulerAngles(Double_t phi, Double_t theta, Double_t psi);
  void SetYPhi(Double_t);
  void SetYTheta(Double_t);
  void SetYPsi(Double_t);
  
  TRotation & RotateYEulerAngles(Double_t phi, Double_t theta, Double_t psi);
  
  Double_t GetYPhi(void) const;
  Double_t GetYTheta(void) const;
  Double_t GetYPsi(void) const;
  

  TRotation & SetXAxis(const TVector3& axis);
  TRotation & SetXAxis(const TVector3& axis, const TVector3& xyPlane);
  TRotation & SetYAxis(const TVector3& axis);
  TRotation & SetYAxis(const TVector3& axis, const TVector3& yzPlane);
  TRotation & SetZAxis(const TVector3& axis);
  TRotation & SetZAxis(const TVector3& axis, const TVector3& zxPlane);
  
   void MakeBasis(TVector3& xAxis, TVector3& yAxis, TVector3& zAxis) const;
};

class TLorentzVector : public TObject {
public:
  TLorentzVector();
  TLorentzVector(Double_t x, Double_t y, Double_t z, Double_t t);
  TLorentzVector(const Double_t * carray);
  TLorentzVector(const TVector3 & vector3, Double_t t);
  TLorentzVector(const TLorentzVector & lorentzvector);
  virtual ~TLorentzVector();

  inline Double_t X() const;
  inline Double_t Y() const;
  inline Double_t Z() const;
  inline Double_t T() const;
  
  inline void SetX(Double_t a);
  inline void SetY(Double_t a);
  inline void SetZ(Double_t a);
  inline void SetT(Double_t a);
  
  inline Double_t Px() const;
  inline Double_t Py() const;
  inline Double_t Pz() const;
  inline Double_t P()  const;
  inline Double_t E()  const;
  inline Double_t Energy() const;
  
  inline void SetPx(Double_t a);
  inline void SetPy(Double_t a);
  inline void SetPz(Double_t a);
  inline void SetE(Double_t a);
  
  inline TVector3 Vect() const ;
  inline void SetVect(const TVector3 & vect3);
  
  inline Double_t Theta() const;
  inline Double_t CosTheta() const;
  inline Double_t Phi() const; //returns phi from -pi to pi
  inline Double_t Rho() const;
  
  inline void SetTheta(Double_t theta);
  inline void SetPhi(Double_t phi);
  inline void SetRho(Double_t rho);
  
  inline void SetPxPyPzE(Double_t px, Double_t py, Double_t pz, Double_t e);
  inline void SetXYZT(Double_t  x, Double_t  y, Double_t  z, Double_t t);
  inline void SetXYZM(Double_t  x, Double_t  y, Double_t  z, Double_t m);
  inline void SetPtEtaPhiM(Double_t pt, Double_t eta, Double_t phi, Double_t m);
  inline void SetPtEtaPhiE(Double_t pt, Double_t eta, Double_t phi, Double_t e);
  
  inline void GetXYZT(Double_t *carray) const;
  inline void GetXYZT(Float_t *carray) const;
  
  // Double_t operator () (int i) const;
  // inline Double_t operator [] (int i) const;
  
  // Double_t & operator () (int i);
  // inline Double_t & operator [] (int i);
  
  // inline TLorentzVector & operator = (const TLorentzVector &);
  inline TLorentzVector   operator +  (const TLorentzVector &) const;
  // inline TLorentzVector & operator += (const TLorentzVector &);
  inline TLorentzVector   operator -  (const TLorentzVector &) const;
  // inline TLorentzVector & operator -= (const TLorentzVector &);
  inline TLorentzVector operator - () const;
  inline TLorentzVector operator * (Double_t a) const;
  // inline TLorentzVector & operator *= (Double_t a);
  // inline Bool_t operator == (const TLorentzVector &) const;
  // inline Bool_t operator != (const TLorentzVector &) const;

  inline Double_t Perp2() const;
  inline Double_t Pt() const;
  inline Double_t Perp() const;
  inline void SetPerp(Double_t);
  inline Double_t Perp2(const TVector3 & v) const;
  inline Double_t Pt(const TVector3 & v) const;
  inline Double_t Perp(const TVector3 & v) const;
  inline Double_t Et2() const;
  inline Double_t Et() const;
  inline Double_t Et2(const TVector3 &) const;
  inline Double_t Et(const TVector3 &) const;
  inline Double_t DeltaPhi(const TLorentzVector &) const;
  inline Double_t DeltaR(const TLorentzVector &) const;
  inline Double_t DrEtaPhi(const TLorentzVector &) const;
  inline TVector2 EtaPhiVector();
  inline Double_t Angle(const TVector3 & v) const;
  inline Double_t Mag2() const;
  inline Double_t M2() const;
  inline Double_t Mag() const;
  inline Double_t M() const;
  inline Double_t Mt2() const;
  inline Double_t Mt() const;
  inline Double_t Beta() const;
  inline Double_t Gamma() const;
  inline Double_t Dot(const TLorentzVector &) const;
  inline Double_t operator * (const TLorentzVector &) const;
  inline void SetVectMag(const TVector3 & spatial, Double_t magnitude);
  inline void SetVectM(const TVector3 & spatial, Double_t mass);
  inline Double_t Plus() const;
  inline Double_t Minus() const;
  inline TVector3 BoostVector() const ;
  void Boost(Double_t, Double_t, Double_t);
  inline void Boost(const TVector3 &);
  Double_t Rapidity() const;
  inline Double_t Eta() const;
  inline Double_t PseudoRapidity() const;
  inline void RotateX(Double_t angle);
  inline void RotateY(Double_t angle);
  inline void RotateZ(Double_t angle);
  inline void RotateUz(TVector3 & newUzVector);
  inline void Rotate(Double_t, const TVector3 &);
  // inline TLorentzVector & operator *= (const TRotation &);
  inline TLorentzVector & Transform(const TRotation &);
  // TLorentzVector & operator *= (const TLorentzRotation &);
  TLorentzVector & Transform(const TLorentzRotation &);
  virtual void        Print(Option_t *option="") const;
};

class TLorentzRotation : public TObject {
public:
  TLorentzRotation();
  TLorentzRotation(const TRotation &);
  TLorentzRotation(const TLorentzRotation &);
  TLorentzRotation(Double_t, Double_t, Double_t);
  TLorentzRotation(const TVector3 &);
  
  inline Double_t XX() const;
  inline Double_t XY() const;
  inline Double_t XZ() const;
  inline Double_t XT() const;
  inline Double_t YX() const;
  inline Double_t YY() const;
  inline Double_t YZ() const;
  inline Double_t YT() const;
  inline Double_t ZX() const;
  inline Double_t ZY() const;
  inline Double_t ZZ() const;
  inline Double_t ZT() const;
  inline Double_t TX() const;
  inline Double_t TY() const;
  inline Double_t TZ() const;
  inline Double_t TT() const;
  
  // inline TLorentzRotationRow operator [] (int) const;
  // Double_t operator () (int, int) const;
  // inline TLorentzRotation & operator = (const TLorentzRotation &);
  // inline TLorentzRotation & operator = (const TRotation &);
  
  // inline Bool_t operator == (const TLorentzRotation &) const;
  // inline Bool_t operator != (const TLorentzRotation &) const;
  
  inline Bool_t IsIdentity() const;
  
  inline TLorentzVector VectorMultiplication(const TLorentzVector&) const;
  inline TLorentzVector operator * (const TLorentzVector &) const;
  
  TLorentzRotation MatrixMultiplication(const TLorentzRotation &) const;
  inline TLorentzRotation operator * (const TLorentzRotation &) const;
  // inline TLorentzRotation & operator *= (const TLorentzRotation &);
  inline TLorentzRotation & Transform(const TLorentzRotation &);
  inline TLorentzRotation & Transform(const TRotation &);
  
  inline TLorentzRotation Inverse() const;
  inline TLorentzRotation & Invert();
  
  inline TLorentzRotation & Boost(Double_t, Double_t, Double_t);
  inline TLorentzRotation & Boost(const TVector3 &);
  
  inline TLorentzRotation & RotateX(Double_t);
  inline TLorentzRotation & RotateY(Double_t);
  inline TLorentzRotation & RotateZ(Double_t);
  
  inline TLorentzRotation & Rotate(Double_t, const TVector3 &);
  // inline TLorentzRotation & Rotate(Double_t, const TVector3 *);
};
