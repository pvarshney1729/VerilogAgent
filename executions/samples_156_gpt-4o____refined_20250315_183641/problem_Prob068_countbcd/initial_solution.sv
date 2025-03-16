module TopModule (
    input logic clk,
    input logic reset,
    output logic [2:0] ena,
    output logic [15:0] q
);

    // Internal signals for each BCD digit
    logic [3:0] digit0, digit1, digit2, digit3;

    // Combinational logic to determine when to enable incrementing of higher digits
    always @(*) begin
        ena[0] = (digit0 == 4'd9);
        ena[1] = (digit1 == 4'd9) && ena[0];
        ena[2] = (digit2 == 4'd9) && ena[1];
    end

    // Sequential logic for BCD counter with synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            digit0 <= 4'd0;
            digit1 <= 4'd0;
            digit2 <= 4'd0;
            digit3 <= 4'd0;
        end else begin
            if (ena[0]) begin
                digit0 <= 4'd0;
                if (ena[1]) begin
                    digit1 <= 4'd0;
                    if (ena[2]) begin
                        digit2 <= 4'd0;
                        digit3 <= (digit3 == 4'd9) ? 4'd0 : digit3 + 4'd1;
                    end else begin
                        digit2 <= digit2 + 4'd1;
                    end
                end else begin
                    digit1 <= digit1 + 4'd1;
                end
            end else begin
                digit0 <= digit0 + 4'd1;
            end
        end
    end

    // Assign the BCD digits to the output q
    assign q = {digit3, digit2, digit1, digit0};

endmodule