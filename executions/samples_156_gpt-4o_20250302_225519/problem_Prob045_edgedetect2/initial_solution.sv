module TopModule (
    input logic clk,
    input logic reset_n, // Active-low asynchronous reset
    input logic [7:0] in,
    output logic [7:0] anyedge
);

    logic [7:0] prev_in; // Register to hold the previous state of the input

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            anyedge <= 8'b0; // Reset anyedge to 0
            prev_in <= 8'b0; // Reset prev_in to 0
        end else begin
            anyedge <= in ^ prev_in; // XOR to detect any edge
            prev_in <= in; // Update prev_in with the current in
        end
    end

endmodule