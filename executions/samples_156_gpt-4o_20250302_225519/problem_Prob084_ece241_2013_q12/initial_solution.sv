module TopModule (
    input logic clk,            // Clock input
    input logic reset,          // Synchronous reset input, active high
    input logic enable,         // Enable input, synchronous active high
    input logic S,              // Serial data input for shift register
    input logic A,              // Select input A
    input logic B,              // Select input B
    input logic C,              // Select input C
    output logic Z              // Output selected from shift register
);

    // Internal shift register storage
    logic [7:0] Q;

    // Shift register logic with synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            Q <= 8'b0;
        end else if (enable) begin
            Q <= {Q[6:0], S}; // Shift right, input S into Q[7]
        end
    end

    // Multiplexer logic to select output Z
    always_comb begin
        case ({A, B, C})
            3'b000: Z = Q[0];
            3'b001: Z = Q[1];
            3'b010: Z = Q[2];
            3'b011: Z = Q[3];
            3'b100: Z = Q[4];
            3'b101: Z = Q[5];
            3'b110: Z = Q[6];
            3'b111: Z = Q[7];
            default: Z = 1'b0; // Default case, though not needed
        endcase
    end

endmodule