module TopModule (
    input logic clk,
    input logic rst_n,
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    input logic e,
    output logic [24:0] result
);

    logic [4:0] inputs;
    logic [24:0] comparisons;

    // Initialize inputs
    always @(*) begin
        inputs = {a, b, c, d, e};
    end

    // Pairwise comparisons
    always @(*) begin
        comparisons[0] = (inputs[0] < inputs[1]) ? 1'b1 : 1'b0;
        comparisons[1] = (inputs[0] < inputs[2]) ? 1'b1 : 1'b0;
        comparisons[2] = (inputs[0] < inputs[3]) ? 1'b1 : 1'b0;
        comparisons[3] = (inputs[0] < inputs[4]) ? 1'b1 : 1'b0;
        comparisons[4] = (inputs[1] < inputs[2]) ? 1'b1 : 1'b0;
        comparisons[5] = (inputs[1] < inputs[3]) ? 1'b1 : 1'b0;
        comparisons[6] = (inputs[1] < inputs[4]) ? 1'b1 : 1'b0;
        comparisons[7] = (inputs[2] < inputs[3]) ? 1'b1 : 1'b0;
        comparisons[8] = (inputs[2] < inputs[4]) ? 1'b1 : 1'b0;
        comparisons[9] = (inputs[3] < inputs[4]) ? 1'b1 : 1'b0;
        // Fill remaining bits with zero
        comparisons[10] = 1'b0;
        comparisons[11] = 1'b0;
        comparisons[12] = 1'b0;
        comparisons[13] = 1'b0;
        comparisons[14] = 1'b0;
        comparisons[15] = 1'b0;
        comparisons[16] = 1'b0;
        comparisons[17] = 1'b0;
        comparisons[18] = 1'b0;
        comparisons[19] = 1'b0;
        comparisons[20] = 1'b0;
        comparisons[21] = 1'b0;
        comparisons[22] = 1'b0;
        comparisons[23] = 1'b0;
        comparisons[24] = 1'b0;
    end

    // Synchronous reset and output assignment
    always @(posedge clk) begin
        if (!rst_n) begin
            result <= 25'b0;
        end else begin
            result <= comparisons;
        end
    end

endmodule