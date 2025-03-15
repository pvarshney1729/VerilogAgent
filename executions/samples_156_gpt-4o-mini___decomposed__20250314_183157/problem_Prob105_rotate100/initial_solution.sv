module TopModule (
    input logic clk,
    input logic load,
    input logic [1:0] ena,
    input logic [99:0] data,
    output logic [99:0] q
);

logic [99:0] rotator;

always @(posedge clk) begin
    if (load) begin
        rotator <= data;
    end else begin
        case (ena)
            2'b01: rotator <= {rotator[0], rotator[99:1]}; // Rotate right
            2'b10: rotator <= {rotator[98:0], rotator[99]}; // Rotate left
            default: rotator <= rotator; // No rotation
        endcase
    end
end

assign q = rotator;

endmodule