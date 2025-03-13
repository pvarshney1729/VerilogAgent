module TopModule (
    input logic c,
    input logic d,
    output logic [3:0] mux_in
);
    logic a, b;
    
    // Assign a and b from c and d respectively
    assign a = c;
    assign b = d;

    always @(*) begin
        case ({a, b})
            2'b00: mux_in = 4'b0000; // ab = 00 -> 0
            2'b01: mux_in = 4'b0001; // ab = 01 -> 1
            2'b10: mux_in = 4'b0011; // ab = 10 -> 1
            2'b11: mux_in = 4'b0111; // ab = 11 -> 1
            default: mux_in = 4'b0000; // Default case
        endcase
    end
endmodule