[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic [2:0] s,
    output logic fr2,
    output logic fr1,
    output logic fr0,
    output logic dfr
);

    logic [1:0] state, next_state;

    // State encoding
    localparam LOW = 2'b00;    // Below s[0]
    localparam MID1 = 2'b01;   // Between s[1] and s[0]
    localparam MID2 = 2'b10;   // Between s[2] and s[1]
    localparam HIGH = 2'b11;   // Above s[2]

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            state <= LOW; // Reset to LOW state
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state; // Default to current state
        case (state)
            LOW: begin
                if (s[2]) begin
                    next_state = HIGH;
                end else if (s[1]) begin
                    next_state = MID2;
                end else if (s[0]) begin
                    next_state = MID1;
                end
            end
            MID1: begin
                if (s[2]) begin
                    next_state = HIGH;
                end else if (!s[0]) begin
                    next_state = LOW;
                end
            end
            MID2: begin
                if (!s[1]) begin
                    next_state = MID1;
                end else if (!s[0]) begin
                    next_state = LOW;
                end
            end
            HIGH: begin
                // Remain in HIGH state
            end
            default: next_state = LOW; // Default case
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
                // All outputs are already set to 1
            end
            MID1: begin
                fr0 = 1'b0; // fr0 asserted
                dfr = 1'b0; // dfr not asserted
            end
            MID2: begin
                fr0 = 1'b0; // fr0 asserted
                fr1 = 1'b0; // fr1 asserted
                dfr = 1'b0; // dfr not asserted
            end
            HIGH: begin
                fr2 = 1'b0; // fr2 asserted
                fr1 = 1'b0; // fr1 asserted
                fr0 = 1'b0; // fr0 asserted
                dfr = 1'b0; // dfr not asserted
            end
            default: begin
                // All outputs are already set to 1
            end
        endcase
    end

endmodule
```
[DONE]