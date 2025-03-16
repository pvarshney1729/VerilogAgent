[BEGIN]
module TopModule(
    input logic c,
    input logic d,
    output logic [3:0] mux_in
);

    // Intermediate signals for 2-to-1 multiplexers
    logic mux0_out, mux1_out, mux2_out, mux3_out;

    // Implementing the logic using 2-to-1 multiplexers
    always @(*) begin
        // mux0_out = c ? 1'b0 : 1'b1; (c selects between 0 and 1)
        mux0_out = ~c & ~d;
        
        // mux1_out = c ? 1'b0 : 1'b0; (c selects between 0 and 0)
        mux1_out = 1'b0;

        // mux2_out = c ? 1'b1 : 1'b0; (c selects between 1 and 0)
        mux2_out = c & d;

        // mux3_out = c ? 1'b1 : 1'b0; (c selects between 1 and 0)
        mux3_out = c | d;
    end

    // Assigning the outputs to the 4-to-1 multiplexer inputs
    assign mux_in[0] = mux0_out; // ab = 00
    assign mux_in[1] = mux1_out; // ab = 01
    assign mux_in[2] = mux2_out; // ab = 11
    assign mux_in[3] = mux3_out; // ab = 10

endmodule
[END]