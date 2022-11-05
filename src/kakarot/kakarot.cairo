// SPDX-License-Identifier: MIT

%lang starknet

// Starkware dependencies
from starkware.cairo.common.cairo_builtins import HashBuiltin, BitwiseBuiltin
from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.math_cmp import is_not_zero
from starkware.cairo.common.alloc import alloc


// Local dependencies
from kakarot.library import Kakarot, evm_contract_deployed
from kakarot.model import model
from kakarot.stack import Stack
from kakarot.memory import Memory
from kakarot.interfaces.interfaces import IEvm_Contract


// Constructor
@constructor
func constructor{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}(owner: felt, native_token_address_: felt, evm_contract_class_hash: felt) {
    return Kakarot.constructor(owner, native_token_address_, evm_contract_class_hash);
}

@view
func execute{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}(code_len: felt, code: felt*, calldata_len: felt, calldata: felt*) -> (
    stack_len: felt, stack: Uint256*, memory_len: felt, memory: felt*, gas_used: felt
) {
    alloc_locals;
    let context = Kakarot.execute(code_len=code_len, code=code, calldata=calldata);
    let len = Stack.len(context.stack);
    return (
        stack_len=len,
        stack=context.stack.elements,
        memory_len=context.memory.bytes_len,
        memory=context.memory.bytes,
        gas_used=context.gas_used,
    );
}

// Create new function
@external
func execute_at_address{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*
}(address: felt, calldata_len: felt, calldata: felt*) -> (
    stack_len: felt, stack: Uint256*, memory_len: felt, memory: felt*, evm_contract_address: felt, starknet_contract_address: felt,return_data_len:felt, return_data: felt*) {
    alloc_locals;
    
    // Check is _to address is 0x0000..00:
    if(address == 0){
        let (stack: Uint256*) = alloc();
        let (zero_array: felt*) = alloc();
        // Deploy contract
        let (evm_contract_address:felt, starknet_contract_address:felt) = deploy(bytes_len=calldata_len,bytes=calldata);
        return (
            stack_len=0,
            stack = stack,
            memory_len=0,
            memory=zero_array,
            evm_contract_address=evm_contract_address,
            starknet_contract_address =starknet_contract_address,
            return_data_len=0,
            return_data=zero_array
        );
    }

    // Check if contract is initiated
    // let (is_initiated) = IEvm_Contract.is_initiated(contract_address=address);
    // with_attr error_message("First initiate the contract"){
    //     assert is_initiated = 1;
    // }

    // Run transaction
    let context = Kakarot.execute_at_address(address=address, calldata=calldata);

    let len = Stack.len(context.stack);

    %{
        import logging
        i = 0
        res = ""
        for i in range(ids.context.return_data_len):
            res += " " + str(memory.get(ids.context.return_data + i))
            i += i
        logging.info("*************RETURN_DATA AFTER EXECUTE_AT_ADDRESS*****************")
        logging.info(res)
        logging.info("************************************")
    %}
    return (
        stack_len=len,
        stack=context.stack.elements,
        memory_len=context.memory.bytes_len,
        memory=context.memory.bytes,
        evm_contract_address= context.evm_address,
        starknet_contract_address=context.starknet_address,
        return_data_len=context.return_data_len,
        return_data=context.return_data
    );
}

@external
func set_account_registry{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    registry_address_: felt
) {
    return Kakarot.set_account_registry(registry_address_);
}

@view
func get_account_registry{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
    address: felt
) {
    return Kakarot.get_account_registry();
}

@external
func set_native_token{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    native_token_address_: felt
) {
    return Kakarot.set_native_token(native_token_address_);
}

// @notice deploy starknet contract
// @dev starknet contract will be mapped to an evm address that is also generated within this function
// @param bytes: the contract code
// @return evm address that is mapped to the actual contract address
func deploy{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr,bitwise_ptr: BitwiseBuiltin*}(bytes_len: felt, bytes: felt*) -> (evm_contract_address: felt, starknet_contract_address: felt) {
    alloc_locals;
    let (evm_contract_address, starknet_contract_address) = Kakarot.deploy_contract(
        bytes_len, bytes
    );
    evm_contract_deployed.emit(
        evm_contract_address=evm_contract_address,
        starknet_contract_address=starknet_contract_address,
    );
    return (evm_contract_address=evm_contract_address, starknet_contract_address=starknet_contract_address);
}

// @notice deploy starknet contract
// @dev starknet contract will be mapped to an evm address that is also generated within this function
// @param bytes: the contract code
// @return evm address that is mapped to the actual contract address
@external
func initiate{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr,bitwise_ptr: BitwiseBuiltin*}(evm_address: felt, starknet_address:felt)->(evm_contract_address: felt, starknet_contract_address: felt){
    alloc_locals;
    // let (array : felt*) = alloc();
    //Check if it it inisiated
    // let (is_initiated) = IEvm_Contract.is_initiated(contract_address=starknet_address);
    // with_attr error_message("Contract already initiated"){
    //     assert is_initiated = 0;
    // }

    // let (registry_address_) = registry_address.read();
    // let (starknet_address) = IRegistry.get_starknet_address(
    //         contract_address=registry_address_, evm_address=address
    // );

    // Get constructor and runtime code
    let (bytecode_len, bytecode) = IEvm_Contract.code(contract_address=starknet_address);

    //Run bytecode
    let context : model.ExecutionContext* = Kakarot.execute_at_address(address=evm_address,calldata=bytecode);

    // Update evm_contract code
    IEvm_Contract.store_code(contract_address=context.starknet_address, code_len=context.return_data_len, code=context.return_data);

    //Call Kakarot.initiate function

    %{
        import logging
        i = 0
        res = ""
        for i in range(ids.context.return_data_len):
            res += " " + str(memory.get(ids.context.return_data + i))
            i += i
        logging.info("*************RETURN DATA DURING INITIATION*****************")
        logging.info(res)
        logging.info("************************************")
    %}

    return (evm_contract_address=context.evm_address,starknet_contract_address=context.starknet_address);
}
