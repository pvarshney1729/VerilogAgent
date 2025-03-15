module TopModule(
    input logic clk,
    input logic j,
    input logic k,
    output logic Q
);

    // Initialize Q to 0 for simulation purposes
    initial begin
        Q = 1'b0;
    end

    // Always block triggered on the positive edge of the clock
    always @(posedge clk) begin
        case ({j, k})
            2'b00: Q <= Q;       // Retain the previous state
            2'b01: Q <= 1'b0;    // Reset to 0
            2'b10: Q <= 1'b1;    // Set to 1
            2'b11: Q <= ~Q;      // Toggle the state
        endcase
    end

endmodule