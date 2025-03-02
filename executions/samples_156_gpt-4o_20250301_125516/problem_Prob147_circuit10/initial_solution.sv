module TopModule (
    input logic clk,
    input logic a,
    input logic b,
    output logic q,
    output logic state
);

    always_ff @(posedge clk) begin
        case ({a, b, state})
            3'b000: state <= 1'b0;
            3'b001: state <= 1'b1;
            3'b010: state <= 1'b1;
            3'b011: state <= 1'b0;
            3'b100: state <= 1'b1;
            3'b101: state <= 1'b1;
            3'b110: state <= 1'b0;
            3'b111: state <= 1'b1;
            default: state <= 1'b0;
        endcase
    end

    always_comb begin
        case ({a, b, state})
            3'b000: q = 1'b0;
            3'b001: q = 1'b1;
            3'b010: q = 1'b0;
            3'b011: q = 1'b0;
            3'b100: q = 1'b1;
            3'b101: q = 1'b1;
            3'b110: q = 1'b1;
            3'b111: q = 1'b1;
            default: q = 1'b0;
        endcase
    end

endmodule