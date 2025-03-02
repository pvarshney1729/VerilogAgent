module TopModule (
    input logic clk,
    input logic j,
    input logic k,
    output logic Q
);

    logic Qold;

    always @(posedge clk) begin
        case ({j, k})
            2'b00: Q <= Qold;       // Qold
            2'b01: Q <= 1'b0;       // 0
            2'b10: Q <= 1'b1;       // 1
            2'b11: Q <= ~Qold;      // ~Qold
        endcase
    end

    assign Qold = Q;

endmodule