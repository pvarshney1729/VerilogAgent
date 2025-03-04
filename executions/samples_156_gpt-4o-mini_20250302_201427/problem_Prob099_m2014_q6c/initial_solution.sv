module TopModule (
    input logic [5:0] y,
    input logic w,
    output logic Y1,
    output logic Y3
);

    logic [5:0] next_state;

    always @(*) begin
        case (y)
            6'b000001: next_state = (w) ? 6'b000001 : 6'b000010; // State A
            6'b000010: next_state = (w) ? 6'b001000 : 6'b000100; // State B
            6'b000100: next_state = (w) ? 6'b001000 : 6'b010000; // State C
            6'b001000: next_state = (w) ? 6'b000001 : 6'b100000; // State D
            6'b010000: next_state = (w) ? 6'b001000 : 6'b010000; // State E
            6'b100000: next_state = (w) ? 6'b001000 : 6'b000100; // State F
            default: next_state = 6'b000001; // Reset to State A on invalid state
        endcase
    end

    always @(posedge w) begin
        if (w) begin
            Y1 <= (y[4] | y[5]); // Y1 is 1 in states E and F
            Y3 <= (y[2] | y[3]); // Y3 is 1 in states C and D
        end
    end

    initial begin
        Y1 = 0;
        Y3 = 0;
    end

endmodule