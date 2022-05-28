// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract GasSaving {
   
    uint public total;

    function withoutSaveGas(uint[] memory nums) external{
        for(uint i=0;i<nums.length;i+=1){
            bool isEven = nums[i] % 2 == 0;
            bool isLessThan99 = nums[i]<99;
            if(isEven && isLessThan99){
                total += nums[i];
            }
        }
    }

    function saveGas(uint[] calldata nums) external {
        uint _total = total;
        uint len = nums.length;

        for (uint i = 0; i < len; i=unchecked_inc(i)) {
            uint num = nums[i];
            if (num % 2 == 0 && num < 99) {
                _total += num;
            }
        }

        total = _total;
    }
    
    function unchecked_inc(uint i) internal pure returns(uint){
      unchecked {
        ++i;
      }
      return i;
    }
}
