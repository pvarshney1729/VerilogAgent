module TopModule(
    input logic clk,             // Clock signal
    input logic load,            // Synchronous active high load signal
    input logic reset,           // Asynchronous active high reset signal
    input logic [511:0] data,    // Input data bus (512 bits, unsigned)
    output logic [511:0] q       // Output state bus (512 bits, unsigned)
);

    logic [511:0] next_q;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 512'b0;
        end else if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end

    always_comb begin
        next_q[0] = q[1] ^ (q[0] | 1'b0); // q[-1] assumed 0
        next_q[511] = q[510] ^ (q[511] | 1'b0); // q[512] assumed 0
        for (int i = 1; i < 511; i++) begin
            next_q[i] = q[i+1] ^ (q[i] | q[i-1]);
        end
    end

endmodule