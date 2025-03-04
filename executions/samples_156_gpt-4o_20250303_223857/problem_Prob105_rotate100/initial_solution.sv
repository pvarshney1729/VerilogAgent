module TopModule (
    input logic clk,
    input logic reset,
    input logic load,
    input logic [1:0] ena,
    input logic [99:0] data,
    output logic [99:0] q
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 100'b0;
        end else if (load) begin
            q <= data;
        end else begin
            case (ena)
                2'b01: q <= {q[0], q[99:1]}; // Rotate right
                2'b10: q <= {q[98:0], q[99]}; // Rotate left
                default: q <= q; // No operation
            endcase
        end
    end

endmodule