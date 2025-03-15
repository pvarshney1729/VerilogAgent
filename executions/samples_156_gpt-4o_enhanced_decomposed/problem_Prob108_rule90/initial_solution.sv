module TopModule(
    input logic clk,
    input logic load,
    input logic [511:0] data,
    output logic [511:0] q
);

    logic [511:0] state;

    always_ff @(posedge clk) begin
        if (load) begin
            state <= data;
        end else begin
            state[0] <= 1'b0 ^ state[1]; // Left boundary
            state[511] <= state[510] ^ 1'b0; // Right boundary
            for (int i = 1; i < 511; i++) begin
                state[i] <= state[i-1] ^ state[i+1];
            end
        end
    end

    assign q = state;

endmodule