module TopModule (
    input logic clk,
    input logic ar,
    input logic d,
    output logic q
);

    always @(posedge clk or posedge ar) begin
        if (ar) begin
            q <= 1'b0; // Asynchronous reset
        end else begin
            q <= d;    // Capture data on rising edge of clock
        end
    end

    // Initialize q to 0 for simulation purposes
    initial begin
        q = 1'b0;
    end

endmodule