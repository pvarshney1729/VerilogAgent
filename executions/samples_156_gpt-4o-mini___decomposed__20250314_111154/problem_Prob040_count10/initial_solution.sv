module TopModule (
    input logic clk,
    input logic reset,
    output logic [3:0] q
);
    logic [3:0] count;

    always @(posedge clk) begin
        if (reset) begin
            count <= 4'b0000; // Reset the counter to 0
        end else if (count < 4'b1001) begin
            count <= count + 1; // Increment counter
        end else begin
            count <= 4'b0000; // Reset to 0 when it reaches 9
        end
    end

    assign q = count; // Link count to output q
endmodule