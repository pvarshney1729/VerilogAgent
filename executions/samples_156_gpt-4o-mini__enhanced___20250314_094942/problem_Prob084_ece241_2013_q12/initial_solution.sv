module TopModule (
    input  logic clk,          // 1-bit clock input, positive edge triggered
    input  logic enable,       // 1-bit enable input, synchronous active high
    input  logic S,            // 1-bit serial input for shift register
    input  logic A,            // 1-bit input for address selection
    input  logic B,            // 1-bit input for address selection
    input  logic C,            // 1-bit input for address selection
    output logic Z             // 1-bit output for the selected memory value
);

    // Internal signals
    logic [7:0] Q;             // 8-bit shift register output

    // Reset and Initialization Behavior
    initial begin
        Q = 8'b00000000;       // Initialize shift register outputs to 0
    end

    // Shift Register and Output Logic
    always @(posedge clk) begin
        if (enable) begin
            Q <= {S, Q[7:1]};  // Shift in 'S' to Q[0], shifting others right
        end
    end

    // Combinational Logic for Output Z
    always @(*) begin
        case ({A, B, C})        // Concatenate inputs A, B, and C for address selection
            3'b000: Z = Q[0];   // When ABC is 000, output Z is Q[0]
            3'b001: Z = Q[1];   // When ABC is 001, output Z is Q[1]
            3'b010: Z = Q[2];   // When ABC is 010, output Z is Q[2]
            3'b011: Z = Q[3];   // When ABC is 011, output Z is Q[3]
            3'b100: Z = Q[4];   // When ABC is 100, output Z is Q[4]
            3'b101: Z = Q[5];   // When ABC is 101, output Z is Q[5]
            3'b110: Z = Q[6];   // When ABC is 110, output Z is Q[6]
            3'b111: Z = Q[7];   // When ABC is 111, output Z is Q[7]
            default: Z = 1'b0;   // Default case to avoid latch inference
        endcase
    end

endmodule