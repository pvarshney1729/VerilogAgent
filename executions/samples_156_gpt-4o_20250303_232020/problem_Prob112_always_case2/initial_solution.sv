module TopModule (
    input  logic [3:0] data_in,
    output logic [2:0] pos
);

    always @(*) begin
        casez (data_in)
            4'b0000: pos = 3'd0;
            4'b0001: pos = 3'd0;
            4'b001?: pos = 3'd1;
            4'b01??: pos = 3'd2;
            4'b1???: pos = 3'd3;
            default: pos = 3'd0; // Default case for safety
        endcase
    end

endmodule