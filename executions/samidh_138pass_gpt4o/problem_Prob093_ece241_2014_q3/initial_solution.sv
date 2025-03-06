module mux_logic (
    input logic c,
    input logic d,
    input logic [1:0] ab,
    output logic [3:0] mux_in
);

    // Intermediate signals for the 4-to-1 multiplexer inputs
    logic mux0, mux1, mux2, mux3;

    // Assigning values based on the Karnaugh map
    assign mux0 = (~c & ~d) | (c & d);
    assign mux1 = 1'b0;
    assign mux2 = (c & d);
    assign mux3 = (~c & d) | (c & d);

    // Assigning the outputs based on the selector inputs
    always @(*) begin
        case (ab)
            2'b00: mux_in = {3'b000, mux0};
            2'b01: mux_in = {3'b000, mux1};
            2'b10: mux_in = {3'b000, mux2};
            2'b11: mux_in = {3'b000, mux3};
            default: mux_in = 4'b0000; // Default case for safety
        endcase
    end

endmodule