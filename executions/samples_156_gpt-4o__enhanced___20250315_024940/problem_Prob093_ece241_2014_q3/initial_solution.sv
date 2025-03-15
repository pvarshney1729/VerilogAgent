module TopModule (
    input logic c,          // 1-bit input
    input logic d,          // 1-bit input
    output logic [3:0] mux_in // 4-bit output
);

    logic a; // Selector input a
    logic b; // Selector input b
    
    // Assign values to a and b based on the inputs c and d
    assign a = c; // Assume a is connected to c
    assign b = d; // Assume b is connected to d

    // Implementing the K-map logic for mux_in using a 4-to-1 multiplexer structure
    always @(*) begin
        case ({a, b}) // Selector for the 4-to-1 MUX
            2'b00: mux_in = 4'b0001; // ab = 00 -> mux_in[0] = 1
            2'b01: mux_in = 4'b0001; // ab = 01 -> mux_in[1] = 0
            2'b10: mux_in = 4'b1001; // ab = 10 -> mux_in[3] = 1
            2'b11: mux_in = 4'b1101; // ab = 11 -> mux_in[2] = 1
            default: mux_in = 4'b0000; // Default case
        endcase
    end

endmodule