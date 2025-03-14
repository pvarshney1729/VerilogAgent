module TopModule(
    input logic d,
    input logic ena,
    output logic q
);

    always @(*) begin
        if (ena) begin
            q = d;
        end
        // When ena is low, maintain the last state of q
        // No assignment to q as it should maintain its value
    end

endmodule