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
- Initialize all flip-flops and inputs to "zero" in your code using initial blocks, unless provided the specified initial values in the question. Eg, initial begin a = 0; b = 0; end
- Adhere strictly to the provided interface and signal names.
- Generate results in the specified cycle timing.
- Handle bitwise operations and signal broadcasting correctly.
</Guidelines>

Here are some additional rules and coding conventions.
<Coding Conventions>
 - Declare all ports and signals as logic; do not to use wire or reg.
 - All input ports (other then control signals), internal signals, should be initialized to zero, within a initial block.
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
- Initialisation is not something that is handled by the simulation environment, specify where the initialisation should be done. reqwa
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

'decomposition_system_prompt_1': """You are an expert Verilog RTL designer engineer that can break down complicated implementations into subtasks.""",

'decomposition_prompt_1': """
<Target Problem>
{spec}
</Target Problem>

<Instructions>
-Let's think step by step.
-Based on the Problem description, set up an implementation plan: each subtask should focus on implementing only one logical component at a time.
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
    ....
}}

EXAMPLE:
For a problem about implementing a counter, your response might be:
{{
  "subtasks": [
    {{
      "id": "1",
      "content": "Define the module with input clock, reset, and enable signals, and output count[3:0]
      and initialise the input signals (other then control signals) and internal signals to zero, eg. count = 4'b0",
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
Make sure the task plans satisfy the following rules:
- Do not plan the implementation of logic or signal from the input ports.
- There is a test bench to test the functional correctness. Do not plan generating testbench to test the generated verilog code.
- Don't make a plan only with clock or control signals. The clock or control signals should be planned with register or wire signal.
- Don't make a plan on implementing the signal or next state logics which are not related to the module outputs.
- For module related to Finite State Machine (FSM), try to determine the number of states first and then make the plan to implement FSM.
- For module related to Finite State Machine or Moore State Machine, if the state or current_state is an input port signal of the module, You must Do Not implement the state flip-flops for state transition in TopModule.


DO NOT include any explanations, notes, or text outside the JSON structure. Return ONLY the JSON object.
""",
# Generate implementation for this subtask  
'implementation_system_prompt_1': """You are a Verilog RTL designer that only writes code using correct Verilog syntax.""",
  
'implementation_prompt_1': """
  Implement the following Verilog subtask:
  
  TASK: {subtask_content}
  
  CONTEXT FROM SPECIFICATION:
  {subtask_source}
  
  FULL SPECIFICATION:
  {spec}
  
  Provide ONLY the Verilog code snippet that implements this specific subtask. Do not implement the entire module.
  Focus only on the specific signals, registers, or logic described in the task.
  
  Enclose your code with [BEGIN] and [DONE]. Only output the code snippet and do NOT output anything else.
  """,

  "decomposition_system_prompt": "You are an expert Verilog RTL designer with extensive experience in digital design. Your specialty is breaking down complex hardware specifications into well-structured, implementable subtasks. You prioritize clean architecture, proper signal handling, and adherence to hardware design best practices.",

  "decomposition_prompt": """<Target Problem> {spec} </Target Problem>  <Instructions> -Analyze the specification methodically. -Create a structured implementation plan where each subtask addresses one logical component or function. -For each subtask, extract the relevant context from the specification. -Order subtasks logically, with earlier tasks creating foundations for later ones. -Be precise about signal names, widths, and relationships. </Instructions> IMPORTANT: Return ONLY a valid JSON object with this structure: {{   \"subtasks\": [     {{       \"id\": \"1\",       \"content\": \"task description 1\",       \"source\": \"source 1\"     }},     {{       \"id\": \"2\",       \"content\": \"task description 2\",       \"source\": \"source 2\"     }},     .... ] }}  [Rules] Your task plan must: - Focus on output-driving logic rather than simply passing through input signals - Separate combinational logic from sequential elements - For FSMs: first determine state encoding, then plan state transitions and output logic separately - When state/current_state is an input port, DO NOT implement state flip-flops - Group related signals and logic into coherent functional blocks - Plan reset handling explicitly - Include parameter and constant definitions where appropriate - Avoid planning testbench generation - Ensure clock/control signals are planned alongside their associated registers/wires  For FSM design specifically: 1. Define state encoding (parameters/localparams) 2. Plan next-state combinational logic 3. Plan output logic (Moore or Mealy style) 4. For hierarchical designs, define sub-module interfaces before implementation  DO NOT include any explanations, notes, or text outside the JSON structure. Return ONLY the JSON object. Specification Refinements
  

Clear Module Interface Definition

Explicitly list all input and output ports with their widths
Specify signal direction (input/output/inout)
Group related signals together (e.g., control signals, data signals)


State Machine Details

Provide a complete state diagram or state transition table
Clarify if it's a Moore or Mealy machine
Specify reset conditions and initial states
Identify output values for each state
Explicitly list all state transitions with conditions


Timing Requirements

Clearly state clock domain(s)
Specify synchronous vs. asynchronous reset behavior
Identify any timing constraints or latency requirements
Note any clock gating or special timing considerations


Signal Behavior Details

Define the expected behavior for all edge cases
Specify default values for outputs when conditions aren't met
Clarify priority when multiple conditions could be true simultaneously


Design Constraints

Note any specific implementation requirements (e.g., "use separate always blocks")
Specify required coding style (e.g., use parameters vs. direct encoding)
Clarify expected synthesis targets (FPGA vs. ASIC considerations)


Visual Aids

Include timing diagrams for complex signal interactions
Provide state transition diagrams for FSMs
Use tables to clarify input/output relationships


Implementation Guidance

Indicate preferred state encoding (one-hot, binary, gray code)
Specify whether to use SystemVerilog or Verilog features
Provide hints for complex logic that might be challenging to derive


Test Cases

Include sample input sequences and expected outputs
Describe corner cases that should be handled correctly
Provide functional verification criteria


Protocol Details

For interfaces following standard protocols, provide protocol details
Clarify handshaking mechanisms or sequencing requirements
Define any protocol-specific timing requirements"""

  ,"implementation_system_prompt": "You are a professional Verilog RTL designer with expertise in digital logic design, synchronous circuits, and hardware description languages. You write clean, synthesizable code that follows industry best practices. Your implementations are efficient, readable, and adhere strictly to the given specifications.",

  "implementation_prompt": "\"\"\"Implement the following Verilog subtask:  TASK: {subtask_content}  CONTEXT FROM SPECIFICATION: {subtask_source}  FULL SPECIFICATION: {spec}  GUIDELINES: 1. Write only the Verilog code that implements this specific subtask 2. Follow standard RTL coding practices 3. Use proper indentation and consistent spacing 4. Include brief inline comments for complex logic 5. Ensure signals are properly declared with correct widths 6. For FSMs, use clear state encoding (parameters/localparams) 7. For combinational logic, ensure all cases are covered 8. For sequential logic, handle clock and reset properly  Do NOT: - Implement features outside the scope of this subtask - Create a full module unless the task requires it - Add test vectors or verification code - Include extensive commentary or explanations  [BEGIN] Your implementation here [DONE]\"\"\""

,'fsm_codebook': """# SystemVerilog FSM Design Patterns Codebook

This codebook provides patterns and techniques for implementing Finite State Machines (FSMs) in SystemVerilog. It includes fully worked examples, design patterns, and implementation strategies for common hardware design scenarios.

## 1. Arbiter FSM with Priority Handling

### Specification
- An arbiter controls access to a resource for three requesting devices
- Each device requests via r[i]=1, and receives grant via g[i]=1
- Priority: device 0 > device 1 > device 2
- Device keeps grant while request remains active
- Active-low synchronous reset to state A

### Implementation
```systemverilog
module ArbitratorFSM (
  input clk, resetn,
  input [2:0] r,
  output [2:0] g
);
  parameter A=0, B=1, C=2, D=3;
  reg [1:0] state, next;

  // State registers with synchronous reset
  always @(posedge clk) begin
    if (~resetn) state <= A;
    else state <= next;
  end

  // Next-state logic in separate always block
  always@(state,r) begin
    case (state)
      A: if (r[0]) next = B;         // Highest priority
         else if (r[1]) next = C;    // Medium priority
         else if (r[2]) next = D;    // Lowest priority
         else next = A;
      B: next = r[0] ? B : A;        // Keep grant while request active
      C: next = r[1] ? C : A;
      D: next = r[2] ? D : A;
      default: next = 'x;
    endcase
  end

  // Output logic using continuous assignment
  assign g[0] = (state == B);
  assign g[1] = (state == C);
  assign g[2] = (state == D);
endmodule
```

### Design Notes
- Separate always blocks for state registers and next-state logic
- Priority encoded directly in the if-else order
- Outputs driven by state equality comparisons
- Minimal state encoding (2 bits for 4 states)
- Structure follows classic three-part FSM pattern: state register, next-state logic, output logic

## 2. One-Hot State Machine Transition Logic

### Specification
- FSM with 10 states (S0-S9) in one-hot encoding
- One input, two outputs (out1, out2)
- Implementation focuses on state transition and output logic only
- FSM with specific pattern of transitions between states

### Implementation
```systemverilog
module OneHotFSM (
  input in,
  input [9:0] state,
  output [9:0] next_state,
  output out1, out2
);
  // Output logic
  assign out1 = state[8] | state[9];       // Outputs from specific states
  assign out2 = state[7] | state[9];

  // Next-state logic as boolean equations
  assign next_state[0] = !in && (|state[4:0] | state[7] | state[8] | state[9]);
  assign next_state[1] = in && (state[0] | state[8] | state[9]);
  assign next_state[2] = in && state[1];
  assign next_state[3] = in && state[2];
  assign next_state[4] = in && state[3];
  assign next_state[5] = in && state[4];
  assign next_state[6] = in && state[5];
  assign next_state[7] = in && (state[6] | state[7]);
  assign next_state[8] = !in && state[5];
  assign next_state[9] = !in && state[6];
endmodule
```

### Design Notes
- Pure combinational logic implementation
- Next-state equations derived directly from state diagram
- Bit-slicing and reduction operators used for compact expressions
- One-hot encoding simplifies individual transition expressions
- Can handle multiple active states simultaneously
- Efficient for complex state machines with many transitions

## 3. Moore Machine with Complex State Transitions

### Specification
- Moore FSM with 10 states (one-hot encoded)
- 3 inputs (d, done_counting, ack), 3 outputs (shift_ena, counting, done)
- Implements only state transition logic and output logic
- Complex pattern of state transitions with conditional behavior

### Implementation
```systemverilog
module MooreFSM (
  input d, done_counting, ack,
  input [9:0] state,
  output B3_next, S_next, S1_next, Count_next, Wait_next,
  output done, counting, shift_ena
);
  parameter S=0, S1=1, S11=2, S110=3, B0=4, B1=5, B2=6, B3=7, Count=8, Wait=9;

  // Next-state logic equations
  assign B3_next = state[B2];  // Simple transition
  assign S_next = state[S]&~d | state[S1]&~d | state[S110]&~d | state[Wait]&ack;  // Multiple paths
  assign S1_next = state[S]&d;
  assign Count_next = state[B3] | state[Count]&~done_counting;
  assign Wait_next = state[Count]&done_counting | state[Wait]&~ack;

  // Moore outputs (based only on current state)
  assign done = state[Wait];
  assign counting = state[Count];
  assign shift_ena = |state[B3:B0];  // Active in multiple states
endmodule
```

### Design Notes
- Boolean equations directly derived from state diagram
- Parameters improve code readability
- Bit-slicing techniques for multiple state checks
- Clean Moore machine pattern: outputs depend only on current state
- Combines multiple conditions with logical operators
- Outputs are purely a function of current state (Moore machine property)

## 4. Protocol Detector State Machine

### Specification
- Detects 3-byte PS/2 mouse protocol messages in continuous byte stream
- First byte identified by in[3]=1
- Signal completion after third byte received
- Synchronous active-high reset

### Implementation
```systemverilog
module ProtocolDetectorFSM (
  input clk, reset,
  input [7:0] in,
  output done
);
  parameter BYTE1=0, BYTE2=1, BYTE3=2, DONE=3;
  reg [1:0] state, next;

  wire in3 = in[3];  // Extract significant bit for clarity

  // Next-state logic
  always_comb begin
    case (state)
      BYTE1: next = in3 ? BYTE2 : BYTE1;  // Look for message start
      BYTE2: next = BYTE3;                // Unconditional transitions
      BYTE3: next = DONE;
      DONE:  next = in3 ? BYTE2 : BYTE1;  // Check if next byte starts new message
    endcase
  end

  // State registers with synchronous reset
  always @(posedge clk) begin
    if (reset) state <= BYTE1;
    else state <= next;
  end

  // Output logic
  assign done = (state==DONE);
endmodule
```

### Design Notes
- SystemVerilog `always_comb` for combinational logic
- Compact state encoding (2 bits for 4 states)
- Extracting critical signals improves readability
- FSM designed to synchronize with protocol boundaries
- Clean separation of next-state logic, state registers, and outputs

## Key Design Patterns and Techniques

### State Encoding Strategies
1. **Binary Encoding**
   - Uses minimum number of bits: log2(number_of_states)
   - Efficient for small state machines
   - Example: 2 bits for 4 states (00, 01, 10, 11)

2. **One-Hot Encoding**
   - One bit per state (only one bit active at a time)
   - Simpler next-state logic for complex FSMs
   - Easier to debug (each state has a dedicated bit)
   - More bits but often better timing in FPGAs

### FSM Structure Components
1. **State Register**
   ```systemverilog
   always @(posedge clk) begin
     if (reset) state <= INITIAL_STATE;
     else state <= next_state;
   end
   ```

2. **Next-State Logic**
   - Case-based approach:
   ```systemverilog
   always_comb begin
     case (state)
       STATE1: next_state = input_condition ? STATE2 : STATE1;
       STATE2: next_state = STATE3;
       // ...
     endcase
   end
   ```

   - Boolean equation approach:
   ```systemverilog
   assign next_state[0] = conditions_for_going_to_state0;
   assign next_state[1] = conditions_for_going_to_state1;
   // ...
   ```

3. **Output Logic**
   - Moore machine (output depends only on current state):
   ```systemverilog
   assign output1 = (state == STATE1) || (state == STATE3);
   ```
   
   - Mealy machine (output depends on state and inputs):
   ```systemverilog
   assign output1 = (state == STATE1 && input1) || (state == STATE2 && !input2);
   ```

### Optimization Techniques
1. **Bit Manipulation**
   - Bit slicing: `state[3:0]`
   - Bit reduction: `|state[7:4]` (OR reduction)
   - Bit extraction: `wire input_bit = input_vector[3];`

2. **Boolean Logic Compaction**
   - Combine multiple conditions with logical operators
   - Use reduction operators for compactness
   - Factoring common terms

3. **Code Clarity Techniques**
   - Named parameters for states
   - Extracting critical signals into named wires
   - Consistent formatting and commenting
   - Separate blocks for different logic types

### FSM Design Patterns
1. **Sequence Detector**
   - Recognizes specific input patterns
   - Reset to initial state upon pattern completion

2. **Arbiter with Priority**
   - Resolves multiple requests based on priority
   - Maintains grant until request is deasserted

3. **Protocol Parser**
   - Identifies message boundaries in data streams
   - Synchronizes to protocol-specific patterns

4. **Handshaking Controller**
   - Manages request/acknowledge sequences
   - Handles timing relationships between signals

## Common Mistakes and How to Avoid Them

1. **Unintentional Latches**
   - Always provide a default value for all outputs in combinational logic
   - Use `always_comb` in SystemVerilog instead of `always @*`
   - Ensure all branches of if/else or case statements are covered

2. **Incomplete Case Statements**
   - Include a `default` case to handle unexpected states
   - Cover all possible state transitions explicitly

3. **Reset Handling**
   - Be clear about synchronous vs. asynchronous reset
   - Properly initialize all state registers and outputs

4. **Unreachable States**
   - Verify that all states have paths leading to them
   - Check for state transition dead-ends

5. **Race Conditions**
   - Separate combinational and sequential logic
   - Be careful with feedback paths in combinational logic

## SystemVerilog-Specific Tips

1. **Use SystemVerilog Enhancements**
   - `always_comb`, `always_ff` for clearer design intent
   - Enumerated types for state encoding
   - Typedef for improved readability

2. **State Machine Declaration Example**
   ```systemverilog
   typedef enum logic [1:0] {
     IDLE = 2'b00,
     ACTIVE = 2'b01,
     ERROR = 2'b10,
     DONE = 2'b11
   } state_t;
   
   state_t state, next_state;
   ```

3. **Advanced Case Statement**
   ```systemverilog
   unique case (state)  // Compiler warns if any case is missing
     IDLE: next_state = condition ? ACTIVE : IDLE;
     ACTIVE: next_state = condition ? DONE : ERROR;
     ERROR: next_state = IDLE;
     DONE: next_state = IDLE;
   endcase
   ```

This codebook provides a reference for common FSM design patterns in SystemVerilog. Use these templates as starting points for your own designs, adapting them to your specific requirements."
"""
}



