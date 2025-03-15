module TopModule (
    input logic x,
    input logic y,
    output logic z
);

    always @(*) begin
        case ({x, y})
            2'b00: z = 1'b1; // When x=0, y=0, output z=1
            2'b01: z = 1'b0; // When x=0, y=1, output z=0
            2'b10: z = 1'b0; // When x=1, y=0, output z=0
            2'b11: z = 1'b1; // When x=1, y=1, output z=1
            default: z = 1'b0; // Default case (shouldn't occur)
        endcase
    end

endmodule