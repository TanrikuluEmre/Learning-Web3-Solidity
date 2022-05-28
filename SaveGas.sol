// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

    // Baslangic - 50908 gas
    // memory yerine calldata - 49163 gas
    // _total'i fonk. icinde kullanip sonra total degiskenine esitledik - 48952 gas
    // bool'ları silip if'in içine koşulları yazdık - 48634 gas
    // i+=1 yerine ++i yazdık - 48226 gas
    // nums.length'i len degiskenine atayip kullandik - 48209 gas
    // num degiskeni tanimlayip nums[i]'ye esitledik ve _total'e onu ekledik - 48047 gas
    
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

        for (uint i = 0; i < len; ++i) {
            uint num = nums[i];
            if (num % 2 == 0 && num < 99) {
                _total += num;
            }
        }

        total = _total;
    }
    
   
}
