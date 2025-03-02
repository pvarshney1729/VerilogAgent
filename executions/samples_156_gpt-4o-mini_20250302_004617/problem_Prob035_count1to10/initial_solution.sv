module counter (
    input logic clk,
    input logic reset,
    output logic [3:0] count
);
    always @(*) begin
        if (reset) begin
            count = 4'b0001; // Set counter to 1 on reset
        end else if (count == 4'b1010) begin
            count = 4'b0001; // Wrap back to 1 after reaching 10
        end else begin
            count = count + 4'b0001; // Increment counter
        end
    end

    initial begin
        count = 4'b0000; // Initialize counter to 0 in simulation
    end

    always @(posedge clk) begin
        // Synchronous reset is handled in the combinational block
    end
endmodule