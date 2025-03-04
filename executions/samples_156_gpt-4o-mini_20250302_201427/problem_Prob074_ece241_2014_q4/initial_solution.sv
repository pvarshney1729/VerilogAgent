module TopModule (
    input logic clk,
    input logic x,
    output logic z
);

    logic Q1, Q2, Q3;
    logic next_Q1, next_Q2, next_Q3;

    // D flip-flops with asynchronous reset
    always @(posedge clk) begin
        Q1 <= next_Q1;
        Q2 <= next_Q2;
        Q3 <= next_Q3;
    end

    // Combinational logic for next state
    always @(*) begin
        next_Q1 = x ^ Q1;
        next_Q2 = x & ~Q2;
        next_Q3 = x | ~Q3;
    end

    // Output logic
    assign z = ~(Q1 | Q2 | Q3);

    // Asynchronous reset logic
    initial begin
        Q1 = 1'b0;
        Q2 = 1'b0;
        Q3 = 1'b0;
    end

endmodule