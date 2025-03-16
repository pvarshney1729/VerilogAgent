module TopModule (
    input  logic [5:0] y,
    input  logic w,
    output logic Y1,
    output logic Y3
);

    logic [5:0] next_state;

    // Next-state logic for Y2 and Y4
    always @(*) begin
        case (1'b1) // one-hot encoding
            y[0]: next_state = (w) ? 6'b000001 : 6'b000010; // State A
            y[1]: next_state = (w) ? 6'b000100 : 6'b001000; // State B
            y[2]: next_state = (w) ? 6'b001000 : 6'b000100; // State C
            y[3]: next_state = (w) ? 6'b000001 : 6'b001000; // State D
            y[4]: next_state = (w) ? 6'b001000 : 6'b001000; // State E
            y[5]: next_state = (w) ? 6'b000100 : 6'b001000; // State F
            default: next_state = 6'b000001; // Reset to State A
        endcase
    end

    // Output logic
    assign Y1 = y[1];
    assign Y3 = y[3];

    // Synchronous reset and state update
    always @(posedge w) begin
        if (w) begin
            y <= next_state;
        end
    end

endmodule