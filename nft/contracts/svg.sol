// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "./ERC721Tradable.sol";

contract SVG is ERC721Tradable {
    using Strings for uint; // Allows to convert uints to strings

    uint public counter;

    string img_name = "On-Chain SVG";
    bool flag; // Determines the background color of the NFT

    constructor() ERC721Tradable("Test","TT",msg.sender) {
    }

    function mint() public {
        _safeMint(msg.sender, ++counter);
    }

    function burn(uint tokenId) public {
        _burn(tokenId);
    }

    function toggle() public {
        // Switch color between red and green
        flag = !flag;
    }



    function createSVG(string memory _path, int _delta) pure public returns (bytes memory svg) {

      // F draw line
      // f move
      // + degree
      // - degree
      bytes memory path = bytes(_path); //new bytes(bytes(string).length);
      int degree = 0;

        uint x;
        uint y;
        bool by;
        bool bx;

        bytes memory svgBegin = '<svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg"><path fill="none" stroke="red" d="M 50,50';
        bytes memory svgImage;
        // A 20,20 0,0,1 50,30 A 20,20 0,0,1 90,30 Q 90,60 50,90 Q 10,60 10,30 z" /></svg>"';
        for(uint i = 0; i<path.length; i++) {

          if ( (keccak256(abi.encodePacked('f')))==keccak256(abi.encodePacked(path[i]))) {
            degree += _delta;
            //svgImage = abi.encodePacked(svgImage,'A 20,20 0,0,1 50,30 A 20,20 0,0,1 90,30 Q 90,60 50,90 Q 10,60 10,30 z');
          }else if ( (keccak256(abi.encodePacked('f')))==keccak256(abi.encodePacked(path[i]))) {
            degree -= _delta;
            //svgImage = abi.encodePacked(svgImage,'A 20,20 0,0,1 50,30 A 20,20 0,0,1 90,30 Q 90,60 50,90 Q 10,60 10,30 z');
          } else {



        //    x = 0; //10*degree*3/180-(10*3^3*degree^3)/6/180^3;  // x = d*sin(degree)
        //    y = -10; //+(3^2*10*degree^2)/2/180^2; // y = -cos

            if ( (keccak256(abi.encodePacked('F')))==keccak256(abi.encodePacked(path[i]))) {
              if (x>=0 && y>=0) {
                svgImage = abi.encodePacked(svgImage,' l ',Strings.toString(uint(x)),',',Strings.toString(uint(y)));
              }
            /*
            if (x<0 && y<0) {
              svgImage = abi.encodePacked(svgImage,' l -',Strings.toString(uint(x)),', -',Strings.toString(uint(y)));
            }
            if (x<0 && y>=0) {
              svgImage = abi.encodePacked(svgImage,' l -',Strings.toString(uint(x)),', ',Strings.toString(uint(y)));
            }*/
            if (x>=0 && y<0) {
              svgImage = abi.encodePacked(svgImage,' l ',Strings.toString(uint(x)),', -',Strings.toString(uint(y)));
            }
            //svgImage = abi.encodePacked(svgImage,'A 20,20 0,0,1 50,30 A 20,20 0,0,1 90,30 Q 90,60 50,90 Q 10,60 10,30 z');
            }
        }



          //svg = abi.encodePacked(svg,path[i]);
        }
        svg = abi.encodePacked(svgBegin,svgImage,'" /></svg>');
    }



    function tokenURI(uint tokenId) public view override returns (string memory output) {


        if (flag) {
          bytes memory svg = createSVG("F",90);
          output = string(abi.encodePacked('data:application/json;base64,', Base64.encode(bytes(string(abi.encodePacked(
              '{"name": "', img_name, '", "image": "data:image/svg+xml;base64,', Base64.encode(bytes(svg)), '"}'
          ))))));
          // output = 'https://gist.githubusercontent.com/fridolinvii/dc914735baef4e6e6932c8c4341f58b9/raw/8e94c5029402aa5fe92eef5f26295c45b52cc758/fix.json';
          // output = string(abi.encodePacked('data:application/json;base64,', Base64.encode(bytes(string(abi.encodePacked(
          //    '{"name": "Mask Bla Bla","description": "Nothing ha been revelead yet...","image": "https://app.stargaze.zone/_next/image?url=https%3A%2F%2Fres.cloudinary.com%2Fstargaze%2Fimage%2Fupload%2Fw_700%2Fvn4bnru2bjwo8o2su9fk&w=3840&q=75"}'
              //'{"name": "', img_name, '", "image": "https://app.stargaze.zone/_next/image?url=https%3A%2F%2Fres.cloudinary.com%2Fstargaze%2Fimage%2Fupload%2Fw_700%2Fvn4bnru2bjwo8o2su9fk&w=3840&q=75"}'
          // ))))));
        } else {

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
