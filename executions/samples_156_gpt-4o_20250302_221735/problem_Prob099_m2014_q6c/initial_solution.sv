module TopModule (
    input logic [5:0] y,  // 6-bit input, one-hot encoded state
    input logic w,        // 1-bit input
    input logic clk,      // Clock signal
    input logic reset,    // Synchronous reset
    output logic Y1,      // 1-bit output
    output logic Y3       // 1-bit output
);

    // State encoding
    localparam logic [5:0] A = 6'b000001;
    localparam logic [5:0] B = 6'b000010;
    localparam logic [5:0] C = 6'b000100;
    localparam logic [5:0] D = 6'b001000;
    localparam logic [5:0] E = 6'b010000;
    localparam logic [5:0] F = 6'b100000;

    logic [5:0] state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = (w == 1'b0) ? B : A;
            B: next_state = (w == 1'b0) ? C : D;
            C: next_state = (w == 1'b0) ? E : D;
            D: next_state = (w == 1'b0) ? F : A;
            E: next_state = (w == 1'b0) ? E : D;
            F: next_state = (w == 1'b0) ? C : D;
            default: next_state = A; // Default to A for safety
        endcase
    end

    // Output logic
    always @(*) begin
        Y1 = (state == E || state == F) ? 1'b1 : 1'b0;
        // Define Y3 based on specific requirements or state transitions
        Y3 = 1'b0; // Placeholder, define as needed
    end

    // State register with synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

endmodule