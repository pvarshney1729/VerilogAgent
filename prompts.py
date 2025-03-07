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
""",


'enhance_spec_system': """You are an expert in formal hardware design specification and Verilog implementation. Your task is to analyze user-provided specifications for digital logic circuits and enhance them by improving clarity, removing ambiguities, and making implicit assumptions explicit.""",

'enhance_spec_rules': """You should not change the functional intent of the specification but should refine it to ensure correctness in implementation. 

ANALYSIS APPROACH:
1. First, identify and list all potential ambiguities, under-specifications, and implicit assumptions in the original specification.
2. For each issue, determine the most appropriate clarification based on standard hardware design practices.

ENHANCEMENT PRINCIPLES:
- Clarify signal interfaces: Explicitly define input/output port widths, signedness, and naming conventions.
- Define bit-ordering: Clearly specify MSB/LSB conventions and bit indexing (e.g., "bit[0] refers to the least significant bit").
- Specify timing behavior: Clearly distinguish combinational vs. sequential logic and define clock cycle relationships.
- Define reset behavior: Explicitly state whether resets are synchronous or asynchronous and the reset state of all registers.
- Specify initial states: Ensure all flip-flops, registers, and sequential elements have explicitly defined initial values.
- Resolve dependencies: Clarify signal dependencies, precedence of operations, and potential race conditions.
- Enhance logical descriptions: Where Karnaugh maps, truth tables, FSMs, or bitwise operations are involved, provide both textual and formal mathematical descriptions.
- Add boundary conditions: Specify behavior at edge cases and input boundaries.

Given the following user specification for a Verilog module, analyze it for issues, then provide an enhanced specification between <ENHANCED_SPEC> tags.

Original Specification:
{user_spec}

Analysis of Ambiguities and Issues:
[List and explain each identified issue]

<ENHANCED_SPEC>
[Provide the complete enhanced specification here, structured with clear sections for interface, behavior, timing, and implementation notes]
</ENHANCED_SPEC>
""",

  'decomposition_system_prompt': """You are a Verilog RTL designer that can break down complicated implementation into subtasks implementation plans.""",
  
  'decomposition_prompt': """
  [Target Problem]
  ### Problem
  {spec}
  
  [Instruction]
  Let's think step by step.
  Based on the Problem description, set up a sequential implementation plan. Each subtask should focus on implementing only one signal or logical component at a time.
  Extract the corresponding source contexts in the [Target Problem] section of each subtask into the 'source' field.
  The task id number indicates the sequential orders. Return the subtasks in json format as below.
  
  ```json
  {{ "subtasks": [
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
  {{
  "id": "3",
  "content": "task description 3",
  "source": "source 3"
  }},
  ...
  ]
  }}
  ```
  
  [Rules]
  Make sure the task plans satisfy the following rules! Do not make plans that violate the following rules!!!
  - Make a plan to define the module with its input and output first.
  - Do not plan the implementation of logic or signal from the input ports.
  - There is a test bench to test the functional correctness. Do not plan generating testbench to test the generated verilog code.
  - Don't make a plan only with clock or control signals. The clock or control signals should be planned with register or wire signal.
  - Don't make a plan on implementing the signal or next state logics which are not related to the module outputs.
  - For module related to Finite State Machine (FSM), try to determine the number of states first and then make the plan to implement FSM.
  - For module related to Finite State Machine or Moore State Machine, if the state or current_state is an input port signal of the module, You must Do Not implement the state flip-flops for state transition in TopModule.
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

