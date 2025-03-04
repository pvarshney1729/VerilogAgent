module TopModule (
    input wire clk,
    input wire L,
    input wire q_in,
    input wire r_in,
    output reg Q
);

    // Initial state definition
    initial begin
        Q = 1'b0; // Define initial state if needed
    end

    // Sequential logic for flip-flop with 2:1 multiplexer
    always @(posedge clk) begin
        Q <= (L ? r_in : q_in);
    end

endmodule