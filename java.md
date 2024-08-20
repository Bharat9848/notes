JAVA Bytecode.

1.aload_0
This opcode is one of a group of opcodes with the format aload_<n>. They all load an object reference into the operand stack. The <n> refers to the location in the local variable array that is being accessed but can only be 0, 1, 2 or 3. There are other similar opcodes for loading values that are not an object reference iload_<n>, lload_<n>, float_<n> and dload_<n> where i is for int, l is for long, f is for float and d is for double. Local variables with an index higher than 3 can be loaded using iload, lload, float, dload and aload. These opcodes all take a single operand that specifies the index of local variable to load.
2.ldc
This opcode is used to push a constant from the run time constant pool into the operand stack.

3.getstatic
This opcode is used to push a static value from a static field listed in the run time constant pool into the operand stack.

4.invokespecial, invokevirtual
These opcodes are in a group of opcodes that invoke methods these are invokedynamic, invokeinterface, invokespecial, invokestatic, invokevirtual. In this class file invokespecial and invokevirutal are both used the difference between these is that invokevirutal invokes a method based on the class of the object. The invokespecial instruction is used to invoke instance initialization methods as well as private methods and methods of a superclass of the current class.

invokestatic / iadd / ireturn /invokevirtual java bytecode command pops from operand stack multiple times based on argument it need to invoke command's method. 

5.return
This opcode is in a group of opcodes ireturn, lreturn, freturn, dreturn, areturn and return. Each of these opcodes are a typed return statement that returns a different type where i is for int, l is for long, f is for float, d is for double and a is for an object reference. The opcode with no leading type letter return only returns void.


iconst_X / iload_X / getstatic java bytecode command store value in operand stack.

istore pop the return value from operand stack and set it to crossponding local variable array location.

Java 7
 - Read about phasers
 - read about fork-join


JAVA 8
1. Instead of hunting enums usage in your code every time you add new enum constant, move your enum logic in enum class itself as a propery (which can be a Method reference) or (abstract) functions. This will prevent any accidental logic left out for your new enum constant.

2. Template Pattern can be replaced with more readable Loan pattern. Loan pattern can be seen as wherein a resource(e.g. File) has passed on to some specific logic to run on it.

