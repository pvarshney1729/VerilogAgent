module TopModule (
    input logic clk,
    input logic reset,
    output logic [3:0] q
);

    // Internal register to hold the current count value
    logic [3:0] count;

    // Sequential logic for the decade counter
    always @(posedge clk) begin
        if (reset) begin
            count <= 4'b0001; // Reset to 1
        end else if (count == 4'b1010) begin
            count <= 4'b0001; // Wrap from 10 back to 1
        end else begin
            count <= count + 1; // Increment count
        end
    end

    // Assign the current count value to the output port q
    assign q = count;

endmodule