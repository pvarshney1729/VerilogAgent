module TopModule (
    input logic [5:0] y,
    input logic w,
    output logic Y1,
    output logic Y2,
    output logic Y3,
    output logic Y4,
    input logic rst_n
);

    logic [5:0] state;

    always @(*) begin
        if (!rst_n) begin
            state = 6'b000001; // Reset to state A
        end else begin
            case (1'b1) // one-hot encoding
                y[0]: state = (w) ? 6'b000001 : 6'b000010; // State A
                y[1]: state = (w) ? 6'b000100 : 6'b001000; // State B
                y[2]: state = (w) ? 6'b001000 : 6'b010000; // State C
                y[3]: state = (w) ? 6'b000001 : 6'b100000; // State D
                y[4]: state = (w) ? 6'b001000 : 6'b001000; // State E
                y[5]: state = (w) ? 6'b001000 : 6'b000100; // State F
                default: state = 6'b000001; // Default to state A
            endcase
        end
    end

    assign Y2 = (y[0] & ~w) | (y[1] & w); // Next state derived from y[1]
    assign Y4 = (y[3] & w) | (y[4] & ~w); // Next state derived from y[3]

    // Output logic
    assign Y1 = y[4]; // Example output signal
    assign Y3 = y[5]; // Example output signal

endmodule