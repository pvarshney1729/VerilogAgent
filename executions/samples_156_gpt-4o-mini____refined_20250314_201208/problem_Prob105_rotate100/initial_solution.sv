module TopModule (
    input  logic clk,
    input  logic load,
    input  logic [1:0] ena,
    input  logic [99:0] data,
    output logic [99:0] q
);

    logic [99:0] reg_q;

    always @(posedge clk) begin
        if (load) begin
            reg_q <= data;
        end else begin
            case (ena)
                2'b01: reg_q <= {reg_q[0], reg_q[99:1]}; // Rotate right
                2'b10: reg_q <= {reg_q[98:0], reg_q[99]}; // Rotate left
                default: reg_q <= reg_q; // No rotation
            endcase
        end
    end

    assign q = reg_q;

endmodule