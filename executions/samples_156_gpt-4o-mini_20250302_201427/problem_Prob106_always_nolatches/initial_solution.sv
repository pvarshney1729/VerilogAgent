module TopModule (
    input logic [15:0] scancode,
    input logic reset_n,
    output logic left,
    output logic down,
    output logic right,
    output logic up
);

always @(*) begin
    if (!reset_n) begin
        left = 0;
        down = 0;
        right = 0;
        up = 0;
    end else begin
        case (scancode)
            16'hE06B: begin
                left = 1;
                down = 0;
                right = 0;
                up = 0;
            end
            16'hE072: begin
                left = 0;
                down = 1;
                right = 0;
                up = 0;
            end
            16'hE074: begin
                left = 0;
                down = 0;
                right = 1;
                up = 0;
            end
            16'hE075: begin
                left = 0;
                down = 0;
                right = 0;
                up = 1;
            end
            default: begin
                left = 0;
                down = 0;
                right = 0;
                up = 0;
            end
        endcase
    end
end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly