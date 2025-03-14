module TopModule (
    input logic x,  // 1-bit input
    input logic y,  // 1-bit input
    output logic z  // 1-bit output
);

    initial begin
        z = 1;  // Initialize z to 1 at time 0
    end

    always @(*) begin
        case ({x, y})
            2'b00: z = 1;
            2'b01: z = 0;
            2'b10: z = 0;
            2'b11: z = 1;
            default: z = 1; // Default behavior (should not occur)
        endcase
    end

endmodule