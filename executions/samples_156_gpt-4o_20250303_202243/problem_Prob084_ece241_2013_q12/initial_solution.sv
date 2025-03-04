module TopModule (
    input  logic clk,       // Clock input, positive edge triggered
    input  logic reset_n,   // Asynchronous active-low reset
    input  logic enable,    // Synchronous active-high enable for shifting
    input  logic S,         // Serial input for shift register
    input  logic A,         // Address bit 2
    input  logic B,         // Address bit 1
    input  logic C,         // Address bit 0
    output logic Z          // Output based on the selected Q
);

    logic [7:0] Q;  // 8-bit shift register

    // Shift register logic
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            Q <= 8'b00000000;  // Initialize shift register to all zeros on reset
        end else if (enable) begin
            Q <= {Q[6:0], S};  // Shift operation
        end
    end

    // Multiplexer logic for selecting output Z based on address ABC
    always @(*) begin
        case ({A, B, C})
            3'b000: Z = Q[0];
            3'b001: Z = Q[1];
            3'b010: Z = Q[2];
            3'b011: Z = Q[3];
            3'b100: Z = Q[4];
            3'b101: Z = Q[5];
            3'b110: Z = Q[6];
            3'b111: Z = Q[7];
            default: Z = 1'b0;  // Default case, though not needed
        endcase
    end

endmodule