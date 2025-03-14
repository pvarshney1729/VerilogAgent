```
[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic [2:0] s,
    output logic fr2,
    output logic fr1,
    output logic fr0,
    output logic dfr
);

    logic [2:0] state, next_state;

    // State encoding
    localparam LOW = 3'b000;    // Below s[0]
    localparam MID1 = 3'b001;   // Between s[1] and s[0]
    localparam MID2 = 3'b010;   // Between s[2] and s[1]
    localparam HIGH = 3'b011;   // Above s[2]

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            state <= LOW; // Reset to low state
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state; // Default to current state
        case (state)
            LOW: if (s[0]) next_state = MID1;
            MID1: if (s[1]) next_state = MID2; else if (s[0]) next_state = LOW;
            MID2: if (s[2]) next_state = HIGH; else if (s[1]) next_state = MID1;
            HIGH: if (!s[2]) next_state = MID2;
        endcase
    end

    // Output logic based on state
    always @(*) begin
        fr2 = 1'b1; 
        fr1 = 1'b1; 
        fr0 = 1'b1; 
        dfr = 1'b1; 
        
        case (state)
            LOW: begin
                // All outputs remain high
            end
            MID1: begin
                fr0 = 1'b0;
                dfr = 1'b0;
            end
            MID2: begin
                fr1 = 1'b0;
                fr0 = 1'b0;
                dfr = 1'b0;
            end
            HIGH: begin
                fr2 = 1'b0;
                fr1 = 1'b0;
                fr0 = 1'b0;
                dfr = 1'b0;
            end
        endcase
    end

endmodule
[DONE]
```