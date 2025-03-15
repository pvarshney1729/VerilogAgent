module TopModule (
    input logic clk,
    input logic reset,
    output logic [3:0] count
);

    logic [3:0] counter;

    always @(posedge clk) begin
        if (reset) begin
            counter <= 4'b0000; // Initialize counter to 0 on reset
        end else if (counter < 4'b1010) begin
            counter <= counter + 4'b0001; // Increment counter
        end else begin
            counter <= 4'b0001; // Reset to 1 after reaching 10
        end
    end

    assign count = counter;

endmodule