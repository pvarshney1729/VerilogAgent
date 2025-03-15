module TopModule(
    input logic [1:0] A,  // 2-bit input A
    input logic [1:0] B,  // 2-bit input B
    output logic z        // 1-bit output z
);

    // Combinational logic to compare A and B
    always @(*) begin
        if (A == B)
            z = 1'b1;
        else
            z = 1'b0;
    end

endmodule