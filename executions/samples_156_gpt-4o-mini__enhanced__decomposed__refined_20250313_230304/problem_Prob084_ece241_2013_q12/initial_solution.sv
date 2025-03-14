[BEGIN]
module TopModule (
    input logic clk,          // Clock input (1-bit)
    input logic enable,       // Synchronous active-high enable signal (1-bit)
    input logic S,            // Shift input for the shift register (1-bit)
    input logic A,            // Input A for output selection (1-bit)
    input logic B,            // Input B for output selection (1-bit)
    input logic C,            // Input C for output selection (1-bit)
    output logic Z            // Output Z (1-bit)
);

    // Internal storage: 8-bit shift register
    logic [7:0] Q;            // Q[0] is LSB, Q[7] is MSB

    // Initial conditions
    initial begin
        Q = 8'b00000000;      // Initial state of shift register
    end

    // Sequential Logic with synchronous enable
    always @(posedge clk) begin
        if (enable) begin
            // Shift operation
            Q <= {S, Q[7:1]};  // Shift left, input S goes to Q[0]
        end
    end

    // Combinational Logic for output Z
    always @(*) begin
        case ({A, B, C})       // 3-bit selection for Z
            3'b000: Z = Q[0];  // When ABC is 000, Z=Q[0]
            3'b001: Z = Q[1];  // When ABC is 001, Z=Q[1]
            3'b010: Z = Q[2];  // When ABC is 010, Z=Q[2]
            3'b011: Z = Q[3];  // When ABC is 011, Z=Q[3]
            3'b100: Z = Q[4];  // When ABC is 100, Z=Q[4]
            3'b101: Z = Q[5];  // When ABC is 101, Z=Q[5]
            3'b110: Z = Q[6];  // When ABC is 110, Z=Q[6]
            3'b111: Z = Q[7];  // When ABC is 111, Z=Q[7]
            default: Z = 1'b0;  // Default case to avoid latches
        endcase
    end

endmodule
[DONE]