module TopModule (
    input logic clk,            // Clock input, positive edge-triggered
    input logic load,           // Load control signal
    input logic [511:0] data,   // 512-bit input data vector
    output logic [511:0] q      // 512-bit output data vector
);

    always_ff @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q[0] <= 0 ^ q[1];
            for (int i = 1; i < 511; i++) begin
                q[i] <= q[i-1] ^ q[i+1];
            end
            q[511] <= q[510] ^ 0;
        end
    end

endmodule