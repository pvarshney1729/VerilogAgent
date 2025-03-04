module TopModule (
    input wire d,
    input wire ena,
    output reg q
);

    always @(*) begin
        if (ena) begin
            q = d;
        end
        // else: q retains its previous value
    end

endmodule