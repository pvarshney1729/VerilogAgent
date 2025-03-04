module TopModule (
    input wire clk,
    input wire load,
    input wire [511:0] data,
    output reg [511:0] q
);

    reg [511:0] next_q;

    always @(*) begin
        integer i;
        for (i = 0; i < 512; i = i + 1) begin
            if (i == 0) begin
                // Boundary condition for the first cell
                next_q[i] = (q[511] & q[i]) | (~q[511] & q[i+1]);
            end else if (i == 511) begin
                // Boundary condition for the last cell
                next_q[i] = (q[i-1] & q[i]) | (~q[i-1] & 0);
            end else begin
                // Rule 110 for the rest of the cells
                next_q[i] = (q[i-1] & q[i]) | (~q[i-1] & q[i+1]);
            end
        end
    end

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end

endmodule