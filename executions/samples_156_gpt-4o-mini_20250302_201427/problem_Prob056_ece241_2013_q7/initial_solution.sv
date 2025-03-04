module TopModule (
    input logic clk,
    input logic j,
    input logic k,
    output logic Q
);

    logic Qold;

    always @(posedge clk) begin
        case ({j, k})
            2'b00: Q <= Qold;        // Q remains unchanged
            2'b01: Q <= 1'b0;        // Q reset to 0
            2'b10: Q <= 1'b1;        // Q set to 1
            2'b11: Q <= ~Qold;       // Q toggles
        endcase
        Qold <= Q;                  // Update Qold to current Q
    end

endmodule