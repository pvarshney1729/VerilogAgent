module TopModule (
    input logic clk,
    input logic x,
    input logic [2:0] y,
    output logic Y0,
    output logic z
);
    logic [2:0] next_state;
    logic [2:0] current_state;

    always @(posedge clk) begin
        current_state <= next_state;
    end

    always @(*) begin
        case (current_state)
            3'b000: next_state = (x == 0) ? 3'b000 : 3'b001;
            3'b001: next_state = (x == 0) ? 3'b001 : 3'b100;
            3'b010: next_state = (x == 0) ? 3'b010 : 3'b001;
            3'b011: next_state = (x == 0) ? 3'b001 : 3'b010;
            3'b100: next_state = (x == 0) ? 3'b011 : 3'b100;
            default: next_state = 3'b000;
        endcase
    end

    assign Y0 = next_state[0];
    assign z = (current_state == 3'b011) || (current_state == 3'b100);

endmodule