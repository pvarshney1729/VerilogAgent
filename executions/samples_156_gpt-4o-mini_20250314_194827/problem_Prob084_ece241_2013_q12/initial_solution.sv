module shift_register_mux (
    input logic clk,
    input logic rst_n,
    input logic shift_en,
    input logic [7:0] data_in,
    input logic [2:0] sel,
    output logic [7:0] mux_out
);

    logic [7:0] shift_reg;

    // Synchronous reset and shift operation
    always @(posedge clk) begin
        if (!rst_n) begin
            shift_reg <= 8'b00000000;
        end else if (shift_en) begin
            shift_reg <= {shift_reg[6:0], data_in[0]};
        end
    end

    // 8-to-1 multiplexer
    always @(*) begin
        case (sel)
            3'b000: mux_out = shift_reg[0];
            3'b001: mux_out = shift_reg[1];
            3'b010: mux_out = shift_reg[2];
            3'b011: mux_out = shift_reg[3];
            3'b100: mux_out = shift_reg[4];
            3'b101: mux_out = shift_reg[5];
            3'b110: mux_out = shift_reg[6];
            3'b111: mux_out = shift_reg[7];
            default: mux_out = 8'b00000000; // Default case
        endcase
    end

endmodule