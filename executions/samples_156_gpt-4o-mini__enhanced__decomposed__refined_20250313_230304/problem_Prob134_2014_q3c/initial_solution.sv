[BEGIN]
module TopModule (
    input logic clk,          // Clock signal (1 bit, active on rising edge)
    input logic x,           // Control input (1 bit)
    input logic [2:0] y,     // Present state input (3 bits, unsigned)
    output logic Y0,         // Output signal representing the least significant bit of next state Y (1 bit)
    output logic z,          // Output signal (1 bit)
    input logic reset        // Asynchronous reset signal (1 bit)
);

logic [2:0] next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        next_state <= 3'b000; // Reset to state 000
    end else begin
        case (y)
            3'b000: next_state <= (x) ? 3'b001 : 3'b000;
            3'b001: next_state <= (x) ? 3'b100 : 3'b001;
            3'b010: next_state <= (x) ? 3'b001 : 3'b010;
            3'b011: next_state <= (x) ? 3'b010 : 3'b001;
            3'b100: next_state <= (x) ? 3'b100 : 3'b011;
            default: next_state <= 3'b000; // Handle unexpected states
        endcase
    end
end

always @(*) begin
    Y0 = next_state[0]; // Y0 is the least significant bit of the next state
    case (y)
        3'b011: z = (x) ? 1'b1 : 1'b0; // Output based on state 011
        3'b100: z = 1'b1; // Output for state 100
        default: z = 1'b0; // All other states output 0
    endcase
end

endmodule
[DONE]