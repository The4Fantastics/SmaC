pragma solidity ^0.4.21;

contract EternalStorage {

    address owner = msg.sender;
    address latestVersion;

    mapping(bytes32 => uint) uIntStorage;
    mapping(bytes32 => string) stringStorage;
    mapping(bytes32 => address ) addressStorage;
    mapping(bytes32 => bytes) bytesStorage;
    mapping(bytes32 => bool) boolStorage;
    mapping(bytes32 => int) intStorage;

    modifier onlyLatestVersion() { 
       require(msg.sender == latestVersion);
        _;
    }

    function upgradeVersion(address _newVersion) public {
        require(msg.sender == owner);
        latestVersion = _newVersion;
    }

    // *** Getter Methods ***
    function getUint(bytes32 _key) external view returns(uint) {
        return uIntStorage[_key];
    }

    function getString(bytes32 _key) external view returns(string) {
        return stringStorage[_key];
    }

    function getAddress(bytes32 _key) external view returns(address ) {
        return addressStorage[_key];
    }

    function getBytes(bytes32 _key) external view returns(bytes) {
        return bytesStorage[_key];
    }

    function getBool(bytes32 _key) external view returns(bool) {
        return boolStorage[_key];
    }

    function getInt(bytes32 _key) external view returns(int) {
        return intStorage[_key];
    }

    // *** Setter Methods ***
    function setUint(bytes32 _key, uint _value) external  onlyLatestVersion {
        uIntStorage[_key] = _value;
    }

    function setString(bytes32 _key, string _value) external  onlyLatestVersion {
        stringStorage[_key] = _value;
    }

    function setAddress(bytes32 _key, address _value) external onlyLatestVersion  {
        addressStorage[_key] = _value;
    }

    function setBytes(bytes32 _key, bytes _value)  external onlyLatestVersion{
        bytesStorage[_key] = _value;
    }

    function setBool(bytes32 _key, bool _value)  external onlyLatestVersion{
        boolStorage[_key] = _value;
    }

    function setInt(bytes32 _key, int _value)  external onlyLatestVersion {
        intStorage[_key] = _value;
    }

    // *** Delete Methods ***
    function deleteUint(bytes32 _key)  external onlyLatestVersion {
        delete uIntStorage[_key];
    }

    function deleteString(bytes32 _key)  external onlyLatestVersion {
        delete stringStorage[_key];
    }

    function deleteAddress(bytes32 _key)  external onlyLatestVersion{
        delete addressStorage[_key];
    }

    function deleteBytes(bytes32 _key)  external onlyLatestVersion {
        delete bytesStorage[_key];
    }

    function deleteBool(bytes32 _key)  external onlyLatestVersion{
        delete boolStorage[_key];
    }

    function deleteInt(bytes32 _key)  external onlyLatestVersion{
        delete intStorage[_key];
    }
}