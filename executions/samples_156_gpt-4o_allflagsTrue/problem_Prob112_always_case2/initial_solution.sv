module TopModule(
    input logic [3:0] in,
    output logic [1:0] pos
);

    always @(*) begin
        casez (in)
            4'b1???: pos = 2'd3; // Highest priority for bit 3
            4'b01??: pos = 2'd2; // Next priority for bit 2
            4'b001?: pos = 2'd1; // Next priority for bit 1
            4'b0001: pos = 2'd0; // Lowest priority for bit 0
            default: pos = 2'd0; // Default case when all bits are zero
        endcase
    end

endmodule