module TopModule (
    input logic clk,
    input logic rst,
    input logic x,
    input logic [2:0] y,
    output logic Y0,
    output logic z
);

    logic [2:0] Y; // Next state

    // State transition and output logic
    always_ff @(posedge clk) begin
        if (rst) begin
            Y <= 3'b000; // Reset state
        end else begin
            case (y)
                3'b000: begin
                    Y <= (x == 1'b0) ? 3'b000 : 3'b001;
                    z <= 1'b0;
                end
                3'b001: begin
                    Y <= (x == 1'b0) ? 3'b001 : 3'b100;
                    z <= 1'b0;
                end
                3'b010: begin
                    Y <= (x == 1'b0) ? 3'b010 : 3'b001;
                    z <= 1'b0;
                end
                3'b011: begin
                    Y <= (x == 1'b0) ? 3'b001 : 3'b010;
                    z <= 1'b1;
                end
                3'b100: begin
                    Y <= (x == 1'b0) ? 3'b011 : 3'b100;
                    z <= 1'b1;
                end
                default: begin
                    Y <= 3'b000; // Default to safe state
                    z <= 1'b0;
                end
            endcase
        end
    end

    // Output logic
    assign Y0 = Y[0];

endmodule