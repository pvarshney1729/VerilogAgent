module TopModule (
    input wire clk,                // Clock signal
    input wire load,               // Load signal, active high
    input wire [511:0] data,       // Data input for initial state, 512 bits, unsigned
    output reg [511:0] q           // Output state, 512 bits, unsigned
);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            integer i;
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    q[i] <= 0 ^ q[i+1];  // q[-1] is considered as 0
                end else if (i == 511) begin
                    q[i] <= q[i-1] ^ 0;  // q[512] is considered as 0
                end else begin
                    q[i] <= q[i-1] ^ q[i+1];
                end
            end
        end
    end

endmodule