module TopModule(
    input logic d,
    input logic ena,
    output logic q
);
    always @(*) begin
        if (ena) begin
            q = d;
        end
        // No else needed, as q retains its value when ena is low
    end
endmodule