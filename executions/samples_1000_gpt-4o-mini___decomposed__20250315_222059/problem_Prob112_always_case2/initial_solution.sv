module TopModule (
    input  logic [3:0] in,
    output logic [1:0] pos
);
    always @(*) begin
        casez (in)
            4'b1??? : pos = 2'b00; // First bit is high
            4'b01?? : pos = 2'b01; // Second bit is high
            4'b001? : pos = 2'b10; // Third bit is high
            4'b0001 : pos = 2'b11; // Fourth bit is high
            default : pos = 2'b00;  // None are high
        endcase
    end
endmodule