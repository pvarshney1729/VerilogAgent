module TopModule (
    input wire clk,         // Clock signal, assumed to be active on the rising edge
    input wire L,           // Load control signal, active high
    input wire q_in,        // Input to the flip-flop from the multiplexer
    input wire r_in,        // Input to the multiplexer from the external source
    output reg Q            // Output of the flip-flop
);

    always @(posedge clk) begin
        if (L) begin
            Q <= r_in;
        end else begin
            Q <= q_in;
        end
    end

endmodule