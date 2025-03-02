module TopModule (
    input logic clk,
    input logic reset,
    input logic [3:0] in_a,
    input logic [3:0] in_b,
    output logic out_sop,
    output logic out_pos
);

    // Combinational logic for out_sop
    always @(*) begin
        // Implement the logic for out_sop based on input conditions
        // Example logic: out_sop is high if in_a and in_b are equal
        out_sop = (in_a == in_b);
    end

    // Combinational logic for out_pos
    always @(*) begin
        // Implement the logic for out_pos based on input conditions
        // Example logic: out_pos is high if in_a is greater than in_b
        out_pos = (in_a > in_b);
    end

endmodule