module TopModule (
    input logic clk,
    input logic rst,
    input logic x,
    input logic y,
    output logic z
);

    always_ff @(posedge clk) begin
        if (rst) begin
            z <= 1'b1;
        end else begin
            case ({x, y})
                2'b00: z <= 1'b1;
                2'b01: z <= 1'b0;
                2'b10: z <= 1'b0;
                2'b11: z <= 1'b1;
                default: z <= 1'b0; // Default case for safety
            endcase
        end
    end

endmodule