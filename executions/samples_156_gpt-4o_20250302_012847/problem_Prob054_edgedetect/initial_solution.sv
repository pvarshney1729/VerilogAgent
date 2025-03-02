module pedge_detector (
    input logic clk,
    input logic reset_n,  // Active low reset
    input logic [7:0] in,
    output logic [7:0] pedge
);

    logic [7:0] prev_in;

    // Sequential logic to capture the previous state of the input
    always_ff @(posedge clk) begin
        if (!reset_n) begin
            prev_in <= 8'b0;
        end else begin
            prev_in <= in;
        end
    end

    // Combinational logic to detect positive edges
    always_comb begin
        pedge = in & ~prev_in;
    end

endmodule