 starkware.starkware_utils.error_handling.StarkException: (500, {'code': <StarknetErrorCode.TRANSACTION_FAILED: 44>, 'message': '/Users/danilowoohyungkim/Library/Caches/pypoetry/virtualenvs/kakarot-Ok0-2ZFD-py3.9/lib/python3.9/site-packages/starkware/cairo/common/math.cairo:371:5: Error at pc=0:153:
Got an exception while executing a hint.
    %{
    ^^
Cairo traceback (most recent call last):
/Users/danilowoohyungkim/108-Dapps-1/49.StarkPad/kakarot/src/kakarot/library.cairo:149:16: (pc=0:9191)
        return run(instructions=instructions, ctx=ctx);
               ^*************************************^
/Users/danilowoohyungkim/108-Dapps-1/49.StarkPad/kakarot/src/kakarot/library.cairo:149:16: (pc=0:9191)
        return run(instructions=instructions, ctx=ctx);
               ^*************************************^
/Users/danilowoohyungkim/108-Dapps-1/49.StarkPad/kakarot/src/kakarot/library.cairo:149:16: (pc=0:9191)
        return run(instructions=instructions, ctx=ctx);
               ^*************************************^
/Users/danilowoohyungkim/108-Dapps-1/49.StarkPad/kakarot/src/kakarot/library.cairo:149:16: (pc=0:9191)
        return run(instructions=instructions, ctx=ctx);
               ^*************************************^
/Users/danilowoohyungkim/108-Dapps-1/49.StarkPad/kakarot/src/kakarot/library.cairo:149:16: (pc=0:9191)
        return run(instructions=instructions, ctx=ctx);
               ^*************************************^
/Users/danilowoohyungkim/108-Dapps-1/49.StarkPad/kakarot/src/kakarot/library.cairo:149:16: (pc=0:9191)
        return run(instructions=instructions, ctx=ctx);
               ^*************************************^
/Users/danilowoohyungkim/108-Dapps-1/49.StarkPad/kakarot/src/kakarot/library.cairo:149:16: (pc=0:9191)
        return run(instructions=instructions, ctx=ctx);
               ^*************************************^
/Users/danilowoohyungkim/108-Dapps-1/49.StarkPad/kakarot/src/kakarot/library.cairo:149:16: (pc=0:9191)
        return run(instructions=instructions, ctx=ctx);
               ^*************************************^
/Users/danilowoohyungkim/108-Dapps-1/49.StarkPad/kakarot/src/kakarot/library.cairo:149:16: (pc=0:9191)
        return run(instructions=instructions, ctx=ctx);
               ^*************************************^
/Users/danilowoohyungkim/108-Dapps-1/49.StarkPad/kakarot/src/kakarot/library.cairo:149:16: (pc=0:9191)
        return run(instructions=instructions, ctx=ctx);
               ^*************************************^
/Users/danilowoohyungkim/108-Dapps-1/49.StarkPad/kakarot/src/kakarot/library.cairo:149:16: (pc=0:9191)
        return run(instructions=instructions, ctx=ctx);
               ^*************************************^
/Users/danilowoohyungkim/108-Dapps-1/49.StarkPad/kakarot/src/kakarot/library.cairo:149:16: (pc=0:9191)
        return run(instructions=instructions, ctx=ctx);
               ^*************************************^
/Users/danilowoohyungkim/108-Dapps-1/49.StarkPad/kakarot/src/kakarot/library.cairo:149:16: (pc=0:9191)
        return run(instructions=instructions, ctx=ctx);
               ^*************************************^
/Users/danilowoohyungkim/108-Dapps-1/49.StarkPad/kakarot/src/kakarot/library.cairo:149:16: (pc=0:9191)
        return run(instructions=instructions, ctx=ctx);
               ^*************************************^
/Users/danilowoohyungkim/108-Dapps-1/49.StarkPad/kakarot/src/kakarot/library.cairo:149:16: (pc=0:9191)
        return run(instructions=instructions, ctx=ctx);
               ^*************************************^
/Users/danilowoohyungkim/108-Dapps-1/49.StarkPad/kakarot/src/kakarot/library.cairo:136:44: (pc=0:9171)
        let ctx: model.ExecutionContext* = EVMInstructions.decode_and_execute(
                                           ^*********************************^
/Users/danilowoohyungkim/108-Dapps-1/49.StarkPad/kakarot/src/kakarot/instructions.cairo:99:9: (pc=0:8070)
        invoke(function_ptr, args_len, args);
        ^**********************************^
/Users/danilowoohyungkim/Library/Caches/pypoetry/virtualenvs/kakarot-Ok0-2ZFD-py3.9/lib/python3.9/site-packages/starkware/cairo/common/invoke.cairo:6:5: (pc=0:1083)
    call abs func_ptr;
    ^***************^
/Users/danilowoohyungkim/108-Dapps-1/49.StarkPad/kakarot/src/kakarot/instructions/memory_operations.cairo:119:37: (pc=0:5246)
        let memory: model.Memory* = Memory.store(self=ctx.memory, element=value, offset=offset.low);
                                    ^*************************************************************^
/Users/danilowoohyungkim/108-Dapps-1/49.StarkPad/kakarot/src/kakarot/memory.cairo:75:9: (pc=0:1397)
        split_int(
        ^********^

Traceback (most recent call last):
  File "/Users/danilowoohyungkim/Library/Caches/pypoetry/virtualenvs/kakarot-Ok0-2ZFD-py3.9/lib/python3.9/site-packages/starkware/cairo/common/math.cairo", line 372, in <module>
    memory[ids.output] = res = (int(ids.value) % PRIME) % ids.base
  File "/Users/danilowoohyungkim/Library/Caches/pypoetry/virtualenvs/kakarot-Ok0-2ZFD-py3.9/lib/python3.9/site-packages/starkware/cairo/lang/vm/validated_memory_dict.py", line 28, in __setitem__
    self.__memory[addr] = value
  File "/Users/danilowoohyungkim/Library/Caches/pypoetry/virtualenvs/kakarot-Ok0-2ZFD-py3.9/lib/python3.9/site-packages/starkware/cairo/lang/vm/memory_dict.py", line 199, in __setitem__
    self.verify_same_value(addr, current, value)
  File "/Users/danilowoohyungkim/Library/Caches/pypoetry/virtualenvs/kakarot-Ok0-2ZFD-py3.9/lib/python3.9/site-packages/starkware/cairo/lang/vm/memory_dict.py", line 207, in verify_same_value
    raise InconsistentMemoryError(addr, current, value)
starkware.cairo.lang.vm.memory_dict.InconsistentMemoryError: Inconsistent memory assignment at address 72:160. 160 != 1.'})