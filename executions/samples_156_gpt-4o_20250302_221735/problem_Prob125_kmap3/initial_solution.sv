module TopModule(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);

    always @(*) begin
        case ({c, d})
            2'b00: begin
                case ({a, b})
                    2'b00: out = 1'b0;
                    2'b10: out = 1'b1;
                    2'b11: out = 1'b1;
                    default: out = 1'b0; // Don't care treated as 0
                endcase
            end
            2'b01: begin
                case ({a, b})
                    2'b01: out = 1'b0;
                    2'b00: out = 1'b0;
                    default: out = 1'b0; // Don't care treated as 0
                endcase
            end
            2'b11: begin
                case ({a, b})
                    2'b01: out = 1'b0;
                    default: out = 1'b1;
                endcase
            end
            2'b10: begin
                case ({a, b})
                    2'b01: out = 1'b0;
                    default: out = 1'b1;
                endcase
            end
            default: out = 1'b0; // Default case for safety
        endcase
    end

endmodule