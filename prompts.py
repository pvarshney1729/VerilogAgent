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
    
    'prompt_rules': """


The following plan/guidelines might be useful for generating the correct Verilog code:
<Guidelines>
- Ensure synchronous reset is implemented as specified.
- Initialize all flip-flops and inputs to zero in simulation, unless provided the specified initial values in the question.s
- Adhere strictly to the provided interface and signal names.
- Generate results in the specified cycle timing.
- Handle bitwise operations and signal broadcasting correctly.
</Guidelines>

Here are some additional rules and coding conventions.
<Coding Conventions>
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
</Coding Conventions>

<REASONING>
Your reasoning behind your implementation here. Think step by step.
</REASONING>

<CODE>
IMPORTANT: Enclose your code with [BEGIN] and [DONE] tags.
Do NOT use Markdown code blocks (```) inside the [BEGIN]/[DONE] tags.
Your code should look like:

[BEGIN]
module TopModule(
    input in,
    output out
);
    // Your implementation here
endmodule
[DONE]
</CODE>

PLEASE USE XML TAGS provided to enclose your response!
""",


'enhance_spec_system': """You are an expert in formal hardware design specification and Verilog implementation. Your task is to analyze user-provided specifications for digital logic circuits and rewrite them by improving clarity.""",

'enhance_spec_rules': """You should NOT change the functional intent of the specification but should refine it to ensure correctness in implementation. 

You MAY/MAY NOT edit or add more details to the original specification to ensure correctness in implementation. You can:
- Define input/output port widths, signedness, and naming conventions.
- Specify MSB/LSB conventions and bit indexing (e.g., "bit[0] refers to the least significant bit").
- Distinguish combinational vs. sequential logic and define clock cycle relationships.
- State whether resets are synchronous or asynchronous and the reset state of all registers.
- Ensure all flip-flops, registers, and sequential elements have explicitly defined initial values.
- Clarify signal dependencies, precedence of operations, and potential race conditions.
- Where Karnaugh maps, truth tables, FSMs, or bitwise operations are involved, provide both textual and formal mathematical descriptions.
- Specify behavior at edge cases and input boundaries.

Given the following user specification for a Verilog module, rewrite it between <ENHANCED_SPEC> tags.

Original Specification:
{user_spec}

<ENHANCED_SPEC>
[Provide the rewritten specification here using the enhancementguidelines above. DO NOT WRITE DOWN YOUR VERILOG IMPLEMENTATION FOR THE MODULE.]
</ENHANCED_SPEC>

Remember that you're task is not to completely change the specification itself but only to improve it for clarity.
DO NOT include any explanations, notes, or text outside the <ENHANCED_SPEC> tags. Return ONLY the rewritten specification.
""",

'decomposition_system_prompt': """You are an expert Verilog RTL designer engineer that can break down complicated implementations into subtasks.""",

'decomposition_prompt': """
<Target Problem>
{spec}
</Target Problem>
<Instructions>
-Let's think step by step.
-Based on the Problem description, set up an implementation plan: each subtask should focus on implementing only one logical component at a time.
-Extract the corresponding source contexts in the [Target Problem] section of each subtask into the 'source' field.
-The task id number indicates the sequential orders.
-For shift registers and LFSR designs, clearly separate shift operations from feedback operations.
-For Galois LFSR specifically, ensure proper understanding of right-shift behavior and tap feedback mechanism.
</Instructions>
IMPORTANT: Return ONLY a valid JSON object with this EXACT structure:
{{
 "subtasks": [
{{
 "id": "1",
 "content": "task description 1",
 "source": "source 1"
}},
{{
 "id": "2",
 "content": "task description 2",
 "source": "source 2"
}},
 ....
}}
EXAMPLE:
For a Galois LFSR problem, your response might be:
{{
 "subtasks": [
{{
 "id": "1",
 "content": "Define the module interface with clock, reset, and output signals",
 "source": "I would like you to implement a module named TopModule with input clk, reset, and output q (32 bits)"
}},
{{
 "id": "2",
 "content": "Create a combinational block to calculate the next state by first shifting right and then applying XOR feedback to tap positions",
 "source": "A Galois LFSR is one particular arrangement that shifts right, where a bit position with a tap is XORed with the LSB output bit (q[0]) to produce its next value, while bit positions without a tap shift right unchanged"
}},
{{
 "id": "3",
 "content": "Implement the sequential logic with synchronous reset to update the LFSR state",
 "source": "Reset should be active high synchronous, and should reset the output q to 32'h1. Assume all sequential logic is triggered on the positive edge of the clock"
}}
 ]
}}
[Rules]
Make sure the task plans satisfy the following rules:
1. FSM and Sequential Design Rules:
 - Define state encoding using localparam or parameter, not typedef enum, unless SystemVerilog is explicitly specified
 - Always separate sequential designs into distinct components:
   a) State/data register with reset logic
   b) Next state/data combinational logic
   c) Output combinational logic (if needed)
 - For LFSR implementations, clearly separate the shift operation from feedback application

2. Asynchronous vs Synchronous Reset:
 - For asynchronous reset, use: always @(posedge clk or posedge reset)
 - For synchronous reset, use: always @(posedge clk)
 - Never include reset in sensitivity list for synchronous reset

3. Signal Declaration Rules:
 - Use 'logic' type ONLY if SystemVerilog is specified, otherwise use 'reg' and 'wire'
 - Always use 'reg' for signals assigned in always blocks
 - Always use 'wire' for signals assigned with assign statements
 - For intermediate calculations, use separate signals rather than complex expressions

4. Coding Style Rules:
 - Use always @(*) for combinational logic, not always_comb unless SystemVerilog is specified
 - Never use 0'b0 - all sized numeric constants must be at least 1 bit (1'b0)
 - Always include default case in case statements
 - Use consistent naming across all subtasks (do not change signal names between subtasks)
 - Provide complete, compilable code segments, not theoretical descriptions

5. LFSR-Specific Rules:
 - For Galois LFSR, implement the correct shift direction (typically right shift)
 - Apply XOR feedback ONLY to the specified tap positions
 - Ensure taps are correctly indexed according to the specification
 - Use separate steps for shift and feedback calculation for clarity

6. Other Important Rules:
 - Do not plan the implementation of logic or signal from the input ports
 - Do not generate testbench code
 - Don't make a plan only with clock or control signals
 - Don't implement signals not related to module outputs
 - If state/current_state is an input port, do NOT implement state flip-flops
DO NOT include any explanations, notes, or text outside the JSON structure. Return ONLY the JSON object.
""",
# Generate implementation for this subtask
  'implementation_system_prompt': """You are a Verilog RTL designer that only writes code using correct Verilog syntax.""",
  
  'implementation_prompt': """
  Implement the following Verilog subtask:
  
  TASK: {subtask_content}
  
  CONTEXT FROM SPECIFICATION:
  {subtask_source}
  
  FULL SPECIFICATION:
  {spec}
  
  Provide ONLY the Verilog code snippet that implements this specific subtask. Do not implement the entire module.
  Focus only on the specific signals, registers, or logic described in the task.
  
  Enclose your code with [BEGIN] and [DONE]. Only output the code snippet and do NOT output anything else.
  """
        
}

