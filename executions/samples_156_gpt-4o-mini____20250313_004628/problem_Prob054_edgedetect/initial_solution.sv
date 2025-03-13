module TopModule (
    input logic clk,
    input logic [7:0] in,
    output logic [7:0] pedge
);

    logic [7:0] prev_in;

    always @(posedge clk) begin
        prev_in <= in;
    end

    always @(*) begin
        pedge = 8'b0; // Initialize output to zero
        pedge = (prev_in & ~in); // Detect 0 to 1 transitions
    end

endmodule