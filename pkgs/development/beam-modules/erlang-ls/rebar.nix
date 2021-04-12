{ fetchHex, fetchGit, fetchFromGitHub }:
{
  getopt = fetchHex {
    pkg = "getopt";
    version = "1.0.1";
    sha256 = "53E1AB83B9CEB65C9672D3E7A35B8092E9BDC9B3EE80721471A161C10C59959C";
  };
  zipper = fetchHex {
    pkg = "zipper";
    version = "1.0.1";
    sha256 = "6A1FD3E1F0CC1D1DF5642C9A0CE2178036411B0A5C9642851D1DA276BD737C2D";
  };
  quickrand = fetchHex {
    pkg = "quickrand";
    version = "2.0.1";
    sha256 = "14DB67D4AEF6B8815810EC9F3CCEF5E324B73B56CAE3687F99D752B85BDD4C96";
  };
  providers = fetchHex {
    pkg = "providers";
    version = "1.8.1";
    sha256 = "E45745ADE9C476A9A469EA0840E418AB19360DC44F01A233304E118A44486BA0";
  };
  katana_code = fetchHex {
    pkg = "katana_code";
    version = "0.2.1";
    sha256 = "8448AD3F56D9814F98A28BE650F7191BDD506575E345CC16D586660B10F6E992";
  };
  bucs = fetchHex {
    pkg = "bucs";
    version = "1.0.16";
    sha256 = "FF6A5C72A500AD7AEC1EE3BA164AE3C450EADEE898B0D151E1FACA18AC8D0D62";
  };
  yamerl = fetchHex {
    pkg = "yamerl";
    version = "0.8.1";
    sha256 = "96CB30F9D64344FED0EF8A92E9F16F207DE6C04DFFF4F366752CA79F5BCEB23F";
  };
  uuid = fetchHex {
    pkg = "uuid_erl";
    version = "2.0.1";
    sha256 = "AB57CACCD51F170011E5F444CE865F84B41605E483A9EFCC468C1AFAEC87553B";
  };
  tdiff = fetchHex {
    pkg = "tdiff";
    version = "0.1.2";
    sha256 = "E0C2E168F99252A5889768D5C8F1E6510A184592D4CFA06B22778A18D33D7875";
  };
  redbug = fetchHex {
    pkg = "redbug";
    version = "2.0.6";
    sha256 = "AAD9498671F4AB91EACA5099FE85A61618158A636E6286892C4F7CF4AF171D04";
  };
  rebar3_format = fetchHex {
    pkg = "rebar3_format";
    version = "0.8.2";
    sha256 = "CA8FF27638C2169593D1449DACBE8895634193ED3334E906B54FC97F081F5213";
  };
  ranch = fetchHex {
    pkg = "ranch";
    version = "1.7.1";
    sha256 = "451D8527787DF716D99DC36162FCA05934915DB0B6141BBDAC2EA8D3C7AFC7D7";
  };
  jsx = fetchHex {
    pkg = "jsx";
    version = "3.0.0";
    sha256 = "37BECA0435F5CA8A2F45F76A46211E76418FBEF80C36F0361C249FC75059DC6D";
  };
  ephemeral = fetchHex {
    pkg = "ephemeral";
    version = "2.0.4";
    sha256 = "4B293D80F75F9C4575FF4B9C8E889A56802F40B018BF57E74F19644EFEE6C850";
  };
  elvis_core = fetchHex {
    pkg = "elvis_core";
    version = "1.1.1";
    sha256 = "391C95BAA49F2718D7FB498BCF08046DDFC202CF0AAB63B2E439271485C9DC42";
  };
  docsh = fetchHex {
    pkg = "docsh";
    version = "0.7.2";
    sha256 = "4E7DB461BB07540D2BC3D366B8513F0197712D0495BB85744F367D3815076134";
  };
}
