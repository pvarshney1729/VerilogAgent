module TopModule (
    input  logic [3:0] in,
    output logic [1:0] pos
);

    always @(*) begin
        casez (in)
            4'b1???: pos = 2'd3;
            4'b01??: pos = 2'd2;
            4'b001?: pos = 2'd1;
            4'b0001: pos = 2'd0;
            default: pos = 2'd0;
        endcase
    end

endmodule