module TopModule(
    input logic clk,          // Clock signal
    input logic load,         // Synchronous active high load signal
    input logic [511:0] data, // 512-bit input data bus, unsigned
    output logic [511:0] q    // 512-bit output data bus, unsigned
);

    logic [511:0] next_q;

    always @(*) begin
        if (load) begin
            next_q = data;
        end else begin
            next_q[0] = (q[0] & q[1]) | (q[0] & ~q[2]) | (~q[1] & q[2]);
            for (int i = 1; i < 511; i++) begin
                next_q[i] = (q[i-1] & q[i]) | (q[i-1] & ~q[i+1]) | (~q[i] & q[i+1]);
            end
            next_q[511] = (q[510] & q[511]) | (q[510] & 1'b0) | (~q[511] & 1'b0);
        end
    end

    always @(posedge clk) begin
        q <= next_q;
    end

endmodule