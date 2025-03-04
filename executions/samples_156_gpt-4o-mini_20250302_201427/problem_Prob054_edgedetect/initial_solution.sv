module TopModule (
    input logic clk,             // Clock input, positive edge-triggered
    input logic [7:0] in,        // 8-bit input vector
    output logic [7:0] pedge      // 8-bit output vector for positive edge detection
);

    logic [7:0] in_prev; // To hold previous state of in

    always @(posedge clk) begin
        integer i;
        for (i = 0; i < 8; i = i + 1) begin
            pedge[i] <= (in[i] && !in_prev[i]);
        end
        in_prev <= in; // Update previous state
    end

    initial begin
        pedge = 8'b00000000; // Initialize pedge to 0
        in_prev = 8'b00000000; // Initialize in_prev to 0
    end

endmodule