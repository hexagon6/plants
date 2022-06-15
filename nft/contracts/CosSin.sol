// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;




contract CosSin {

  uint pi = 180;
  uint n = _pow(10,6);



  mapping (uint => uint) degree2cos;
  constructor() {
      degree2cos[0] = 1000000;
      degree2cos[1] = 999848;
      degree2cos[2] = 999391;
      degree2cos[3] = 998630;
      degree2cos[4] = 997564;
      degree2cos[5] = 996195;
      degree2cos[6] = 994522;
      degree2cos[7] = 992546;
      degree2cos[8] = 990268;
      degree2cos[9] = 987688;
      degree2cos[10] = 984808;
      degree2cos[11] = 981627;
      degree2cos[12] = 978148;
      degree2cos[13] = 974370;
      degree2cos[14] = 970296;
      degree2cos[15] = 965926;
      degree2cos[16] = 961262;
      degree2cos[17] = 956305;
      degree2cos[18] = 951057;
      degree2cos[19] = 945519;
      degree2cos[20] = 939693;
      degree2cos[21] = 933580;
      degree2cos[22] = 927184;
      degree2cos[23] = 920505;
      degree2cos[24] = 913545;
      degree2cos[25] = 906308;
      degree2cos[26] = 898794;
      degree2cos[27] = 891007;
      degree2cos[28] = 882948;
      degree2cos[29] = 874620;
      degree2cos[30] = 866025;
      degree2cos[31] = 857167;
      degree2cos[32] = 848048;
      degree2cos[33] = 838671;
      degree2cos[34] = 829038;
      degree2cos[35] = 819152;
      degree2cos[36] = 809017;
      degree2cos[37] = 798636;
      degree2cos[38] = 788011;
      degree2cos[39] = 777146;
      degree2cos[40] = 766044;
      degree2cos[41] = 754710;
      degree2cos[42] = 743145;
      degree2cos[43] = 731354;
      degree2cos[44] = 719340;
      degree2cos[45] = 707107;

      degree2cos[46] = 694658;
      degree2cos[47] = 681998;
      degree2cos[48] = 669131;
      degree2cos[49] = 656059;
      degree2cos[50] = 642788;
      degree2cos[51] = 629320;
      degree2cos[52] = 615661;
      degree2cos[53] = 601815;
      degree2cos[54] = 587785;
      degree2cos[55] = 573576;
      degree2cos[56] = 559193;
      degree2cos[57] = 544639;
      degree2cos[58] = 529919;
      degree2cos[59] = 515038;
      degree2cos[60] = 500000;
      degree2cos[61] = 484810;
      degree2cos[62] = 469472;
      degree2cos[63] = 453990;
      degree2cos[64] = 438371;
      degree2cos[65] = 422618;
      degree2cos[66] = 406737;
      degree2cos[67] = 390731;
      degree2cos[68] = 374607;
      degree2cos[69] = 358368;
      degree2cos[70] = 342020;
      degree2cos[71] = 325568;
      degree2cos[72] = 309017;
      degree2cos[73] = 292372;
      degree2cos[74] = 275637;
      degree2cos[75] = 258819;
      degree2cos[76] = 241922;
      degree2cos[77] = 224951;
      degree2cos[78] = 207912;
      degree2cos[79] = 190809;
      degree2cos[80] = 173648;
      degree2cos[81] = 156434;
      degree2cos[82] = 139173;
      degree2cos[83] = 121869;
      degree2cos[84] = 104528;
      degree2cos[85] =  87156;
      degree2cos[86] =  69756;
      degree2cos[87] =  52336;
      degree2cos[88] =  34899;
      degree2cos[89] =  17452;
      degree2cos[90] =  0;

  }











  function _pow(uint _x, uint _p) internal pure returns (uint _y) {
    require(_p>=0, "Choose _p>=0.");
    _y = 1;
    if (_p>0) {
      for (uint i=1; i<=_p; i++) {
          _y *= _x;
        }
      }
  }

  function cos(uint _degree) public  view returns (bool _sign, uint _output) {
    require( (0<=_degree && _degree <= 360) , "Please choose _degree between 0 and 360.");

    if (_degree<=pi/2) {
      _sign = true;
      _output = degree2cos[_degree];
    } else if (_degree<=pi) {
      _degree = pi -_degree;
      _sign = false;
      _output = degree2cos[_degree];
    } else if (_degree<=3*pi/2) {
      _degree = _degree - pi;
      _sign = false;
      _output = degree2cos[_degree];
    } else {
      _degree = 2*pi -_degree;
      _sign = true;
      _output = degree2cos[_degree];
    }
  }


    function sin(uint _degree) public view returns (bool _sign, uint _output) {
        require( (0<=_degree && _degree <= 2*pi) , "Please choose _degree between 0 and 360.");
        // sin(alpha) = cos(pi/2-alpha)
        uint m = pi/2;
        if (_degree>pi/2) {
          m = pi/2+2*pi;
        }
        _degree = m-_degree;
        (_sign , _output) = cos(_degree);
    }


}
