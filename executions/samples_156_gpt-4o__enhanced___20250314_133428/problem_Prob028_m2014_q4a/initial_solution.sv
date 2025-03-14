module TopModule (
    input logic d,
    input logic ena,
    output logic q
);

    // Level-sensitive behavior
    always @(*) begin
        if (ena) begin
            q = d;
        end
        // else q retains its last value by default
    end

endmodule