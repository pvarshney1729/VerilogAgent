module TopModule (
    input logic clk,            // Clock signal, active edge not specified
    input logic rst_n,          // Asynchronous active-low reset signal
    input logic x,              // Single-bit input
    input logic [2:0] y,        // 3-bit input, MSB y[2]
    output logic Y0,            // Single-bit output, corresponds to Y[0]
    output logic z              // Single-bit output
);

    logic [2:0] state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            3'b000: next_state = (x == 1'b0) ? 3'b000 : 3'b001;
            3'b001: next_state = (x == 1'b0) ? 3'b001 : 3'b100;
            3'b010: next_state = (x == 1'b0) ? 3'b010 : 3'b001;
            3'b011: next_state = (x == 1'b0) ? 3'b001 : 3'b010;
            3'b100: next_state = (x == 1'b0) ? 3'b011 : 3'b100;
            default: next_state = 3'b000; // Safe state
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            3'b011, 3'b100: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

    // State register with asynchronous reset
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= 3'b000;
        else
            state <= next_state;
    end

    // Output Y0 logic
    assign Y0 = next_state[0];

endmodule