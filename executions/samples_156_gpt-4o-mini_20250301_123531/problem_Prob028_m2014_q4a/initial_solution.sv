module TopModule (
    logic d,
    logic ena,
    logic q
);
    always @(*) begin
        if (ena) begin
            q = d;
        end
        // If ena is low, q retains its previous value
    end
endmodule