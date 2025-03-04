module TopModule (
    input wire clk,             // Clock signal, positive edge-triggered
    input wire load,            // Load control signal, active high
    input wire [511:0] data,    // 512-bit input data bus
    output reg [511:0] q        // 512-bit output state bus
);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q[0] <= q[1]; // Boundary condition: q[-1] = 0
            q[511] <= q[510]; // Boundary condition: q[512] = 0
            integer i;
            for (i = 1; i < 511; i = i + 1) begin
                q[i] <= q[i-1] ^ q[i+1];
            end
        end
    end

endmodule