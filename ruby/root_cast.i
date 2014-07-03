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
%template(castIntoTNamed) castInto<TNamed>;
%template(castIntoTCollection) castInto<TCollection>;
%template(castIntoTSeqCollection) castInto<TSeqCollection>;
%template(castIntoTList) castInto<TList>;
%template(castIntoTObjArray) castInto<TObjArray>;
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
%template(castIntoTDirectory) castInto<TDirectory>;
%template(castIntoTDirectoryFile) castInto<TDirectoryFile>;
%template(castIntoTFile) castInto<TFile>;
