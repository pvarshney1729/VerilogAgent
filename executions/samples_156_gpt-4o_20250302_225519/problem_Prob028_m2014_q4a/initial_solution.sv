module TopModule(
    input wire d,
    input wire ena,
    output reg q
);
    always @(*) begin
        if (ena) begin
            q = d;
        end
        // No else condition is needed because q retains its state when ena is low
    end
endmodule