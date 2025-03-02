module edge_detector (
    input logic clk,
    input logic rst,
    input logic [7:0] in,
    output logic [7:0] pos_edge
);

    logic [7:0] prev_state;

    always @(*) begin
        pos_edge = in & ~prev_state; // Detect positive edge
    end

    always @(posedge clk) begin
        if (rst) begin
            prev_state <= 8'b00000000; // Synchronous reset
        end else begin
            prev_state <= in; // Store current state
        end
    end

endmodule