pragma solidity ^0.4.0;

contract ItemListContract {
    
    struct item {
        bytes iname;
        uint16 itemid;
        bytes icode;
        uint ivalue;
    }

    uint itemCount;
    mapping(bytes => item) itemList;
    item[] itemArray;


    function addItem(bytes name, uint16 iid, bytes code, uint val)  public{        
        var itemnew = item(name, iid ,code, val);  
        // log0(itemnew);
        itemList[code] = itemnew;
        itemArray.push(itemnew);
        itemCount++;
    }

    function countItemList() public  returns (uint count) {     
        return itemCount;
    }

    function removeItem(bytes code) public {
        delete itemList[code];
        itemCount--; 
    }

    function getItem(bytes code) public  constant returns (bytes iname, uint val) {   
        return (itemList[code].iname, itemList[code].ivalue);
    }
}