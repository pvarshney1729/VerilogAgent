module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);
    // State encoding
    logic state_A, state_B;

    // Asynchronous reset and state transition
    always @(posedge clk) begin
        if (areset) begin
            state_A <= 1'b1; // Reset to state A
            state_B <= 1'b0;
            z <= 1'b0;
        end else begin
            case ({state_A, state_B})
                2'b10: begin // State A
                    if (x) begin
                        state_A <= 1'b0;
                        state_B <= 1'b1;
                        z <= 1'b1; // Transition to B when x=1
                    end else begin
                        z <= 1'b0; // Remain in A when x=0
                    end
                end
                2'b01: begin // State B
                    z <= x ? 1'b0 : 1'b1; // z=0 when x=1, z=1 when x=0
                    // Remain in B regardless of x
                end
            endcase
        end
    end
endmodule