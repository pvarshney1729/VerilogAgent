module TopModule (
    input logic clk, // Clock signal, triggers on the positive edge
    input logic x,   // Primary data input, unsigned, 1 bit
    output logic z   // Output of the module, unsigned, 1 bit
);

    logic q1, q2, q3; // Internal flip-flop outputs

    // D flip-flop for q1
    always @(posedge clk) begin
        q1 <= x ^ q1; // XOR gate logic
    end

    // D flip-flop for q2
    always @(posedge clk) begin
        q2 <= x & ~q2; // AND gate logic
    end

    // D flip-flop for q3
    always @(posedge clk) begin
        q3 <= x | ~q3; // OR gate logic
    end

    // Output logic using NOR gate
    assign z = ~(q1 | q2 | q3); // NOR gate logic

    // Asynchronous reset logic
    always @(posedge clk) begin
        if (reset) begin
            q1 <= 1'b0;
            q2 <= 1'b0;
            q3 <= 1'b0;
        end
    end

endmodule