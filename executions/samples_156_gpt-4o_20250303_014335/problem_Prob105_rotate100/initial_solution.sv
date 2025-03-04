module TopModule (
    input logic clk,
    input logic reset_n,
    input logic load,
    input logic [1:0] ena,
    input logic [99:0] data,
    output logic [99:0] q
);
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            q <= 100'd0;
        end else if (load) begin
            q <= data;
        end else begin
            case (ena)
                2'b01: q <= {q[0], q[99:1]}; // Right rotate
                2'b10: q <= {q[98:0], q[99]}; // Left rotate
                default: q <= q; // No operation
            endcase
        end
    end
endmodule