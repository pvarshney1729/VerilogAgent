module TopModule (
    input logic [3:0] in,
    output logic [1:0] pos
);

always @(*) begin
    casez (in)
        4'b1??? : pos = 2'd3; // First bit is in position 3
        4'b01?? : pos = 2'd2; // First bit is in position 2
        4'b001? : pos = 2'd1; // First bit is in position 1
        4'b0001 : pos = 2'd0; // First bit is in position 0
        default : pos = 2'd0; // No bits are high
    endcase
end

endmodule