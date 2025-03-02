module fixed_module (
    input logic clk,
    input logic reset,
    input logic [15:0] in1,
    input logic [15:0] in2,
    output logic [31:0] out
);

    logic [31:0] concatenated_input;

    // Concatenate inputs to form a 32-bit vector
    always @(*) begin
        concatenated_input = {in1, in2};
    end

    // Sequential logic with synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            out <= 32'd0;
        end else begin
            out <= concatenated_input;
        end
    end

endmodule