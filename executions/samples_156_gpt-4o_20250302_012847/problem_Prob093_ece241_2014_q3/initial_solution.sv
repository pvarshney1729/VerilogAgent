module combinational_kmap (
    input logic c,
    input logic d,
    output logic [3:0] mux_in
);

    always @(*) begin
        case ({c, d})
            2'b00: mux_in = 4'b0001; // K-map output for c=0, d=0
            2'b01: mux_in = 4'b0010; // K-map output for c=0, d=1
            2'b10: mux_in = 4'b0100; // K-map output for c=1, d=0
            2'b11: mux_in = 4'b1000; // K-map output for c=1, d=1
            default: mux_in = 4'b0000; // Default case
        endcase
    end

endmodule