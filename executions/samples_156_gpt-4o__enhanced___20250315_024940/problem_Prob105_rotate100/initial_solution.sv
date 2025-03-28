module TopModule (
    input logic clk,
    input logic load,
    input logic [1:0] ena,
    input logic [99:0] data,
    output logic [99:0] q
);

    // Internal register to hold the current contents of the rotator
    logic [99:0] rotator;

    always @(posedge clk) begin
        if (load) begin
            // Load new data into the rotator
            rotator <= data;
        end else begin
            // Rotate based on ena input
            case (ena)
                2'b01: begin
                    // Rotate right
                    rotator <= {rotator[0], rotator[99:1]};
                end
                2'b10: begin
                    // Rotate left
                    rotator <= {rotator[98:0], rotator[99]};
                end
                2'b00, 2'b11: begin
                    // No rotation
                    rotator <= rotator;
                end
            endcase
        end
    end

    // Assign the output q to the current value of the rotator
    assign q = rotator;

endmodule