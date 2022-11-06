// SPDX-License-Identifier: MIT

%lang starknet

// Starkware dependencies

from starkware.cairo.common.cairo_builtins import HashBuiltin, BitwiseBuiltin
from starkware.cairo.common.bool import TRUE, FALSE
from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.math_cmp import is_le_felt
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.memcpy import memcpy

// Internal dependencies
from kakarot.model import model
from utils.utils import Helpers
from kakarot.execution_context import ExecutionContext
from kakarot.stack import Stack

// @title System operations opcodes.
// @notice This file contains the functions to execute for system operations opcodes.
// @author @abdelhamidbakhta
// @custom:namespace SystemOperations
namespace SystemOperations {
    // @notice INVALID operation.
    // @dev Designated invalid instruction.
    // @custom:since Frontier
    // @custom:group System Operations
    // @custom:gas NaN
    // @custom:stack_consumed_elements 0
    // @custom:stack_produced_elements 0
    // @return The pointer to the updated execution context.
    func exec_invalid{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr,
        bitwise_ptr: BitwiseBuiltin*,
    }(ctx: model.ExecutionContext*) -> model.ExecutionContext* {
        %{
            import logging
            logging.info("0xFE - INVALID")
        %}
        with_attr error_message("Kakarot: 0xFE: Invalid Opcode") {
            assert TRUE = FALSE;
        }
        // TODO: map the concept of consuming all the gas given to the context

        return ctx;
    }

    // @notice RETURN operation.
    // @dev Designated invalid instruction.
    // @custom:since Frontier
    // @custom:group System Operations
    // @custom:gas NaN
    // @custom:stack_consumed_elements 0
    // @custom:stack_produced_elements 0
    // @return The pointer to the updated execution context.
    func exec_return{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr,
        bitwise_ptr: BitwiseBuiltin*,
    }(ctx: model.ExecutionContext*) -> model.ExecutionContext* {
        alloc_locals;
        let stack = ctx.stack;
        let memory = ctx.memory;
        %{
            import logging
            logging.info("0xF3 - RETURN")
        %}
        
        let (local new_return_data: felt*) = alloc();
        let (local new_memory: model.Memory*) = alloc();
        let (stack, offset) = Stack.pop(stack);
        let (stack, size) = Stack.pop(stack);
        let curr_memory_len: felt = ctx.memory.bytes_len;
        let total_len: felt = offset.low + size.low;
        // TODO check in which multiple of 32 bytes it should be.
        // Pad if offset + size > memory_len pad n
        // %{
        //     import logging
        //     logging.info("RETURN SETUP 1")
        //     logging.info("Curr memory Len")
        //     logging.info(ids.curr_memory_len)
        // %}
        if (memory.bytes_len == 0) {
            Helpers.fill(arr=memory.bytes, value=0, length=32);
        }

        memcpy(dst=new_return_data, src=ctx.memory.bytes + offset.low, len=size.low);
        // Pad if offset + size > memory_len pad n
        let is_total_greater_than_memory_len: felt = is_le_felt(curr_memory_len, total_len);
        // let is_total_greater_than_memory_len: felt = 0;
        // %{
        //     import logging
        //     logging.info("RETURN SETUP 2")
        //     logging.info("new_return_data")
        //     logging.info(ids.new_return_data)
        //     logging.info("total_len")
        //     logging.info(ids.total_len)
        //     logging.info("curr_memory_len")
        //     logging.info(ids.curr_memory_len)
        //     logging.info("Is total smaller than memory_len")
        //     logging.info(ids.is_total_greater_than_memory_len)
        // %}
        if (is_total_greater_than_memory_len == 1) {
            local diff = total_len - curr_memory_len;
            Helpers.fill(arr=new_return_data + curr_memory_len, value=0, length=diff);
        }
        // %{
        //     import logging
        //     logging.info("RETURN SETUP 3")
        //     logging.info("RETURN LEN BEFORE UPDATE")
        //     logging.info(ids.size.low)
        //     logging.info("RETURN DATA BEFORE UPDATE")
        //     logging.info(ids.new_return_data)
        // %}
        // TODO if memory.bytes_len == 0 needs a different approach
        // tempvar new_memory = new model.Memory(bytes=memory.bytes, bytes_len=memory.bytes_len);
        // tempvar new_return_data = new 
        // let ctx = ExecutionContext.update_return_data(ctx, size.low,new_return_data);
        let ctx = ExecutionContext.update_stack(ctx, stack);
        // let test_var : felt = Helpers.get_len(new_return_data);

        // %{
        //     import logging
        //     logging.info("RETURN SETUP 4")
        //     logging.info("RETURN LEN AFTER UPDATE")
        //     logging.info(ids.test_var)
        //     logging.info("RETURN DATA BEFORE UPDATE")
        //     logging.info(ids.ctx.return_data)
        //     i = 0
        //     res = ""
        //     for i in range(ids.ctx.return_data_len):
        //     res += " " + str(memory.get(ids.new_return_data + i))
        //     i += i
        //     logging.info("*************RETURN DATA****************")
        //     logging.info(res)
        //     logging.info("************************************")
        // %}

        // TODO: GAS IMPLEMENTATION

        return ExecutionContext.update_return_data(
            ctx, new_return_data_len=size.low, new_return_data=new_return_data
        );
    }

    // @notice REVERT operation.
    // @dev Designated invalid instruction.
    // @custom:since Frontier
    // @custom:group System Operations
    // @custom:gas NaN
    // @custom:stack_consumed_elements 0
    // @custom:stack_produced_elements 0
    // @return The pointer to the updated execution context.
    func exec_revert{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr,
        bitwise_ptr: BitwiseBuiltin*,
    }(ctx: model.ExecutionContext*) -> model.ExecutionContext* {
        %{
            import logging
            logging.info("0xFD - REVERT")
        %}
        with_attr error_message("Kakarot: 0xFD: REVERT - Transaction Failed") {
            assert TRUE = FALSE;
        }
        // TODO: consume gas up until this point

        return ctx;
    }
}


