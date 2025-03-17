module TopModule(
    input logic clk,
    input logic reset,
    output logic [3:0] q
);

    logic [3:0] count;

    always @(posedge clk) begin
        if (reset) begin
            count <= 4'd1; // Reset counter to 1
        end else if (count == 4'd10) begin
            count <= 4'd1; // Wrap around to 1 after reaching 10
        end else begin
            count <= count + 4'd1; // Increment counter
        end
    end

    assign q = count; // Assign the count value to output q

endmodule