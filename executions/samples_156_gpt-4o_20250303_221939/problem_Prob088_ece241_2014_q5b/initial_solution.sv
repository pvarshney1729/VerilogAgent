```verilog
module TopModule (
    input logic clk,       // Clock signal, active on positive edge
    input logic areset,    // Asynchronous reset, active high
    input logic x,         // Input signal for FSM
    output logic z         // Output signal from FSM
);

    logic state_A, state_B;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state_A <= 1'b1;
            state_B <= 1'b0;
            z <= 1'b0;
        end else begin
            case ({state_A, state_B})
                2'b10: begin // State A
                    if (x) begin
                        state_A <= 1'b0;
                        state_B <= 1'b1;
                        z <= 1'b1;
                    end else begin
                        z <= 1'b0;
                    end
                end
                2'b01: begin // State B
                    if (x) begin
                        z <= 1'b0;
                    end else begin
                        z <= 1'b1;
                    end
                end
                default: begin
                    // Should not reach here; reset on invalid state
                    state_A <= 1'b1;
                    state_B <= 1'b0;
                    z <= 1'b0;
                end
            endcase
        end
    end

endmodule
```