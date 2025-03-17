module TopModule(
    input logic clk,
    input logic a,
    output logic [2:0] q
);

    always @(posedge clk) begin
        if (a) begin
            q <= 3'b100; // Set q to 4 when a is high
        end else begin
            if (q == 3'b110) begin
                q <= 3'b000; // Reset q to 0 after reaching 6
            end else begin
                q <= q + 1; // Increment q by 1
            end
        end
    end

endmodule