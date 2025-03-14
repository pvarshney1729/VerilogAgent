module TopModule (
    input logic clk,
    input logic L,
    input logic q_in,
    input logic r_in,
    output logic Q
);
    logic mux_out;

    // 2:1 multiplexer
    assign mux_out = L ? r_in : q_in;

    // D flip-flop to store the output
    always @(posedge clk) begin
        Q <= mux_out;
    end

endmodule