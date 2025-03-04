module TopModule (
    input wire d,
    input wire ena,
    output reg q
);
    always @(*) begin
        if (ena) begin
            q = d;
        end
        // No else statement needed; q retains its value when ena is low
    end
endmodule