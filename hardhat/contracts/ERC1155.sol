// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC1155 {

mapping(uint256=> mapping(address=>uint256))internal _balances;
mapping (address=>mapping(address=>bool)) private _operatorApprovals;


event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
event TransferSingle(address indexed operator, address indexed _from,address _to,uint256 _id,uint256 _value);
event TransferBatch(address indexed operator, address indexed _from,address _to,uint256[] _ids,uint256[] _values);
    function balanceOf(address account, uint256 id) public  view returns(uint256){
        require(account!=address(0),"Address is not valid");
        return _balances[id][account];
    }

    function balanceOfBatch(address[] memory accounts, uint256[] memory ids) public view returns(uint256[] memory){
        require(accounts.length==ids.length,"Accounts and ids are not same length");    
        uint256[] memory batchBalances = new uint256[](accounts.length);

        for(uint256 i=0; i<accounts.length; i++){
            batchBalances[i] =balanceOf(accounts[i],ids[i]);
        }
        return batchBalances;
    }

     function setApprovalForAll(address _operator,bool _approved)external{
        _operatorApprovals[msg.sender][_operator] = _approved;
        emit ApprovalForAll(msg.sender,_operator,_approved);
    }

    function isApprovedForAll(address _owner,address _operator)public view returns(bool){
        return _operatorApprovals[_owner][_operator];

    }
    function _transfer(address from, address to, uint256 id,uint256 amount)private{
        uint256 fromBalance=_balances[id][from];
        require(fromBalance>=amount, "Insufficient balance");
        _balances[id][from] = fromBalance-amount;
        _balances[id][to] += amount;
    }
    function safeTransferFrom(address from, address to, uint256 id, uint256 amount, bytes calldata _data)external{
        require(msg.sender== from || isApprovedForAll(from,msg.sender), "msg.sender is not the operator or owner");
        require(to != address(0),"Address is 0 address");
        _transfer(from,to,id,amount);
        emit TransferSingle(msg.sender, from,to,id,amount);

        require(_checkOnERC1155Received(), "Receiver is not implemented");
 
    }
    function _checkOnERC1155Received()private pure returns(bool){
        return true;
    }

    function safeBatchTransferFrom(address from, address to, uint256[] memory ids, uint256[] memory amounts, bytes calldata _data)external{
        require(msg.sender== from || isApprovedForAll(from,msg.sender), "msg.sender is not the operator or owner");
        require(to != address(0),"Address is 0 address");
        require(ids.length==amounts.length,"Ids and amounts should be of same length");

        for(uint256 i=0; i<ids.length; i++){
            uint256 id=ids[i];
            uint256 amount=amounts[i];
            
            _transfer (from,to,id,amount);    
        }
        emit TransferBatch(msg.sender, from, to, ids, amounts);
        require(_checkOnBatchERC1155Received(),"Receiver is not implemented");
    }
     function _checkOnBatchERC1155Received()private pure returns(bool){
        return true;
    }

    function supportsInterface(bytes4 interfaceId)public pure virtual returns (bool){
        return interfaceId == 0xd9b67a26;


    }



}
