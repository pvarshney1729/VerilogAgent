module TopModule (
    input wire d,
    input wire ena,
    output reg q
);

    // Initial state
    initial begin
        q = 1'b0;
    end

    // D latch behavior
    always @(*) begin
        if (ena) begin
            q = d;
        end
    end

endmodule