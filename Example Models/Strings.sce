// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.8.0) (utils/Strings.sol)

pragma solidity ^0.8.0;



/**
 * @title String Conversion
 * @dev Functions to convert between string and bytes32
 */
contract StringConversion {
	
	
	bytes32 EMPTY = 0x0; 

    /**
     * @dev Extract byte at position _at from _data.
     */
    function byteAt(bytes32 _data, uint256 _at)
        public
        pure
        virtual
        returns (bytes1)
    {
        require(_at < 32);
        uint256 result = uint256(_data);
        uint256 operation = 8 * _at;
        result = result * 2 ** operation;
        bytes32 byteresult = bytes32(result);
        return bytes1(byteresult);
    }

    /**
     * @dev Resize _bytes to a new _length. If the result is longer
     * than the original the data remains at the beginning. If the
     * result is shorter any extra bytes at the end are truncated.
     */
    function resizeBytes(bytes memory _bytes, uint256 _length)
        public
        pure
        virtual      
        returns (bytes memory)
    {
        bytes memory result = new bytes(_length);

        for (uint256 c = 0; c < _length; c++) {
        	require(msg.sender.balance >= 2300 wei);
            result[c] = _bytes[c];
        }
        return result;
    }

    /**
     * @dev Resize a bytes32 containing ascii characters, padded by 0, to a
     * bytes variable of the right size with no padding.
     */
    function trimEmptyChars(bytes32 _bytes)
        public
        pure
        virtual       
        returns (bytes memory)
    {
        bytes memory result = new bytes(32);
        uint256 charCount = 0;
        for (uint256 byteCount = 0; byteCount < 32; byteCount++) {
        	require(msg.sender.balance >= 2300 wei);            
            bytes1 _char = byteAt(_bytes, byteCount);
            if (_char == 0) {
                break;
            }
            result[charCount] = _char;
            charCount++;
        }

        return resizeBytes(result, charCount);
    }

    /**
     * @dev Convert _data from bytes32 to a string.
     */
    function bytes32ToString(bytes32 _data)
        public
        pure
        virtual
        
        returns (string memory)
    {
    	bytes32 result = trimEmptyChars(_data); 
        return string(result);
    }

    /**
     * @dev Convert _data from a string to bytes 32. Any data after
     * the 32nd byte is truncated.
     */
    function stringToBytes32(string memory _data)
        public
        pure
        virtual        
        returns (bytes32 result)
    {
    	bytes data = bytes(_data);
        if (data.length == 0) {
            return EMPTY;
        }
        // solium-disable-next-line security/no-inline-assembly
        assembly {
            result := mload(add(_data, 32))
        }
    }
}