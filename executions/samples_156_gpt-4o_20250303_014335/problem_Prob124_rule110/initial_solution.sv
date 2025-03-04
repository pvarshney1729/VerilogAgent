module TopModule (
    input wire clk,                // Clock signal, positive edge-triggered
    input wire load,               // Synchronous active-high load input
    input wire [511:0] data,       // 512-bit input data to load state
    output reg [511:0] q           // 512-bit output representing the current state of the cellular automaton
);

    always @(posedge clk) begin
        if (load) begin
            q <= data; // Load state when load is asserted
        end else begin
            // Compute next state based on Rule 110
            q[0] <= (q[0] & q[1]) | (~q[0] & q[1]) | (q[1] & q[2]);
            q[511] <= (q[510] & q[511]) | (~q[511] & q[510]) | (q[510] & 0);
            for (integer i = 1; i < 511; i = i + 1) begin
                q[i] <= (q[i-1] & q[i]) | (~q[i] & q[i+1]) | (q[i-1] & q[i+1]);
            end
        end
    end

endmodule