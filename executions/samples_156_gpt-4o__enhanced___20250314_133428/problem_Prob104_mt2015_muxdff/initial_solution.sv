module TopModule (
    input logic clk,
    input logic L,
    input logic q_in,
    input logic r_in,
    output logic Q
);
    always_ff @(posedge clk) begin
        if (L) begin
            Q <= r_in; // Load 'r_in' into flip-flop
        end else begin
            Q <= q_in; // Pass 'q_in' to flip-flop
        end
    end
endmodule