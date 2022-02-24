/**************************************************************************/
/* Instantiation of template casting function                             */
/**************************************************************************/

%inline {
  template<typename T> T* castInto(TObject* ptr)
  {
    return static_cast<T*>(ptr);
  }
}

%template(castIntoTObject) castInto<TObject>;
%template(castIntoTObjString) castInto<TObjString>;
%template(castIntoTNamed) castInto<TNamed>;
%template(castIntoTCollection) castInto<TCollection>;
%template(castIntoTSeqCollection) castInto<TSeqCollection>;
%template(castIntoTList) castInto<TList>;
%template(castIntoTObjArray) castInto<TObjArray>;
%template(castIntoTKey) castInto<TKey>;
%template(castIntoTMap) castInto<TMap>;
%template(castIntoTH1) castInto<TH1>;
%template(castIntoTH1C) castInto<TH1C>;
%template(castIntoTH1S) castInto<TH1S>;
%template(castIntoTH1I) castInto<TH1I>;
%template(castIntoTH1F) castInto<TH1F>;
%template(castIntoTH1D) castInto<TH1D>;
%template(castIntoTH2) castInto<TH2>;
%template(castIntoTH2C) castInto<TH2C>;
%template(castIntoTH2S) castInto<TH2S>;
%template(castIntoTH2I) castInto<TH2I>;
%template(castIntoTH2F) castInto<TH2F>;
%template(castIntoTH2D) castInto<TH2D>;
%template(castIntoTH3) castInto<TH3>;
%template(castIntoTH3C) castInto<TH3C>;
%template(castIntoTH3S) castInto<TH3S>;
%template(castIntoTH3I) castInto<TH3I>;
%template(castIntoTH3F) castInto<TH3F>;
%template(castIntoTH3D) castInto<TH3D>;
%template(castIntoTTree) castInto<TTree>;
%template(castIntoTChain) castInto<TChain>;
%template(castIntoTBranch) castInto<TBranch>;
%template(castIntoTLeaf) castInto<TLeaf>;
%template(castIntoTGraph) castInto<TGraph>;
%template(castIntoTGraphErrors) castInto<TGraphErrors>;
%template(castIntoTGraphAsymmErrors) castInto<TGraphAsymmErrors>;
%template(castIntoTMultiGraph) castInto<TMultiGraph>;
%template(castIntoTDirectory) castInto<TDirectory>;
%template(castIntoTDirectoryFile) castInto<TDirectoryFile>;
%template(castIntoTFile) castInto<TFile>;
%template(castIntoTFormula) castInto<TFormula>;
%template(castIntoTF1) castInto<TF1>;
%template(castIntoTSpline) castInto<TSpline>;
%template(castIntoTSpline3) castInto<TSpline3>;
%template(castIntoTSpline5) castInto<TSpline5>;
%template(castIntoTPaletteAxis) castInto<TPaletteAxis>;
%template(castIntoTCanvas) castInto<TCanvas>;
%template(castIntoTPad) castInto<TPad>;
