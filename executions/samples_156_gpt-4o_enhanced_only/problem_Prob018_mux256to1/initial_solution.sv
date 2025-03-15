module TopModule(
    input logic [255:0] in,
    input logic [7:0] sel,
    output logic out
);

    // Combinational logic to select the appropriate bit from the input vector
    always @(*) begin
        out = in[sel];
    end

endmodule