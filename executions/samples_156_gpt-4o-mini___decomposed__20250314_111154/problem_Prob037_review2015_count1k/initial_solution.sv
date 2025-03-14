module TopModule (
    input logic clk,
    input logic reset,
    output logic [9:0] q
);

logic [9:0] counter;

always @(posedge clk) begin
    if (reset) begin
        counter <= 10'b0000000000; // Reset counter to 0
    end else if (counter < 10'd999) begin
        counter <= counter + 1; // Increment counter
    end else begin
        counter <= 10'b0000000000; // Wrap around to 0
    end
end

assign q = counter; // Assign counter value to output q

endmodule