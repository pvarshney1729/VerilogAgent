module TopModule (
    input logic clk,
    input logic enable,
    input logic S,
    input logic A,
    input logic B,
    input logic C,
    output logic Z
);

    logic [7:0] Q;

    always @(posedge clk) begin
        if (enable) begin
            Q <= {Q[6:0], S}; // Shift left and insert S at LSB
        end
    end

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
            default: Z = 1'b0; // Default case to avoid latches
        endcase
    end

    initial begin
        Q = 8'b0; // Initialize shift register to 0
    end

endmodule