module TopModule (
    input logic clk,           // Clock signal, triggers on positive edge
    input logic enable,        // Synchronous active-high enable signal for shifting
    input logic S,             // Serial input for the shift register
    input logic A,             // MSB input for multiplexer select
    input logic B,             // Middle bit input for multiplexer select
    input logic C,             // LSB input for multiplexer select
    output logic Z             // Output of the selected register bit
);

    logic [7:0] Q; // 8-bit shift register

    // Shift register logic
    always_ff @(posedge clk) begin
        if (enable) begin
            Q <= {S, Q[7:1]};
        end
    end

    // Multiplexer logic
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
            default: Z = 1'b0; // Default case for completeness
        endcase
    end

endmodule