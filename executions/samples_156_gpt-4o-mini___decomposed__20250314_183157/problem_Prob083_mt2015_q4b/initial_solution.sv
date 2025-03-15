module TopModule (
    input logic x,
    input logic y,
    output logic z
);

always @(*) begin
    case ({x, y})
        2'b00: z = 1; // State 1
        2'b01: z = 0; // State 2
        2'b10: z = 0; // State 3
        2'b11: z = 1; // State 4
        default: z = 0; // Default state
    endcase
end

endmodule