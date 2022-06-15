// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

// import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "./ERC721Tradable.sol";
import "./CosSin.sol";

contract SVG is ERC721Tradable , CosSin {

    using Strings for uint; // Allows to convert uints to strings

    uint public counter;

    string img_name = "On-Chain SVG";


    struct Setting {
      mapping (uint => bytes) index2path;
      mapping (uint => uint) index2delta;
      mapping (uint => uint[]) index2degree;
      mapping (uint => string) index2color;
    }

    Setting setting;

    constructor() ERC721Tradable("Test","TT",msg.sender) {
    }



    function mint(string memory _path, uint _delta, string memory _color) public {
        _safeMint(msg.sender, counter);
        _index2degree(_path,_delta, counter);
        setting.index2path[counter] = bytes(_path);
        setting.index2delta[counter] = _delta;
        setting.index2color[counter] = _color;
        counter++;
    }

    function burn(uint tokenId) public {
        _burn(tokenId);
    }


    function showInitialValue(uint _tokenId) external view returns (bytes memory path, uint delta, string memory color){
      path = setting.index2path[_tokenId];
      delta = setting.index2delta[_tokenId];
      color = setting.index2color[_tokenId];
    }


    function _index2degree(string memory _path, uint _delta, uint _tokenId) internal {
      uint degree;
      bytes memory path = bytes(_path);


      for(uint i = 0; i<path.length; i++) {
        if ( (keccak256(abi.encodePacked('+')))==keccak256(abi.encodePacked(path[i]))) {
          degree += _delta;
          degree = degree % (2*pi);
          //svgImage = abi.encodePacked(svgImage,'A 20,20 0,0,1 50,30 A 20,20 0,0,1 90,30 Q 90,60 50,90 Q 10,60 10,30 z');
        }else if ( (keccak256(abi.encodePacked('-')))==keccak256(abi.encodePacked(path[i]))) {
          if (degree < _delta) {
            degree = 2*pi+degree-_delta;
            degree = degree % (2*pi);
          } else {
            degree -= _delta;
          }
        }
        setting.index2degree[_tokenId].push(degree);
    }
  }


  struct Pos {
    uint cX;
    uint maxX;
    uint minX;
    uint cY;
    uint maxY;
    uint minY;
    uint x;
    uint y;
    bool bx;
    bool by;
  }

    function createSVG(uint tokenId) view public returns (bytes memory svg) {


      // F draw line
      // f move
      // + degree
      // - degree


      Pos memory _pos;
      _pos = Pos(10000,10000,10000,10000,10000,10000,0,0,true,true);


        bytes memory svgImage;


        for(uint i = 0; i<setting.index2path[tokenId].length; i++) {
            (_pos.bx, _pos.x) = sin(setting.index2degree[tokenId][i]); // x = d*sin(degree)
            (_pos.by, _pos.y) = cos(setting.index2degree[tokenId][i]); // y = -d*cos(degree)
            if(_pos.by == true) {
              _pos.by = false;
            } else {
              _pos.by = true;
            }
            if(_pos.bx == true) {
              _pos.bx = false;
            } else {
              _pos.bx = true;
            }

            if ((( (1000*_pos.x)/n - (100*_pos.x)/n)*10) >= 5) {
              _pos.x = (100*_pos.x)/n+1;
            }else {
              _pos.x = (100*_pos.x)/n;
            }
            if ((( (1000*_pos.y)/n - (100*_pos.y)/n)*10) >= 5) {
              _pos.y = (100*_pos.y)/n+1;
            } else {
              _pos.y = (100*_pos.y)/n;
            }







            if (_pos.bx==true && _pos.by == true) {
              if ( (keccak256(abi.encodePacked('F')))==keccak256(abi.encodePacked(setting.index2path[tokenId][i]))) {
                svgImage = abi.encodePacked(svgImage,' l ',Strings.toString(_pos.x),', ',Strings.toString(_pos.y));
                _pos.cX+=_pos.x;
                _pos.cY+=_pos.y;
              } else if ( (keccak256(abi.encodePacked('f')))==keccak256(abi.encodePacked(setting.index2path[tokenId][i]))) {
                svgImage = abi.encodePacked(svgImage,' m ',Strings.toString(_pos.x),', ',Strings.toString(_pos.y));
                _pos.cX+=_pos.x;
                _pos.cY+=_pos.y;
              }
            } else if (_pos.bx==true && _pos.by == false) {
              if ( (keccak256(abi.encodePacked('F')))==keccak256(abi.encodePacked(setting.index2path[tokenId][i]))) {
                  svgImage = abi.encodePacked(svgImage,' l ',Strings.toString(_pos.x),', -',Strings.toString(_pos.y));
                  _pos.cX+=_pos.x;
                  _pos.cY-=_pos.y;
                }  else if ( (keccak256(abi.encodePacked('f')))==keccak256(abi.encodePacked(setting.index2path[tokenId][i]))) {
                  svgImage = abi.encodePacked(svgImage,' m ',Strings.toString(_pos.x),', -',Strings.toString(_pos.y));
                  _pos.cX+=_pos.x;
                  _pos.cY-=_pos.y;
                }
            } else if (_pos.bx==false && _pos.by == true) {
              if ( (keccak256(abi.encodePacked('F')))==keccak256(abi.encodePacked(setting.index2path[tokenId][i]))) {
                  svgImage = abi.encodePacked(svgImage,' l -',Strings.toString(_pos.x),', ',Strings.toString(_pos.y));
                  _pos.cX-=_pos.x;
                  _pos.cY+=_pos.y;
                }  else if ( (keccak256(abi.encodePacked('f')))==keccak256(abi.encodePacked(setting.index2path[tokenId][i]))) {
                  svgImage = abi.encodePacked(svgImage,' m -',Strings.toString(_pos.x),', ',Strings.toString(_pos.y));
                  _pos.cX-=_pos.x;
                  _pos.cY+=_pos.y;
                }
            } else {
              if ( (keccak256(abi.encodePacked('F')))==keccak256(abi.encodePacked(setting.index2path[tokenId][i]))) {
                  svgImage = abi.encodePacked(svgImage,' l -',Strings.toString(_pos.x),', -',Strings.toString(_pos.y));
                  _pos.cX-=_pos.x;
                  _pos.cY-=_pos.y;
                }
                else if ( (keccak256(abi.encodePacked('f')))==keccak256(abi.encodePacked(setting.index2path[tokenId][i]))) {
                 svgImage = abi.encodePacked(svgImage,' m -',Strings.toString(_pos.x),', -',Strings.toString(_pos.y));
                 _pos.cX-=_pos.x;
                 _pos.cY-=_pos.y;
               }
            }






        if (_pos.cX>_pos.maxX) {
          _pos.maxX=_pos.cX;
        }
        if (_pos.cY>_pos.maxY) {
          _pos.maxY=_pos.cY;
        }
        if (_pos.cX<_pos.minX) {
          _pos.minX=_pos.cX;
        }
        if (_pos.cY<_pos.minY) {
          _pos.minY=_pos.cY;
        }

}
/*
        bytes memory svgBegin = '<svg viewBox="0 0 ';
        svgBegin = abi.encodePacked(svgBegin, Strings.toString(2000),' ',Strings.toString(2000),'" xmlns="http://www.w3.org/2000/svg"><path fill="none" stroke="red"');
        svgBegin = abi.encodePacked(svgBegin,' d="M ',Strings.toString(1000),',',Strings.toString(1000));
        svg = abi.encodePacked(svgBegin,svgImage,'" /></svg>');/
*/

        bytes memory svgBegin = '<svg viewBox="0 0 ';
        svgBegin = abi.encodePacked(svgBegin, Strings.toString(_pos.maxX-_pos.minX+100),' ',Strings.toString(_pos.maxY-_pos.minY+100),'" xmlns="http://www.w3.org/2000/svg"><path fill="none" stroke="',setting.index2color[tokenId],'"');

        svgBegin = abi.encodePacked(svgBegin,' d="M ',Strings.toString((10000-_pos.minX+50)),',',Strings.toString((10000-_pos.minY+50)));
        svg = abi.encodePacked(svgBegin,svgImage,'" /></svg>');

    }



    function tokenURI(uint tokenId) public view override returns (string memory output) {


          bytes memory svg = createSVG(tokenId);
          output = string(abi.encodePacked('data:application/json;base64,', Base64.encode(bytes(string(abi.encodePacked(
              '{"name": "', img_name, '", "image": "data:image/svg+xml;base64,', Base64.encode(bytes(svg)), '"}'
          ))))));
          // output = 'https://gist.githubusercontent.com/fridolinvii/dc914735baef4e6e6932c8c4341f58b9/raw/8e94c5029402aa5fe92eef5f26295c45b52cc758/fix.json';
          // output = string(abi.encodePacked('data:application/json;base64,', Base64.encode(bytes(string(abi.encodePacked(
          //    '{"name": "Mask Bla Bla","description": "Nothing ha been revelead yet...","image": "https://app.stargaze.zone/_next/image?url=https%3A%2F%2Fres.cloudinary.com%2Fstargaze%2Fimage%2Fupload%2Fw_700%2Fvn4bnru2bjwo8o2su9fk&w=3840&q=75"}'
              //'{"name": "', img_name, '", "image": "https://app.stargaze.zone/_next/image?url=https%3A%2F%2Fres.cloudinary.com%2Fstargaze%2Fimage%2Fupload%2Fw_700%2Fvn4bnru2bjwo8o2su9fk&w=3840&q=75"}'
          // ))))));
        /* } else {

          string memory background = flag ? '#00ff00' : '#ff0000'; // flag true -> green, otherwise red

          string memory svg = '<svg height="200" version="1.1" width="400" xmlns="http://www.w3.org/2000/svg">';
          svg = string(abi.encodePacked(svg,
              '<style>',
              'text { font-family: Monospace, Helvetica, sans-serif; font-weight: bold; fill: #444444; font-size: 1em; }',
              '.title { text-anchor: middle; font-size: 1.5em; }',
              '</style>'
          ));
          svg = string(abi.encodePacked(svg, '<rect width="100%" height="100%" fill="', background ,'" />'));
          svg = string(abi.encodePacked(svg, '<text x="200" y="40" class="title">Title: ', img_name, '</text>'));
          svg = string(abi.encodePacked(svg, '<text x="20" y="80">NFT ID: ', tokenId.toString(), '</text>'));
          svg = string(abi.encodePacked(svg, '</svg>'));

          // Generate JSON with SVG image
          output = string(abi.encodePacked('data:application/json;base64,', Base64.encode(bytes(string(abi.encodePacked(
              '{"name": "', img_name, '", "image": "data:image/svg+xml;base64,', Base64.encode(bytes(svg)), '"}'
          ))))));
        }
        */
    }




}


/// [MIT License]
/// @title Base64
/// @notice Provides a function for encoding some bytes in base64
/// @author Brecht Devos <brecht@loopring.org>
library Base64 {
    bytes internal constant TABLE = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

    /// @notice Encodes some bytes to the base64 representation
    function encode(bytes memory data) internal pure returns (string memory) {
        uint256 len = data.length;
        if (len == 0) return "";

        // multiply by 4/3 rounded up
        uint256 encodedLen = 4 * ((len + 2) / 3);

        // Add some extra buffer at the end
        bytes memory result = new bytes(encodedLen + 32);

        bytes memory table = TABLE;

        assembly {
            let tablePtr := add(table, 1)
            let resultPtr := add(result, 32)

            for {
                let i := 0
            } lt(i, len) {

            } {
                i := add(i, 3)
                let input := and(mload(add(data, i)), 0xffffff)

                let out := mload(add(tablePtr, and(shr(18, input), 0x3F)))
                out := shl(8, out)
                out := add(out, and(mload(add(tablePtr, and(shr(12, input), 0x3F))), 0xFF))
                out := shl(8, out)
                out := add(out, and(mload(add(tablePtr, and(shr(6, input), 0x3F))), 0xFF))
                out := shl(8, out)
                out := add(out, and(mload(add(tablePtr, and(input, 0x3F))), 0xFF))
                out := shl(224, out)

                mstore(resultPtr, out)

                resultPtr := add(resultPtr, 4)
            }

            switch mod(len, 3)
            case 1 {
                mstore(sub(resultPtr, 2), shl(240, 0x3d3d))
            }
            case 2 {
                mstore(sub(resultPtr, 1), shl(248, 0x3d))
            }

            mstore(result, encodedLen)
        }

        return string(result);
    }
}
