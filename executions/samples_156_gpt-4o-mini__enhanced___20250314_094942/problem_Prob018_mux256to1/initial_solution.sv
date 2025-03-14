module TopModule (
    input  logic [255:0] in,    // 256-bit input vector, in[0] is LSB, in[255] is MSB
    input  logic [7:0]   sel,   // 8-bit selection input (0 to 255)
    output logic         out     // 1-bit output
);

    // Combinational logic for 256-to-1 multiplexer
    always @(*) begin
        out = in[sel]; // Select the output based on the sel input
    end

endmodule