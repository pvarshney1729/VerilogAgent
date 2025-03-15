module TopModule (
    input logic [7:0] in,
    output logic [31:0] out
);

    always @(*) begin
        out = { {24{in[7]}}, in }; // Sign-extend 8-bit input to 32 bits
    end

endmodule