[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic reset,
    output logic shift_ena
);
    logic [2:0] count; // 3-bit counter to keep track of clock cycles
    logic [1:0] state; // State variable for FSM

    always @(posedge clk) begin
        if (reset) begin
            shift_ena <= 1'b1; // Assert shift_ena on reset
            count <= 3'b000;   // Initialize counter
            state <= 2'b01;    // Go to active state
        end else begin
            case (state)
                2'b01: begin // Active state
                    if (count < 3'b011) begin
                        count <= count + 1; // Increment counter
                        shift_ena <= 1'b1;   // Keep shift_ena asserted
                    end else begin
                        shift_ena <= 1'b0;   // Deassert after 4 cycles
                        state <= 2'b00;      // Transition to idle state
                    end
                end
                2'b00: begin // Idle state
                    shift_ena <= 1'b0; // Maintain deassertion
                    // Logic to check for the proper bit pattern goes here
                    // If pattern detected, transition to active state
                    // if (pattern_detected) begin
                    //     state <= 2'b01;
                    //     count <= 3'b000;  // Reset count for 4 cycles
                    // end
                end
            endcase
        end
    end
endmodule
```
[DONE]