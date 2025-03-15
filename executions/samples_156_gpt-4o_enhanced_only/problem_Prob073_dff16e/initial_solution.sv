module TopModule(
    input logic clk,
    input logic resetn,
    input logic [1:0] byteena,
    input logic [15:0] d,
    output logic [15:0] q
);

    // Synchronous logic for the 16 D flip-flops
    always_ff @(posedge clk) begin
        if (!resetn) begin
            // Active-low reset: initialize all flip-flops to 0
            q <= 16'b0;
        end else begin
            // If reset is not active, use byte-enable signals to control writing
            if (byteena[1]) begin
                q[15:8] <= d[15:8];  // Write to upper byte if enabled
            end
            if (byteena[0]) begin
                q[7:0] <= d[7:0];    // Write to lower byte if enabled
            end
        end
    end

endmodule