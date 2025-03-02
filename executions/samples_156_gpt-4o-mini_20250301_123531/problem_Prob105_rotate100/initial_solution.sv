module TopModule (
    input logic clk,
    input logic load,
    input logic [1:0] ena,
    input logic rst_n,
    input logic [99:0] data,
    output logic [99:0] q
);

    always @(posedge clk) begin
        if (!rst_n) begin
            q <= 100'b0;
        end else if (load) begin
            q <= data;
        end else begin
            case (ena)
                2'b01: q <= {q[0], q[99:1]}; // Rotate right
                2'b10: q <= {q[98:0], q[99]}; // Rotate left
                default: q <= q; // No change
            endcase
        end
    end

endmodule