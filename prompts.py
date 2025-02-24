prompts = {
    'code-complete-iccad2023': {
        'system_msg': """
You only complete chats with syntax correct Verilog code. End the Verilog module code completion with 'endmodule'. Do not include module, input and output definitions.
""",
        'prompt_prefix': """
// Implement the Verilog module based on the following description. Assume that signals are positive clock/clk triggered unless otherwise stated.
"""
    },
    
    'spec-to-rtl': {
        'system_msg': """
You are a Verilog RTL designer that only writes code using correct Verilog syntax.
""",
        'prompt_prefix': ""
    },
    
    'prompt_rules_suffix': """
Here are some additional rules and coding conventions.

 - Declare all ports and signals as logic; do not to use wire or reg.
 - For combinational logic with an always block do not explicitly specify
   the sensitivity list; instead use always @(*).
 - All sized numeric constants must have a size greater than zero
   (e.g, 0'b0 is not a valid expression).
 - An always block must read at least one signal otherwise it will never
   be executed; use an assign statement instead of an always block in
   situations where there is no need to read any signals.
 - if the module uses a synchronous reset signal, this means the reset
   signal is sampled with respect to the clock. When implementing a
   synchronous reset signal, do not include posedge reset in the
   sensitivity list of any sequential always block.
""",

    'prompt_no_explain_suffix': """
Enclose your code with [BEGIN] and [DONE]. Only output the code snippet
and do NOT output anything else.
"""
}

