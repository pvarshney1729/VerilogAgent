module TopModule (
    input  logic        clk,
    input  logic        load,
    input  logic [511:0] data,
    output logic [511:0] q
);

    logic [511:0] q_next;

    always @(*) begin
        // Compute next state based on Rule 110
        for (int i = 0; i < 512; i++) begin
            logic left, center, right;
            left = (i == 511) ? 1'b0 : q[i+1];
            center = q[i];
            right = (i == 0) ? 1'b0 : q[i-1];
            q_next[i] = (left & ~center & right) | (~left & center) | (~left & ~center & right);
        end
    end

    always_ff @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= q_next;
        end
    end

endmodule