// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;




contract CosSin {

  uint pi = 314159265359;
  uint n = _pow(10,11);

  function _pow(uint _x, uint _p) internal pure returns (uint _y) {
    require(_p>=0, "Choose _p>=0.");
    _y = 1;
    if (_p>0) {
      for (uint i=1; i<=_p; i++) {
          _y *= _x;
        }
      }
  }

  function cos(uint _radiant) public  view returns (bool _sign, uint _output) {
    require( (0<=_radiant && _radiant <= 2*pi) , "Please choose _radiant between 0 and 2*pi=628318530718. Note: radiant*10^11.");

    // Note: everything will be taken _radiant = radiant*10^11
    // 0 <= _radiant <= 2*pi
    // _sign = false = -1, _sign = true = 1
    // cos(x) = 1-x^2/2+x^4/24-x^6/720 <=>
    // n*cos(x) = (720n^6-360n^4(xn)^2+30n^2(xn)^4-(xn)^6)/(720n^5)

    if (_radiant == pi/2 || _radiant == (3*pi)/2 ) {
      _sign   = true;
      _output = 0;
    } else {
      if ( _radiant < pi/2 ) {
        _sign = true; // output is positive
        } else if (_radiant <= pi ){
          _sign = false;
          _radiant = pi-_radiant;
        } else if (_radiant < (3*pi)/2 ){
          _sign = false;
          _radiant = _radiant-pi;
        } else if (_radiant <= 2*pi ){
          _sign = true;
          _radiant = 2*pi-_radiant;
        }
      _output  = 720*_pow(n,6);
      if (_output> (360*_pow(n,4)*_pow(_radiant,2))) {
        _output -= (360*_pow(n,4)*_pow(_radiant,2));
        _output += (30*_pow(n,2)*_pow(_radiant,4));
        if (_output > _pow(_radiant,6)) {
          _output -= _pow(_radiant,6);
        } else {
          _output = 0;
        }
      _output /= (720*_pow(n,5));
    } else {
          _output = 0;
        }
    }
  }


    function sin(uint _radiant) public view returns (bool _sign, uint _output) {
        require( (0<=_radiant && _radiant <= 2*pi) , "Please choose _radiant between 0 and 2*pi=628318530718. Note: radiant*10^11.");
        // sin(alpha) = cos(pi/2-alpha)
        uint m = pi/2;
        if (_radiant>pi/2) {
          m = pi/2+2*pi;
        }
        _radiant = m-_radiant;
        (_sign , _output) = cos(_radiant);
    }


}
