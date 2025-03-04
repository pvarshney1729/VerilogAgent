module TopModule (
    input logic c,       // Single-bit input
    input logic d,       // Single-bit input
    output logic [3:0] mux_in // 4-bit output
);

    always @(*) begin
        case ({c, d})
            2'b00: mux_in = 4'b0001;
            2'b01: mux_in = 4'b1000;
            2'b11: mux_in = 4'b1011;
            2'b10: mux_in = 4'b1001;
            default: mux_in = 4'b0000; // Default case for safety
        endcase
    end

endmodule