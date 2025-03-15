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
- Initialize all flip-flops to zero in simulation.
- Adhere strictly to the provided interface and signal names.
- Generate results in the specified cycle timing.
- Infer logic correctly, especially when using Karnaugh maps.
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
IMPORTANT: Enclose your code with [BEGIN] and [DONE].
</CODE>
""",


'enhance_spec_system': """You are an expert in formal hardware design specification and Verilog implementation. Your task is to analyze user-provided specifications for digital logic circuits and rewrite them by improving clarity, removing ambiguities, and making implicit assumptions explicit.""",

'enhance_spec_rules': """You should NOT change the functional intent of the specification but should refine it to ensure correctness in implementation. 

You may edit or add more details to the original specification to ensure correctness in implementation.
<ENHANCEMENT GUIDELINES>
- Explicitly define input/output port widths, signedness, and naming conventions.
- Clearly specify MSB/LSB conventions and bit indexing (e.g., "bit[0] refers to the least significant bit").
- Clearly distinguish combinational vs. sequential logic and define clock cycle relationships.
- Explicitly state whether resets are synchronous or asynchronous and the reset state of all registers.
- Ensure all flip-flops, registers, and sequential elements have explicitly defined initial values.
- Clarify signal dependencies, precedence of operations, and potential race conditions.
- Where Karnaugh maps, truth tables, FSMs, or bitwise operations are involved, provide both textual and formal mathematical descriptions.
- Specify behavior at edge cases and input boundaries.
</ENHANCEMENT GUIDELINES>

Given the following user specification for a Verilog module, rewrite it between <ENHANCED_SPEC> tags.

Original Specification:
{user_spec}

<ENHANCED_SPEC>
[Provide the rewritten specification here using the enhancementguidelines above. DO NOT WRITE DOWN YOUR VERILOG IMPLEMENTATION FOR THE MODULE.]
</ENHANCED_SPEC>

DO NOT include any explanations, notes, or text outside the <ENHANCED_SPEC> tags. Return ONLY the enhanced specification.
""",

'decomposition_system_prompt': """You are an expert Verilog RTL designer that can break down complicated implementations into modules. You MUST return valid JSON in the exact format requested.""",

'decomposition_prompt': """
<Target Problem>
{spec}
</Target Problem>

<Instructions>
- Let's think step by step.
- Based on the Problem description, set up an implementation plan. Each subtask should focus on implementing only one signal or logical component at a time.
-Extract the corresponding source contexts in the [Target Problem] section of each subtask into the 'source' field.
-The task id number indicates the sequential orders.
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
    {{
      "id": "3",
      "content": "task description 3",
      "source": "source 3"
    }}
  ]
}}

EXAMPLE:
For a problem about implementing a counter, your response might be:
{{
  "subtasks": [
    {{
      "id": "1",
      "content": "Define the module with input clock, reset, and enable signals, and output count[3:0]",
      "source": "Design a 4-bit counter with clock, reset, and enable inputs"
    }},
    {{
      "id": "2",
      "content": "Implement the synchronous reset logic for the counter",
      "source": "The counter should reset to 0 when reset is high"
    }},
    {{
      "id": "3",
      "content": "Implement the counter increment logic when enable is high",
      "source": "The counter should increment by 1 on each clock cycle when enable is high"
    }}
  ]
}}

[Rules]
Make sure the task plans satisfy the following rules! Do not make plans that violate the following rules!!!
- Make a plan to define the module with its input and output first.
- Do not plan the implementation of logic or signal from the input ports.
- There is a test bench to test the functional correctness. Do not plan generating testbench to test the generated verilog code.
- Don't make a plan only with clock or control signals. The clock or control signals should be planned with register or wire signal.
- Don't make a plan on implementing the signal or next state logics which are not related to the module outputs.
- For module related to Finite State Machine (FSM), try to determine the number of states first and then make the plan to implement FSM.
- For module related to Finite State Machine or Moore State Machine, if the state or current_state is an input port signal of the module, You must Do Not implement the state flip-flops for state transition in TopModule.

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

