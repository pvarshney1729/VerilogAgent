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

    // Sequential logic for state transition
    always @(posedge clk) begin
        if (reset) begin
            state <= LOW;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            fr0 <= 1'b1;
            dfr <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state and outputs
    always @(*) begin
        // Default outputs
        fr2 = 1'b0;
        fr1 = 1'b0;
        fr0 = 1'b0;
        dfr = 1'b0;
        next_state = state; // Default to stay in the current state

        case (state)
            LOW: begin
                if (s[0] == 1'b1) begin
                    next_state = MID1;
                    fr0 = 1'b1;
                    fr1 = 1'b1;
                    fr2 = 1'b1;
                end
            end
            
            MID1: begin
                if (s[1] == 1'b1) begin
                    next_state = MID2;
                    fr0 = 1'b1;
                    fr1 = 1'b1;
                end else if (s[0] == 1'b0) begin
                    next_state = LOW;
                    fr0 = 1'b1;
                    fr1 = 1'b1;
                    fr2 = 1'b1;
                end
            end
            
            MID2: begin
                if (s[2] == 1'b1) begin
                    next_state = HIGH;
                end else if (s[1] == 1'b0) begin
                    next_state = MID1;
                    fr0 = 1'b1;
                    fr1 = 1'b1;
                end
            end
            
            HIGH: begin
                next_state = HIGH;
            end
            
            default: begin
                next_state = LOW;
            end
        endcase
        
        // Control dfr based on state transition
        if (next_state > state) begin
            dfr = 1'b1;
        end
    end

endmodule
```
[DONE]