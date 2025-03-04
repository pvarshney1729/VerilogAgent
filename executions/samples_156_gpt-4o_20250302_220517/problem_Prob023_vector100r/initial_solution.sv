module TopModule(
    input logic [99:0] in,
    output logic [99:0] out
);

    // Combinational logic to reverse the bit order of the input vector
    always @(*) begin
        for (int i = 0; i < 100; i++) begin
            out[i] = in[99-i];
        end
    end

endmodule