module TopModule (
    input logic clk,          // Clock signal, positive edge-triggered.
    input logic resetn,       // 1-bit synchronous, active-low reset.
    input logic [1:0] byteena,// 2-bit byte-enable signal.
    input logic [15:0] d,     // 16-bit input data bus.
    output logic [15:0] q     // 16-bit output data bus.
);

    always_ff @(posedge clk) begin
        if (!resetn) begin
            q <= 16'b0; // Reset all flip-flops to 0
        end else begin
            if (byteena[1]) begin
                q[15:8] <= d[15:8]; // Update upper byte
            end
            if (byteena[0]) begin
                q[7:0] <= d[7:0]; // Update lower byte
            end
        end
    end

endmodule