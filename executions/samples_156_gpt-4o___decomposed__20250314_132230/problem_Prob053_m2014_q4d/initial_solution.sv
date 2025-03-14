module TopModule (
    input logic clk,
    input logic in,
    output logic out
);

    logic intermediate_signal;

    // XOR gate to produce intermediate signal
    assign intermediate_signal = in ^ out;

    // D flip-flop to capture the XOR output on positive edge of clk
    always_ff @(posedge clk) begin
        out <= intermediate_signal;
    end

endmodule