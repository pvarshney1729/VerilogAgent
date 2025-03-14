module TopModule (
    input logic clk,
    input logic reset,
    input logic x,
    output logic z
);
    logic [2:0] y; // State register

    always @(posedge clk) begin
        if (reset) begin
            y <= 3'b000; // Reset to state 000
        end else begin
            case (y)
                3'b000: y <= (x) ? 3'b001 : 3'b000;
                3'b001: y <= (x) ? 3'b100 : 3'b001;
                3'b010: y <= (x) ? 3'b001 : 3'b010;
                3'b011: y <= (x) ? 3'b010 : 3'b001;
                3'b100: y <= (x) ? 3'b100 : 3'b011;
                default: y <= 3'b000; // Default case
            endcase
        end
    end

    assign z = (y == 3'b011 || y == 3'b100) ? 1'b1 : 1'b0; // Output logic based on state
endmodule