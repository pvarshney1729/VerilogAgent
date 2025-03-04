module TopModule (
    input logic clk,               // Clock signal, triggers on positive edge
    input logic load,              // Load control signal, active high
    input logic [511:0] data,      // 512-bit wide data input
    output logic [511:0] q         // 512-bit wide output representing the state of the cellular automaton
);

    logic [511:0] next_q;          // Next state of the cellular automaton

    always_ff @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            next_q[0] = 0 ^ q[1];
            next_q[511] = q[510] ^ 0;
            for (int i = 1; i < 511; i++) begin
                next_q[i] = q[i-1] ^ q[i+1];
            end
            q <= next_q;
        end
    end

endmodule