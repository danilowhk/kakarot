// SPDX-License-Identifier: MIT

%lang starknet

// Starkware dependencies

from starkware.cairo.common.cairo_builtins import HashBuiltin, BitwiseBuiltin

from starkware.starknet.common.syscalls import get_block_number, get_block_timestamp
from starkware.cairo.common.uint256 import Uint256

// Internal dependencies
from kakarot.model import model
from utils.utils import Helpers
from kakarot.execution_context import ExecutionContext
from kakarot.stack import Stack
from kakarot.constants import Constants, native_token_address
from kakarot.interfaces.interfaces import IEth

// @title BlockInformation information opcodes.
// @notice This file contains the functions to execute for block information opcodes.
// @author @abdelhamidbakhta
// @custom:namespace BlockInformation
namespace BlockInformation {
    // Define constants.
    const GAS_COST_COINBASE = 2;
    const GAS_COST_TIMESTAMP = 2;
    const GAS_COST_NUMBER = 2;
    const GAS_COST_DIFFICULTY = 2;
    const GAS_COST_GASLIMIT = 2;
    const GAS_COST_CHAINID = 2;
    const GAS_COST_SELFBALANCE = 5;
    const GAS_COST_BASEFEE = 2;

    // @notice COINBASE operation.
    // @dev Get the block's beneficiary address.
    // @custom:since Frontier
    // @custom:group Block Information
    // @custom:gas 2
    // @custom:stack_consumed_elements 0
    // @custom:stack_produced_elements 1
    // @param ctx The pointer to the execution context
    // @return The pointer to the updated execution context.
    func exec_coinbase{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr,
        bitwise_ptr: BitwiseBuiltin*,
    }(ctx: model.ExecutionContext*) -> model.ExecutionContext* {
        %{
            import logging
            logging.info("0x41 - COINBASE")
        %}
        // Get the coinbase address.
        // TODO: switch to real coinbase addr when going to prod
        let coinbase_address = Helpers.to_uint256(val=Constants.MOCK_COINBASE_ADDRESS);
        let stack: model.Stack* = Stack.push(self=ctx.stack, element=coinbase_address);

        // Update the execution context.
        // Update context stack.
        let ctx = ExecutionContext.update_stack(self=ctx, new_stack=stack);
        // Increment gas used.
        let ctx = ExecutionContext.increment_gas_used(self=ctx, inc_value=GAS_COST_COINBASE);
        return ctx;
    }

    // @notice TIMESTAMP operation.
    // @dev Get the block’s timestamp
    // @custom:since Frontier
    // @custom:group Block Information
    // @custom:gas 2
    // @custom:stack_consumed_elements 0
    // @custom:stack_produced_elements 1
    // @param ctx The pointer to the execution context
    // @return The pointer to the updated execution context.
    func exec_timestamp{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr,
        bitwise_ptr: BitwiseBuiltin*,
    }(ctx: model.ExecutionContext*) -> model.ExecutionContext* {
        alloc_locals;
        %{
            import logging
            logging.info("0x42 - TIMESTAMP")
        %}
        // Get the block’s timestamp
        let (current_timestamp) = get_block_timestamp();
        let block_timestamp = Helpers.to_uint256(val=current_timestamp);

        let stack: model.Stack* = Stack.push(self=ctx.stack, element=block_timestamp);

        // Update the execution context.
        // Update context stack.
        let ctx = ExecutionContext.update_stack(self=ctx, new_stack=stack);
        // Increment gas used.
        let ctx = ExecutionContext.increment_gas_used(self=ctx, inc_value=GAS_COST_TIMESTAMP);
        return ctx;
    }

    // @notice NUMBER operation.
    // @dev Get the block number
    // @custom:since Frontier
    // @custom:group Block Information
    // @custom:gas 2
    // @custom:stack_consumed_elements 0
    // @custom:stack_produced_elements 1
    // @param ctx The pointer to the execution context
    // @return The pointer to the updated execution context.
    func exec_number{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr,
        bitwise_ptr: BitwiseBuiltin*,
    }(ctx: model.ExecutionContext*) -> model.ExecutionContext* {
        alloc_locals;
        %{
            import logging
            logging.info("0x43 - NUMBER")
        %}
        // Get the block number.
        let (current_block) = get_block_number();
        let block_number = Helpers.to_uint256(val=current_block);

        let stack: model.Stack* = Stack.push(self=ctx.stack, element=block_number);

        // Update the execution context.
        // Update context stack.
        let ctx = ExecutionContext.update_stack(self=ctx, new_stack=stack);
        // Increment gas used.
        let ctx = ExecutionContext.increment_gas_used(self=ctx, inc_value=GAS_COST_NUMBER);
        return ctx;
    }

    // @notice DIFFICULTY operation.
    // @dev Get Difficulty
    // @custom:since Frontier
    // @custom:group Block Information
    // @custom:gas 2
    // @custom:stack_consumed_elements 0
    // @custom:stack_produced_elements 1
    // @param ctx The pointer to the execution context
    // @return The pointer to the updated execution context.
    func exec_difficulty{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr,
        bitwise_ptr: BitwiseBuiltin*,
    }(ctx: model.ExecutionContext*) -> model.ExecutionContext* {
        %{
            import logging
            logging.info("0x44 - DIFFICULTY")
        %}

        // Get the Difficulty.
        let difficulty = Helpers.to_uint256(val=0);

        let stack: model.Stack* = Stack.push(self=ctx.stack, element=difficulty);

        // Update the execution context.
        // Update context stack.
        let ctx = ExecutionContext.update_stack(self=ctx, new_stack=stack);
        // Increment gas used.
        let ctx = ExecutionContext.increment_gas_used(self=ctx, inc_value=GAS_COST_DIFFICULTY);
        return ctx;
    }

    // @notice GASLIMIT operation.
    // @dev Get gas limit
    // @custom:since Frontier
    // @custom:group Block Information
    // @custom:gas 2
    // @custom:stack_consumed_elements 0
    // @custom:stack_produced_elements 1
    // @param ctx The pointer to the execution context
    // @return The pointer to the updated execution context.
    func exec_gaslimit{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr,
        bitwise_ptr: BitwiseBuiltin*,
    }(ctx: model.ExecutionContext*) -> model.ExecutionContext* {
        %{
            import logging
            logging.info("0x45 - GASLIMIT")
        %}
        // Get the Gas Limit
        let gas_limit = Helpers.to_uint256(val=ctx.gas_limit);
        let stack: model.Stack* = Stack.push(self=ctx.stack, element=gas_limit);

        // Update the execution context.
        // Update context stack.
        let ctx = ExecutionContext.update_stack(self=ctx, new_stack=stack);
        // Increment gas used.
        let ctx = ExecutionContext.increment_gas_used(self=ctx, inc_value=GAS_COST_GASLIMIT);
        return ctx;
    }

    // @notice CHAINID operation.
    // @dev Get the chain ID.
    // @custom:since Instanbul
    // @custom:group Block Information
    // @custom:gas 2
    // @custom:stack_consumed_elements 0
    // @custom:stack_produced_elements 1
    // @param ctx The pointer to the execution context
    // @return The pointer to the updated execution context.
    func exec_chainid{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr,
        bitwise_ptr: BitwiseBuiltin*,
    }(ctx: model.ExecutionContext*) -> model.ExecutionContext* {
        %{
            import logging
            logging.info("0x46 - CHAINID")
        %}
        // Get the chain ID.
        let chain_id = Helpers.to_uint256(val=Constants.CHAIN_ID);
        let stack: model.Stack* = Stack.push(self=ctx.stack, element=chain_id);

        // Update the execution context.
        // Update context stack.
        let ctx = ExecutionContext.update_stack(self=ctx, new_stack=stack);
        // Increment gas used.
        let ctx = ExecutionContext.increment_gas_used(self=ctx, inc_value=GAS_COST_CHAINID);
        return ctx;
    }

    // @notice SELFBALANCE operation.
    // @dev Get balance of currently executing contract
    // @custom:since Istanbul
    // @custom:group Block Information
    // @custom:gas 5
    // @custom:stack_consumed_elements 0
    // @custom:stack_produced_elements 1
    // @param ctx The pointer to the execution context
    // @return The pointer to the updated execution context.
    func exec_selfbalance{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr,
        bitwise_ptr: BitwiseBuiltin*,
    }(ctx: model.ExecutionContext*) -> model.ExecutionContext* {
        alloc_locals;
        %{
            import logging
            logging.info("0x47 - SELFBALANCE")
        %}
        // Get balance of current executing contract address balance and push to stack.
        let (native_token_address_) = native_token_address.read();
        let (balance: Uint256) = IEth.balanceOf(
            contract_address=native_token_address_, account=ctx.starknet_address
        );
        let stack: model.Stack* = Stack.push(self=ctx.stack, element=balance);

        // Update the execution context.
        // Update context stack.
        let ctx = ExecutionContext.update_stack(self=ctx, new_stack=stack);
        // Increment gas used.
        let ctx = ExecutionContext.increment_gas_used(self=ctx, inc_value=GAS_COST_SELFBALANCE);
        return ctx;
    }

    // @notice BASEFEE operation.
    // @dev Get base fee
    // @custom:since Frontier
    // @custom:group Block Information
    // @custom:gas 2
    // @custom:stack_consumed_elements 0
    // @custom:stack_produced_elements 1
    // @param ctx The pointer to the execution context
    // @return The pointer to the updated execution context.
    func exec_basefee{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr,
        bitwise_ptr: BitwiseBuiltin*,
    }(ctx: model.ExecutionContext*) -> model.ExecutionContext* {
        %{
            import logging
            logging.info("0x48 - BASEFEE")
        %}

        // Get the base fee.
        let basefee = Helpers.to_uint256(val=0);

        let stack: model.Stack* = Stack.push(self=ctx.stack, element=basefee);

        // Update the execution context.
        // Update context stack.
        let ctx = ExecutionContext.update_stack(self=ctx, new_stack=stack);
        // Increment gas used.
        let ctx = ExecutionContext.increment_gas_used(self=ctx, inc_value=GAS_COST_BASEFEE);
        return ctx;
    }
}
