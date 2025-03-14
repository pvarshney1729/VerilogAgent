module TopModule (
    input logic x,
    input logic y,
    output logic z
);
    logic [2:0] state;  // 3-bit state register to represent different states
    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100; // State definitions

    always @(posedge clk) begin
        case (state)
            S0: if (x == 1'b1) state <= S1; // Transition from S0 to S1
            S1: if (y == 1'b1) state <= S2; // Transition from S1 to S2
            S2: state <= S3; // Transition to S3
            S3: if (x == 1'b1) state <= S4; // Transition from S3 to S4
            S4: if (y == 1'b0) state <= S0; // Back to S0
            default: state <= S0; // Default state
        endcase
    end

    always @(*) begin
        case (state)
            S0: z = 1'b1;
            S1: z = 1'b0;
            S2: z = 1'b0;
            S3: z = 1'b1;
            S4: z = 1'b0;
            default: z = 1'b1; // Default case
        endcase
    end
endmodule