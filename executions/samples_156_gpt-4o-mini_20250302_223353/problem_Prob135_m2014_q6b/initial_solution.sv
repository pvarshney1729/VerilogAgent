module TopModule (
    input logic [2:0] y,
    input logic w,
    output logic Y1,
    input logic clk,
    input logic rst_n
);

    logic [2:0] state;

    assign Y1 = state[1];

    always @(posedge clk) begin
        if (!rst_n) begin
            state <= 3'b000; // Reset to State A
        end else begin
            case (state)
                3'b000: state <= (w ? 3'b000 : 3'b001); // State A
                3'b001: state <= (w ? 3'b011 : 3'b010); // State B
                3'b010: state <= (w ? 3'b011 : 3'b100); // State C
                3'b011: state <= (w ? 3'b000 : 3'b101); // State D
                3'b100: state <= (w ? 3'b011 : 3'b100); // State E
                3'b101: state <= (w ? 3'b011 : 3'b010); // State F
                default: state <= 3'b000; // Default to State A
            endcase
        end
    end

endmodule